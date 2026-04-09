import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';
import '../../core/sms_parser.dart';
import '../../core/currency_formatter.dart';
import '../../domain/entities/transaction.dart' as entity;
import '../../domain/entities/category.dart' as entity;
import '../providers/database_provider.dart';
import '../providers/category_list_provider.dart';

/// SMS Transaction Inbox – shows parsed SMS messages and lets users confirm/save
class SmsInboxScreen extends ConsumerStatefulWidget {
  const SmsInboxScreen({super.key});

  @override
  ConsumerState<SmsInboxScreen> createState() => _SmsInboxScreenState();
}

class _SmsInboxScreenState extends ConsumerState<SmsInboxScreen> {
  final SmsQuery _query = SmsQuery();
  List<_SmsMessage> _smsMessages = [];
  bool _isLoading = true;
  bool _hasPermission = false;
  late SharedPreferences _prefs;

  final Set<int> _savedIndices = {};
  List<String> _processedSmsKeys = [];

  // Selection mode
  final Set<int> _selectedIndices = {};
  bool get _isSelectionMode => _selectedIndices.isNotEmpty;

  void _toggleSelection(int index) {
    setState(() {
      if (_selectedIndices.contains(index)) {
        _selectedIndices.remove(index);
      } else {
        _selectedIndices.add(index);
      }
    });
  }

  void _clearSelection() {
    setState(() {
      _selectedIndices.clear();
    });
  }

