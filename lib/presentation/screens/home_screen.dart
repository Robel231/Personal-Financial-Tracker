import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_financial_tracker/presentation/screens/goals_screen.dart';
import 'package:intl/intl.dart';
import '../../core/currency_formatter.dart';
import '../../core/ethiopian_calendar.dart';
import '../../core/localization.dart';
import '../providers/transaction_list_provider.dart';
import '../providers/category_list_provider.dart';
import '../providers/summary_provider.dart';
import '../providers/settings_provider.dart';
import '../providers/database_provider.dart';
import 'stats_screen.dart';
import 'sms_inbox_screen.dart';
import 'settings_screen.dart';
import 'add_transaction_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _selectedIndex = 0;

  void switchToTab(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(settingsProvider);
    final List<Widget> screens = [
      const _HomeTab(),
      const StatsScreen(),
      const GoalsScreen(),
      const SmsInboxScreen(),
      const SettingsScreen(),
    ];

    return Scaffold(
      body: screens[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) => setState(() => _selectedIndex = index),
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.home_outlined),
            selectedIcon: const Icon(Icons.home),
            label: AppLocalizations.get(settings.locale, 'home'),
          ),
          NavigationDestination(
            icon: const Icon(Icons.analytics_outlined),
            selectedIcon: const Icon(Icons.analytics),
            label: AppLocalizations.get(settings.locale, 'stats'),
          ),
          const NavigationDestination(
            icon: Icon(Icons.savings_outlined),
            selectedIcon: Icon(Icons.savings),
            label: 'Equb',
          ),
          NavigationDestination(
            icon: const Icon(Icons.sms_outlined),
            selectedIcon: const Icon(Icons.sms),
            label: AppLocalizations.get(settings.locale, 'sms'),
          ),
          NavigationDestination(
            icon: const Icon(Icons.settings_outlined),
            selectedIcon: const Icon(Icons.settings),
            label: AppLocalizations.get(settings.locale, 'settings'),
          ),
        ],
      ),
      floatingActionButton: _selectedIndex == 0
          ? FloatingActionButton.extended(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const AddTransactionScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.add),
              label: Text(AppLocalizations.get(settings.locale, 'addTransaction')),
            )
          : null,
    );
  }
}

