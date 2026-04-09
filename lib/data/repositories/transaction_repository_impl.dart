import 'package:drift/drift.dart';
import '../../domain/entities/transaction.dart' as entity;
import '../../domain/entities/category.dart' as entity;
import '../../domain/repositories/transaction_repository.dart';
import '../database/app_database.dart';

/// Implementation of TransactionRepository using Drift database
class TransactionRepositoryImpl implements TransactionRepository {
  final AppDatabase _database;

  TransactionRepositoryImpl(this._database);

  // ==================== Transaction Methods ====================

  @override
  Stream<List<entity.Transaction>> watchAllTransactions() {
    return _database.watchAllTransactions().map((dbTransactions) {
      return dbTransactions
          .map((dbTransaction) => _mapDbTransactionToEntity(dbTransaction))
          .toList();
    });
  }

  @override
  Future<List<entity.Transaction>> getAllTransactions() async {
    final dbTransactions = await _database.getAllTransactions();
    return dbTransactions
        .map((dbTransaction) => _mapDbTransactionToEntity(dbTransaction))
        .toList();
  }

  @override
  Future<void> insertTransaction(entity.Transaction transaction) async {
    final companion = TransactionsCompanion(
      id: Value(transaction.id),
      amount: Value(transaction.amount),
      date: Value(transaction.date),
      note: Value(transaction.note),
      categoryId: Value(transaction.categoryId),
    );
    await _database.insertTransaction(companion);
  }

  @override
  Future<void> deleteTransaction(String id) async {
    await _database.deleteTransaction(id);
  }

  @override
  Future<void> updateTransaction(entity.Transaction transaction) async {
    final companion = TransactionsCompanion(
      id: Value(transaction.id),
      amount: Value(transaction.amount),
      date: Value(transaction.date),
      note: Value(transaction.note),
      categoryId: Value(transaction.categoryId),
    );
    await _database.updateTransaction(companion);
  }

  @override
  Future<double> getTotalBalance() async {
    return await _database.getTotalBalance();
  }

  @override
  Future<double> getTotalIncome() async {
    return await _database.getTotalIncome();
  }

  @override
  Future<double> getTotalExpenses() async {
    return await _database.getTotalExpenses();
  }

  // ==================== Category Methods ====================

  @override
  Stream<List<entity.Category>> watchAllCategories() {
    return _database.watchAllCategories().map((dbCategories) {
      return dbCategories
          .map((dbCategory) => _mapDbCategoryToEntity(dbCategory))
          .toList();
    });
  }

  @override
  Future<List<entity.Category>> getAllCategories() async {
    final dbCategories = await _database.getAllCategories();
    return dbCategories
        .map((dbCategory) => _mapDbCategoryToEntity(dbCategory))
        .toList();
  }

  @override
  Future<void> insertCategory(entity.Category category) async {
    final companion = CategoriesCompanion(
      id: Value(category.id),
      name: Value(category.name),
      iconCode: Value(category.iconCode),
      colorCode: Value(category.colorCode),
      isExpense: Value(category.isExpense),
    );
    await _database.insertCategory(companion);
  }

  @override
  Future<void> deleteCategory(String id) async {
    await _database.deleteCategory(id);
  }

  @override
  Future<void> updateCategory(entity.Category category) async {
    final companion = CategoriesCompanion(
      id: Value(category.id),
      name: Value(category.name),
      iconCode: Value(category.iconCode),
      colorCode: Value(category.colorCode),
      isExpense: Value(category.isExpense),
      monthlyBudget: Value(category.monthlyBudget),
    );
    await _database.updateCategory(companion);
  }

  // ==================== Mapping Methods ====================

  /// Maps Drift Transaction to Domain Entity Transaction
  entity.Transaction _mapDbTransactionToEntity(Transaction dbTransaction) {
    return entity.Transaction(
      id: dbTransaction.id,
      amount: dbTransaction.amount,
      date: dbTransaction.date,
      note: dbTransaction.note,
      categoryId: dbTransaction.categoryId,
    );
  }

  /// Maps Drift Category to Domain Entity Category
  entity.Category _mapDbCategoryToEntity(Category dbCategory) {
    return entity.Category(
      id: dbCategory.id,
      name: dbCategory.name,
      iconCode: dbCategory.iconCode,
      colorCode: dbCategory.colorCode,
      isExpense: dbCategory.isExpense,
      monthlyBudget: dbCategory.monthlyBudget,
    );
  }
}
