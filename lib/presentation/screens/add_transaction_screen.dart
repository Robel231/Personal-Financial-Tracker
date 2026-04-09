import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import '../../domain/entities/transaction.dart' as entity;
import '../../domain/entities/category.dart' as entity;
import '../providers/database_provider.dart';
import '../providers/category_list_provider.dart';
import '../providers/summary_provider.dart';
import '../providers/transaction_list_provider.dart';


class AddTransactionScreen extends ConsumerStatefulWidget {
  /// Pass an existing transaction to edit it. If null, creates a new transaction.
  final entity.Transaction? existingTransaction;
  /// When editing, the category of the existing transaction (to pre-select type).
  final entity.Category? existingCategory;

  const AddTransactionScreen({
    super.key,
    this.existingTransaction,
    this.existingCategory,
  });

  @override
  ConsumerState<AddTransactionScreen> createState() =>
      _AddTransactionScreenState();
}

class _AddTransactionScreenState extends ConsumerState<AddTransactionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _noteController = TextEditingController();

  bool _isExpense = true;
  DateTime _selectedDate = DateTime.now();
  entity.Category? _selectedCategory;
  bool _isLoading = false;

  bool get _isEditing => widget.existingTransaction != null;

  @override
  void initState() {
    super.initState();
    if (_isEditing) {
      final tx = widget.existingTransaction!;
      _amountController.text = tx.amount.toStringAsFixed(2);
      _noteController.text = tx.note == 'No description' ? '' : tx.note;
      _selectedDate = tx.date;
      if (widget.existingCategory != null) {
        _isExpense = widget.existingCategory!.isExpense;
        _selectedCategory = widget.existingCategory;
      }
    }
  }

  @override
  void dispose() {
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  /// Invalidate all data providers so the UI refreshes instantly
  void _invalidateProviders() {
    ref.invalidate(financialSummaryProvider);
    ref.invalidate(totalIncomeProvider);
    ref.invalidate(totalExpenseProvider);
    ref.invalidate(totalBalanceProvider);
    ref.invalidate(transactionListProvider);
    ref.invalidate(allTransactionsProvider);
    ref.invalidate(allCategoriesProvider);
  }

  Future<void> _saveTransaction() async {
    if (!_formKey.currentState!.validate()) return;

    if (_selectedCategory == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a category'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final repository = ref.read(transactionRepositoryProvider);

      final transaction = entity.Transaction(
        id: _isEditing ? widget.existingTransaction!.id : const Uuid().v4(),
        amount: double.parse(_amountController.text),
        date: _selectedDate,
        note: _noteController.text.trim().isEmpty
            ? 'No description'
            : _noteController.text.trim(),
        categoryId: _selectedCategory!.id,
      );

      if (_isEditing) {
        await repository.updateTransaction(transaction);
      } else {
        await repository.insertTransaction(transaction);
      }

      // Invalidate providers BEFORE popping so listeners rebuild
      _invalidateProviders();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              _isEditing
                  ? 'Transaction updated successfully!'
                  : 'Transaction added successfully!',
            ),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 2),
          ),
        );
        Navigator.pop(context, true); // return true to signal mutation
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _deleteTransaction() async {
    if (!_isEditing) return;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Transaction'),
        content: const Text(
          'Are you sure you want to delete this transaction? This cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    setState(() => _isLoading = true);
    try {
      final repository = ref.read(transactionRepositoryProvider);
      await repository.deleteTransaction(widget.existingTransaction!.id);
      _invalidateProviders();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Transaction deleted'),
            backgroundColor: Colors.orange,
            duration: Duration(seconds: 2),
          ),
        );
        Navigator.pop(context, true);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final categoriesAsync = ref.watch(categoryListProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Edit Transaction' : 'Add Transaction'),
        centerTitle: true,
        actions: [
          if (_isEditing)
            IconButton(
              icon: const Icon(Icons.delete_outline, color: Colors.red),
              tooltip: 'Delete',
              onPressed: _isLoading ? null : _deleteTransaction,
            ),
        ],
      ),
      body: categoriesAsync.when(
        data: (categories) {
          final filteredCategories = categories
              .where((cat) => cat.isExpense == _isExpense)
              .toList();

          // Auto-select first category if current selection doesn't match type
          if (_selectedCategory == null ||
              _selectedCategory!.isExpense != _isExpense) {
            if (filteredCategories.isNotEmpty) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (mounted) {
                  setState(() {
                    _selectedCategory = filteredCategories.first;
                  });
                }
              });
            }
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Income / Expense Toggle
                  _buildTransactionTypeToggle(),
                  const SizedBox(height: 24),

                  // Amount
                  _buildAmountField(),
                  const SizedBox(height: 16),

                  // Note
                  _buildNoteField(),
                  const SizedBox(height: 16),

                  // Date
                  _buildDatePicker(),
                  const SizedBox(height: 24),

                  // Category
                  _buildCategorySection(filteredCategories),
                  const SizedBox(height: 32),

                  // Save / Update Button
                  _buildSaveButton(),

                  if (_isEditing) ...[
                    const SizedBox(height: 12),
                    _buildDeleteButton(),
                  ],
                ],
              ),
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text('Error loading categories: $error'),
        ),
      ),
    );
  }

  Widget _buildTransactionTypeToggle() {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _isExpense = true),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: _isExpense
                      ? const Color(0xFFbc4749).withOpacity(0.9)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.arrow_downward,
                      color: _isExpense ? Colors.white : const Color(0xFFbc4749),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Expense',
                      style: TextStyle(
                        color: _isExpense ? Colors.white : const Color(0xFFbc4749),
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _isExpense = false),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: !_isExpense
                      ? const Color(0xFF6a994e).withOpacity(0.9)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.arrow_upward,
                      color: !_isExpense ? Colors.white : const Color(0xFF6a994e),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Income',
                      style: TextStyle(
                        color: !_isExpense ? Colors.white : const Color(0xFF6a994e),
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAmountField() {
    return TextFormField(
      controller: _amountController,
      autofocus: !_isEditing,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
      ],
      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      decoration: InputDecoration(
        labelText: 'Amount',
        prefixText: 'ETB  ',
        prefixIcon: const Icon(Icons.money),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) return 'Please enter an amount';
        final amount = double.tryParse(value);
        if (amount == null || amount <= 0) return 'Enter a valid amount';
        return null;
      },
    );
  }

  Widget _buildNoteField() {
    return TextFormField(
      controller: _noteController,
      decoration: InputDecoration(
        labelText: 'Note / Description',
        prefixIcon: const Icon(Icons.note_alt_outlined),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
        hintText: 'Optional',
      ),
      maxLines: 2,
    );
  }

  Widget _buildDatePicker() {
    return InkWell(
      onTap: () => _selectDate(context),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).colorScheme.outline),
          borderRadius: BorderRadius.circular(12),
          color: Theme.of(context).colorScheme.surface,
        ),
        child: Row(
          children: [
            Icon(
              Icons.calendar_today,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Date',
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  DateFormat('EEEE, MMMM dd, yyyy').format(_selectedDate),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategorySection(List<entity.Category> categories) {
    if (categories.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.orange.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.orange),
        ),
        child: Column(
          children: [
            const Icon(Icons.warning_amber, color: Colors.orange, size: 32),
            const SizedBox(height: 8),
            Text(
              'No ${_isExpense ? 'expense' : 'income'} categories available',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Category',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              final isSelected = _selectedCategory?.id == category.id;

              return GestureDetector(
                onTap: () => setState(() => _selectedCategory = category),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 90,
                  margin: const EdgeInsets.only(right: 12),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Color(category.colorCode)
                        : Color(category.colorCode).withOpacity(0.15),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: Color(category.colorCode),
                      width: isSelected ? 3 : 1,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        IconData(
                          category.iconCode,
                          fontFamily: 'MaterialIcons',
                        ),
                        color: isSelected
                            ? Colors.white
                            : Color(category.colorCode),
                        size: 32,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        category.name,
                        style: TextStyle(
                          color: isSelected
                              ? Colors.white
                              : Color(category.colorCode),
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSaveButton() {
    return FilledButton.icon(
      onPressed: _isLoading ? null : _saveTransaction,
      icon: _isLoading
          ? const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.white,
              ),
            )
          : Icon(_isEditing ? Icons.save : Icons.check),
      label: Text(
        _isLoading
            ? 'Saving...'
            : _isEditing
                ? 'Update Transaction'
                : 'Save Transaction',
      ),
      style: FilledButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  Widget _buildDeleteButton() {
    return OutlinedButton.icon(
      onPressed: _isLoading ? null : _deleteTransaction,
      icon: const Icon(Icons.delete_outline, color: Colors.red),
      label: const Text('Delete Transaction', style: TextStyle(color: Colors.red)),
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        side: const BorderSide(color: Colors.red),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