// Home Tab Widget
class _HomeTab extends ConsumerWidget {
  const _HomeTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final financialSummaryAsync = ref.watch(financialSummaryProvider);
    final settings = ref.watch(settingsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.account_balance_wallet,
                color: Colors.white,
                size: 18,
              ),
            ),
            const SizedBox(width: 10),
            const Text('ብሬ',
              style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1),
            ),
          ],
        ),
        centerTitle: true,
        elevation: 0,
        actions: [
          if (settings.useEthiopianCalendar)
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context)
                        .colorScheme
                        .primaryContainer
                        .withOpacity(0.5),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    _getEthiopianDateShort(),
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
      body: Column(
        children: [
          // Top Section: Balance Card
          _buildBalanceCard(context, financialSummaryAsync, settings),
          
          const SizedBox(height: 8),

          // Quick Actions
          _buildQuickActions(context, settings),
          
          const SizedBox(height: 8),
          
          // Section Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Text(
                  AppLocalizations.get(settings.locale, 'recentTransactions'),
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {},
                  child: const Text('See All'),
                ),
              ],
            ),
          ),
          
          // Middle Section: Transaction List
          Expanded(
            child: _buildTransactionList(ref, settings),
          ),
        ],
      ),
    );
  }

  String _getEthiopianDateShort() {
    final ethDate = EthiopianDate.fromGregorian(DateTime.now());
    return '${ethDate.monthNameAmharic} ${ethDate.day}';
  }

  Widget _buildQuickActions(BuildContext context, AppSettings settings) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          _buildQuickAction(
            context,
            icon: Icons.sms,
            label: AppLocalizations.get(settings.locale, 'sms'),
            color: const Color(0xFF386641),
            onTap: () {
              // Navigate to SMS tab - find parent HomeScreen
              final homeState = context.findAncestorStateOfType<_HomeScreenState>();
              homeState?.switchToTab(2);
            },
          ),
          const SizedBox(width: 12),
          _buildQuickAction(
            context,
            icon: Icons.pie_chart,
            label: AppLocalizations.get(settings.locale, 'stats'),
            color: const Color(0xFF6a994e),
            onTap: () {
              final homeState = context.findAncestorStateOfType<_HomeScreenState>();
              homeState?.switchToTab(1);
            },
          ),
          const SizedBox(width: 12),
          _buildQuickAction(
            context,
            icon: Icons.calendar_month,
            label: AppLocalizations.get(settings.locale, 'date'),
            color: const Color(0xFFbc4749),
            onTap: () {
              _showEthiopianDateDialog(context);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildQuickAction(
    BuildContext context, {
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: color.withOpacity(0.2)),
          ),
          child: Column(
            children: [
              Icon(icon, color: color, size: 22),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  color: color,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showEthiopianDateDialog(BuildContext context) {
    final now = DateTime.now();
    final ethDate = EthiopianDate.fromGregorian(now);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Text('🇪🇹'),
            SizedBox(width: 8),
            Text('Ethiopian Calendar'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF386641), Color(0xFFa7c957), Color(0xFFbc4749)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Text(
                    ethDate.monthNameAmharic,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${ethDate.day}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 48,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    '${ethDate.year} ዓ.ም',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Gregorian: ${DateFormat('MMMM dd, yyyy').format(now)}',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
        actions: [
          FilledButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Widget _buildBalanceCard(
    BuildContext context,
    AsyncValue<FinancialSummary> summaryAsync,
    AppSettings settings,
  ) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF386641), Color(0xFF6a994e)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF4776E6).withOpacity(0.4),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: summaryAsync.when(
        data: (summary) => Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    AppLocalizations.get(settings.locale, 'totalBalance'),
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 14,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      '🇪🇹 ETB',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                CurrencyFormatter.format(summary.balance),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: _buildSummaryItem(
                      context,
                      AppLocalizations.get(settings.locale, 'income'),
                      summary.totalIncome,
                      Icons.arrow_downward,
                      const Color(0xFF38EF7D),
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 40,
                    color: Colors.white.withOpacity(0.2),
                  ),
                  Expanded(
                    child: _buildSummaryItem(
                      context,
                      AppLocalizations.get(settings.locale, 'expense'),
                      summary.totalExpense,
                      Icons.arrow_upward,
                      const Color(0xFFFF6B6B),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        loading: () => const Padding(
          padding: EdgeInsets.all(24),
          child: Center(child: CircularProgressIndicator(color: Colors.white)),
        ),
        error: (error, stack) => Padding(
          padding: const EdgeInsets.all(24),
          child: Text('Error: $error', style: const TextStyle(color: Colors.white)),
        ),
      ),
    );
  }

  Widget _buildSummaryItem(
    BuildContext context,
    String label,
    double amount,
    IconData icon,
    Color color,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 16),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 12,
                  ),
                ),
                Text(
                  CurrencyFormatter.format(amount, useShort: true),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionList(WidgetRef ref, AppSettings settings) {
    final transactionsAsync = ref.watch(transactionListProvider);
    final categoriesAsync = ref.watch(categoryListProvider);

    return categoriesAsync.when(
      data: (categories) => transactionsAsync.when(
        data: (transactions) {
          if (transactions.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.receipt_long_outlined,
                      size: 48,
                      color: Colors.grey[400],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No transactions yet',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    AppLocalizations.get(settings.locale, 'noTransactions'),
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: transactions.length,
            itemBuilder: (context, index) {
              if (categories.isEmpty) {
                return const Center(child: Text('Loading categories...'));
              }
              
              final transaction = transactions[index];
              final category = categories.firstWhere(
                (cat) => cat.id == transaction.categoryId,
                orElse: () => categories.first,
              );

              return Dismissible(
                key: Key(transaction.id),
                direction: DismissDirection.endToStart,
                background: Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 20),
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: Colors.red.shade400,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                confirmDismiss: (direction) async {
                  return await showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Delete Transaction'),
                      content: const Text(
                        'Are you sure you want to delete this transaction?',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, false),
                          child: const Text('Cancel'),
                        ),
                        FilledButton(
                          onPressed: () => Navigator.pop(context, true),
                          style: FilledButton.styleFrom(
                            backgroundColor: Colors.red,
                          ),
                          child: const Text('Delete'),
                        ),
                      ],
                    ),
                  );
                },
                onDismissed: (_) async {
                  final repository = ref.read(transactionRepositoryProvider);
                  await repository.deleteTransaction(transaction.id);
                  // Invalidate all providers for instant refresh
                  ref.invalidate(financialSummaryProvider);
                  ref.invalidate(totalIncomeProvider);
                  ref.invalidate(totalExpenseProvider);
                  ref.invalidate(totalBalanceProvider);
                  ref.invalidate(transactionListProvider);
                  ref.invalidate(allTransactionsProvider);
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Theme.of(context).colorScheme.outlineVariant.withOpacity(0.5),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.03),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => AddTransactionScreen(
                            existingTransaction: transaction,
                            existingCategory: category,
                          ),
                        ),
                      );
                    },
                    child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    leading: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Color(category.colorCode).withOpacity(0.15),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Icon(
                        IconData(
                          category.iconCode,
                          fontFamily: 'MaterialIcons',
                        ),
                        color: Color(category.colorCode),
                        size: 24,
                      ),
                    ),
                    title: Text(
                      transaction.note,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                    subtitle: Text(
                      '${category.name} • ${_formatDate(transaction.date, settings)}',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
                    ),
                    trailing: Text(
                      CurrencyFormatter.formatWithSign(
                        transaction.amount,
                        isExpense: category.isExpense,
                      ),
                      style: TextStyle(
                        color: category.isExpense
                            ? const Color(0xFFEB3349)
                            : const Color(0xFF11998E),
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  ),
                  ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text('Error loading transactions: $error'),
        ),
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(
        child: Text('Error loading categories: $error'),
      ),
    );
  }

  String _formatDate(DateTime date, AppSettings settings) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final transactionDate = DateTime(date.year, date.month, date.day);

    if (transactionDate == today) {
      return 'Today';
    } else if (transactionDate == yesterday) {
      return 'Yesterday';
    } else if (settings.useEthiopianCalendar) {
      final ethDate = EthiopianDate.fromGregorian(date);
      return '${ethDate.monthNameAmharic} ${ethDate.day}';
    } else {
      return DateFormat('MMM dd, yyyy').format(date);
    }
  }
}
