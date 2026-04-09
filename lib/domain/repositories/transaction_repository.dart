import '../entities/transaction.dart' as entity;
import '../entities/category.dart' as entity;

/// Repository interface for transaction operations
abstract class TransactionRepository {
  /// Watch all transactions as a stream
  Stream<List<entity.Transaction>> watchAllTransactions();

  /// Get all transactions
  Future<List<entity.Transaction>> getAllTransactions();

  /// Insert a new transaction
  Future<void> insertTransaction(entity.Transaction transaction);

  /// Delete a transaction by ID
  Future<void> deleteTransaction(String id);

  /// Update an existing transaction
  Future<void> updateTransaction(entity.Transaction transaction);

  /// Get total balance (income - expense)
  Future<double> getTotalBalance();

  /// Get total income
  Future<double> getTotalIncome();

  /// Get total expenses
  Future<double> getTotalExpenses();

  /// Watch all categories as a stream
  Stream<List<entity.Category>> watchAllCategories();

  /// Get all categories
  Future<List<entity.Category>> getAllCategories();

  /// Insert a new category
  Future<void> insertCategory(entity.Category category);

  /// Delete a category by ID
  Future<void> deleteCategory(String id);

  /// Update a category
  Future<void> updateCategory(entity.Category category);
}
