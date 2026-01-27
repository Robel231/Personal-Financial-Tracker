import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/transaction.dart';
import '../../domain/entities/category.dart';
import 'database_provider.dart';

part 'spending_by_category_provider.freezed.dart';
part 'spending_by_category_provider.g.dart';

/// Model to hold category spending data
@freezed
class CategorySpending with _$CategorySpending {
  const factory CategorySpending({
    required Category category,
    required double totalAmount,
    required int transactionCount,
    required double percentage,
  }) = _CategorySpending;
}

/// Provider to get spending by category for a specific month and year
@riverpod
Future<List<CategorySpending>> spendingByCategory(
  SpendingByCategoryRef ref, {
  required int month,
  required int year,
  required bool isExpense,
}) async {
  final repository = ref.watch(transactionRepositoryProvider);
  
  // Get all transactions and categories
  final allTransactions = await repository.getAllTransactions();
  final allCategories = await repository.getAllCategories();
  
  // Filter transactions by month, year, and type
  final filteredTransactions = allTransactions.where((transaction) {
    final category = allCategories.firstWhere(
      (cat) => cat.id == transaction.categoryId,
      orElse: () => allCategories.first,
    );
    
    return transaction.date.month == month &&
        transaction.date.year == year &&
        category.isExpense == isExpense;
  }).toList();
  
  // Group by category and calculate totals
  final Map<String, double> categoryTotals = {};
  final Map<String, int> categoryCount = {};
  
  for (final transaction in filteredTransactions) {
    final categoryId = transaction.categoryId;
    categoryTotals[categoryId] = 
        (categoryTotals[categoryId] ?? 0) + transaction.amount;
    categoryCount[categoryId] = (categoryCount[categoryId] ?? 0) + 1;
  }
  
  // Calculate total for percentage
  final total = categoryTotals.values.fold(0.0, (sum, amount) => sum + amount);
  
  // Create CategorySpending objects
  final List<CategorySpending> result = [];
  
  for (final entry in categoryTotals.entries) {
    final category = allCategories.firstWhere(
      (cat) => cat.id == entry.key,
      orElse: () => allCategories.first,
    );
    
    result.add(CategorySpending(
      category: category,
      totalAmount: entry.value,
      transactionCount: categoryCount[entry.key] ?? 0,
      percentage: total > 0 ? (entry.value / total) * 100 : 0,
    ));
  }
  
  // Sort by total amount descending
  result.sort((a, b) => b.totalAmount.compareTo(a.totalAmount));
  
  return result;
}

/// Provider to get total spending for a specific month and year
@riverpod
Future<double> monthlyTotal(
  MonthlyTotalRef ref, {
  required int month,
  required int year,
  required bool isExpense,
}) async {
  final spendingData = await ref.watch(
    spendingByCategoryProvider(
      month: month,
      year: year,
      isExpense: isExpense,
    ).future,
  );
  
  return spendingData.fold<double>(0.0, (sum, item) => sum + item.totalAmount);
}