  Future<void> _bulkSave() async {
    final List<int> sortedIndices = _selectedIndices.toList()..sort();
    int successCount = 0;
    
    for (int index in sortedIndices) {
       final sms = _smsMessages[index];
       final parsed = SmsParser.parseSms(sms.sender, sms.body);
       if (parsed != null && !_savedIndices.contains(index)) {
          try {
             await _saveTransactionSilent(parsed, sms, index);
             successCount++;
          } catch(e) {
             print("Bulk save error: $e");
          }
       }
    }
    
    if (mounted && successCount > 0) {
       ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Successfully saved $successCount transactions!'), backgroundColor: const Color(0xFF6a994e)),
       );
    }
    _clearSelection();
  }

  Future<void> _bulkDismiss() async {
    final List<int> sortedIndices = _selectedIndices.toList()..sort((a,b) => b.compareTo(a));
    
    setState(() {
      for (int index in sortedIndices) {
        final sms = _smsMessages[index];
        _processedSmsKeys.add(sms.uniqueKey);
        _smsMessages.removeAt(index);
      }
    });
    
    await _prefs.setStringList('processed_sms', _processedSmsKeys);
    
    if (mounted) {
       ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Selected messages dismissed.')),
       );
    }
    _clearSelection();
  }

  @override
  void initState() {
    super.initState();
    _initPrefsAndFetch();
  }

  Future<void> _initPrefsAndFetch() async {
    _prefs = await SharedPreferences.getInstance();
    _processedSmsKeys = _prefs.getStringList('processed_sms') ?? [];
    _checkPermissionAndFetch();
  }

  Future<void> _checkPermissionAndFetch() async {
    final status = await Permission.sms.request();
    if (status.isGranted) {
      if (mounted) {
        setState(() {
          _hasPermission = true;
        });
        _fetchSms();
      }
    } else {
      if (mounted) {
        setState(() {
          _hasPermission = false;
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _fetchSms() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final messages = await _query.querySms(kinds: [SmsQueryKind.inbox], sort: true);
      
      final List<_SmsMessage> recentMessages = [];
      for (var msg in messages) {
        if (msg.date == null || msg.body == null || msg.address == null) continue;
        
        // Skip messages older than 30 days
        if (msg.date!.isBefore(DateTime.now().subtract(const Duration(days: 30)))) continue;

        // Skip messages we've already processed (saved or dismissed)
        final uniqueKey = '${msg.address}_${msg.date!.millisecondsSinceEpoch}';
        if (_processedSmsKeys.contains(uniqueKey)) continue;

        recentMessages.add(_SmsMessage(
          sender: msg.address!,
          body: msg.body!,
          date: msg.date!,
          uniqueKey: uniqueKey,
        ));
      }

      if (mounted) {
        setState(() {
          _smsMessages = recentMessages;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error reading SMS: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Grouping valid parsed SMS for display count
    int validSmsCount = 0;
    for (var sms in _smsMessages) {
      if (SmsParser.parseSms(sms.sender, sms.body) != null) {
        validSmsCount++;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('SMS Transactions'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => _checkPermissionAndFetch(),
          ),
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () => _showInfoDialog(context),
          ),
        ],
      ),
      body: _buildBody(theme, validSmsCount),
      bottomNavigationBar: _isSelectionMode
          ? SafeArea(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -5)),
                  ],
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: _clearSelection,
                    ),
                    Text('${_selectedIndices.length} Selected', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    const Spacer(),
                    TextButton(
                      onPressed: _bulkDismiss,
                      child: const Text('Dismiss', style: TextStyle(color: Colors.red)),
                    ),
                    const SizedBox(width: 8),
                    FilledButton(
                      onPressed: _bulkSave,
                      style: FilledButton.styleFrom(backgroundColor: const Color(0xFF6a994e)),
                      child: const Text('Save'),
                    ),
                  ],
                ),
              ),
            )
          : null,
    );
  }

  Widget _buildBody(ThemeData theme, int validSmsCount) {
    if (_isLoading) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Scanning SMS inbox...'),
          ],
        ),
      );
    }

    if (!_hasPermission) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.sms_failed_outlined, size: 64, color: Colors.grey[400]),
            const SizedBox(height: 16),
            const Text(
              'SMS Permission Required',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                'We need access to your SMS inbox to automatically detect bank transactions from Telebirr, CBE, etc.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: _checkPermissionAndFetch,
              child: const Text('Grant Permission'),
            ),
          ],
        ),
      );
    }

    if (validSmsCount == 0) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.inbox_outlined, size: 64, color: Colors.grey[400]),
            const SizedBox(height: 16),
            const Text(
              'No Bank SMS Found',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Waiting for new transactions...',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        // Header
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF386641), Color(0xFF6a994e)],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.sms, color: Colors.white, size: 24),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Smart SMS Detection',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '$validSmsCount transactions detected from bank SMS',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // SMS List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _smsMessages.length,
              itemBuilder: (context, index) {
                final sms = _smsMessages[index];
                final parsed = SmsParser.parseSms(sms.sender, sms.body);
                final isSaved = _savedIndices.contains(index);

                if (parsed == null) return const SizedBox.shrink();

                return _buildSmsCard(
                    context, sms, parsed, index, isSaved, theme);
              },
            ),
          ),
        ],
      );
  }

  Widget _buildSmsCard(
    BuildContext context,
    _SmsMessage sms,
    ParsedTransaction parsed,
    int index,
    bool isSaved,
    ThemeData theme,
  ) {
    final senderCategory = SmsParser.getSenderCategory(sms.sender);
    final isSelected = _selectedIndices.contains(index);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF6a994e).withOpacity(0.1) : theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isSelected 
              ? const Color(0xFF6a994e)
              : (isSaved ? const Color(0xFF6a994e).withOpacity(0.5) : theme.colorScheme.outlineVariant),
          width: isSelected || isSaved ? 2 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onLongPress: () => _toggleSelection(index),
        onTap: () async {
          if (_isSelectionMode) {
            _toggleSelection(index);
            return;
          }
          final Uri smsUri = Uri(
            scheme: 'sms',
            path: sms.sender,
          );
          if (await canLaunchUrl(smsUri)) {
            await launchUrl(smsUri);
          }
        },
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: parsed.isIncome
                        ? const Color(0xFF6a994e).withOpacity(0.15)
                        : const Color(0xFFbc4749).withOpacity(0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    parsed.isIncome
                        ? Icons.arrow_downward
                        : Icons.arrow_upward,
                    color: parsed.isIncome ? const Color(0xFF6a994e) : const Color(0xFFbc4749),
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        senderCategory,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        parsed.isIncome ? 'Income' : 'Expense',
                        style: TextStyle(
                          color: parsed.isIncome ? const Color(0xFF6a994e) : const Color(0xFFbc4749),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  '${parsed.isIncome ? '+' : '-'} ${CurrencyFormatter.format(parsed.amount, useShort: true)}',
                  style: TextStyle(
                    color: parsed.isIncome ? const Color(0xFF6a994e) : const Color(0xFFbc4749),
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
              ],
            ),
          ),

          // SMS body preview
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              sms.body,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
                height: 1.4,
              ),
            ),
          ),

          if (parsed.balance != null)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
              child: Row(
                children: [
                  Icon(Icons.account_balance_wallet,
                      size: 14, color: Colors.grey[500]),
                  const SizedBox(width: 4),
                  Text(
                    'Balance: ${CurrencyFormatter.format(parsed.balance!, useShort: true)}',
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),

          // Action buttons
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (isSaved)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF6a994e).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.check_circle, color: Color(0xFF6a994e), size: 16),
                        SizedBox(width: 4),
                        Text(
                          'Saved',
                          style: TextStyle(
                            color: Color(0xFF6a994e),
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  )
                else ...[
                  TextButton(
                    onPressed: () async {
                      // Mark as processed so it doesn't show up again
                      _processedSmsKeys.add(sms.uniqueKey);
                      await _prefs.setStringList('processed_sms', _processedSmsKeys);
                      
                      // Dismiss the SMS from list
                      setState(() {
                        _smsMessages.removeAt(index);
                      });
                    },
                    child: const Text('Dismiss'),
                  ),
                  const SizedBox(width: 8),
                  FilledButton.icon(
                    onPressed: () =>
                        _saveTransaction(context, parsed, sms, index),
                    icon: const Icon(Icons.add, size: 18),
                    label: const Text('Save'),
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
      ),
    );
  }

  Future<void> _saveTransaction(
    BuildContext context,
    ParsedTransaction parsed,
    _SmsMessage sms,
    int index,
  ) async {
    try {
      final repository = ref.read(transactionRepositoryProvider);
      final categories = await ref.read(categoryListProvider.future);

      if (categories.isEmpty) {
        throw Exception('No categories available yet. Try again.');
      }
      
      final senderCategory = SmsParser.getSenderCategory(sms.sender);

      entity.Category? matchedCategory;
      for (final cat in categories) {
        if (cat.name.toLowerCase().contains(senderCategory.toLowerCase()) &&
            cat.isExpense != parsed.isIncome) {
          matchedCategory = cat;
          break;
        }
      }

      // Fallback to first category of the right type without using firstWhere which throws
      if (matchedCategory == null) {
        for (final cat in categories) {
          if (cat.isExpense != parsed.isIncome) {
            matchedCategory = cat;
            break;
          }
        }
      }
      
      // Ultimate fallback
      matchedCategory ??= categories.first;

      final transaction = entity.Transaction(
        id: const Uuid().v4(),
        amount: parsed.amount,
        date: sms.date,
        note: parsed.description,
        categoryId: matchedCategory.id,
      );

      await repository.insertTransaction(transaction);

      // Mark as processed
      _processedSmsKeys.add(sms.uniqueKey);
      await _prefs.setStringList('processed_sms', _processedSmsKeys);

      setState(() {
        _savedIndices.add(index);
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              '${parsed.isIncome ? 'Income' : 'Expense'} of ${CurrencyFormatter.format(parsed.amount, useShort: true)} saved!',
            ),
            backgroundColor: const Color(0xFF6a994e),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _saveTransactionSilent(
    ParsedTransaction parsed,
    _SmsMessage sms,
    int index,
  ) async {
    final repository = ref.read(transactionRepositoryProvider);
    final categories = await ref.read(categoryListProvider.future);

    if (categories.isEmpty) throw Exception('No categories available.');
    
    final senderCategory = SmsParser.getSenderCategory(sms.sender);

    entity.Category? matchedCategory;
    for (final cat in categories) {
      if (cat.name.toLowerCase().contains(senderCategory.toLowerCase()) &&
          cat.isExpense != parsed.isIncome) {
        matchedCategory = cat;
        break;
      }
    }

    if (matchedCategory == null) {
      for (final cat in categories) {
        if (cat.isExpense != parsed.isIncome) {
          matchedCategory = cat;
          break;
        }
      }
    }
    
    matchedCategory ??= categories.first;

    final transaction = entity.Transaction(
      id: const Uuid().v4(),
      amount: parsed.amount,
      date: sms.date,
      note: parsed.description,
      categoryId: matchedCategory.id,
    );

    await repository.insertTransaction(transaction);

    _processedSmsKeys.add(sms.uniqueKey);
    await _prefs.setStringList('processed_sms', _processedSmsKeys);

    setState(() {
      _savedIndices.add(index);
    });
  }

  void _showInfoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.sms, color: Color(0xFF667EEA)),
            SizedBox(width: 8),
            Text('SMS Auto-Detection'),
          ],
        ),
        content: const Text(
          'This feature automatically detects financial transactions from your bank SMS messages.\n\n'
          'Supported banks:\n'
          '• Telebirr\n'
          '• Commercial Bank of Ethiopia (CBE)\n'
          '• Awash Bank\n'
          '• Dashen Bank\n'
          '• Bank of Abyssinia\n'
          '• And more...\n\n'
          'Review each transaction and tap "Save" to add it to your tracker.',
        ),
        actions: [
          FilledButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Got it'),
          ),
        ],
      ),
    );
  }
}

/// Internal SMS message model
class _SmsMessage {
  final String sender;
  final String body;
  final DateTime date;
  final String uniqueKey;

  const _SmsMessage({
    required this.sender,
    required this.body,
    required this.date,
    required this.uniqueKey,
  });
}
