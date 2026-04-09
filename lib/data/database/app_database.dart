import 'package:drift/drift.dart';
import 'tables.dart';
import 'connection/connection.dart'
    if (dart.library.io) 'connection/native.dart'
    if (dart.library.html) 'connection/web.dart'
    if (dart.library.js_interop) 'connection/web.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [Categories, Transactions, Goals])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(openConnection());

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        if (from < 2) {
          await m.addColumn(categories, categories.monthlyBudget);
          await m.createTable(goals);
        }
      },
    );
  }

  // ==================== Category Methods ====================
  
  /// Get all categories as a stream
  Stream<List<Category>> watchAllCategories() => select(categories).watch();

  /// Get all categories
  Future<List<Category>> getAllCategories() => select(categories).get();

  /// Insert a category
  Future<int> insertCategory(CategoriesCompanion category) =>
      into(categories).insert(category);

  /// Update an existing category
  Future<bool> updateCategory(CategoriesCompanion category) =>
      update(categories).replace(category);

  /// Delete a category
  Future<int> deleteCategory(String id) =>
      (delete(categories)..where((tbl) => tbl.id.equals(id))).go();

  // ==================== Transaction Methods ====================

  /// Insert a transaction
  Future<int> insertTransaction(TransactionsCompanion transaction) =>
      into(transactions).insert(transaction);

  /// Delete a transaction
  Future<int> deleteTransaction(String id) =>
      (delete(transactions)..where((tbl) => tbl.id.equals(id))).go();

  /// Update a transaction
  Future<bool> updateTransaction(TransactionsCompanion transaction) =>
      update(transactions).replace(transaction);

  /// Get all transactions as a stream (ordered by date descending)
  Stream<List<Transaction>> watchAllTransactions() =>
      (select(transactions)..orderBy([(t) => OrderingTerm.desc(t.date)]))
          .watch();

  /// Get all transactions
  Future<List<Transaction>> getAllTransactions() =>
      (select(transactions)..orderBy([(t) => OrderingTerm.desc(t.date)]))
          .get();

  /// Get transactions with category details (JOIN query)
  Stream<List<TransactionWithCategory>> watchTransactionsWithCategories() {
    final query = select(transactions).join([
      leftOuterJoin(categories, categories.id.equalsExp(transactions.categoryId))
    ])..orderBy([OrderingTerm.desc(transactions.date)]);

    return query.watch().map((rows) {
      return rows.map((row) {
        return TransactionWithCategory(
          transaction: row.readTable(transactions),
          category: row.readTableOrNull(categories),
        );
      }).toList();
    });
  }

  /// Get total balance (income - expense)
  Future<double> getTotalBalance() async {
    final allTransactions = await getAllTransactions();
    final allCategories = await getAllCategories();

    double balance = 0.0;

    for (final transaction in allTransactions) {
      final category = allCategories.firstWhere(
        (cat) => cat.id == transaction.categoryId,
        orElse: () => Category(
          id: '',
          name: '',
          iconCode: 0,
          colorCode: 0,
          isExpense: true,
        ),
      );

      if (category.isExpense) {
        balance -= transaction.amount;
      } else {
        balance += transaction.amount;
      }
    }

    return balance;
  }

  /// Get total income
  Future<double> getTotalIncome() async {
    final allTransactions = await getAllTransactions();
    final allCategories = await getAllCategories();

    double income = 0.0;

    for (final transaction in allTransactions) {
      final category = allCategories.firstWhere(
        (cat) => cat.id == transaction.categoryId,
        orElse: () => Category(
          id: '',
          name: '',
          iconCode: 0,
          colorCode: 0,
          isExpense: true,
        ),
      );

      if (!category.isExpense) {
        income += transaction.amount;
      }
    }

    return income;
  }

  /// Get total expenses
  Future<double> getTotalExpenses() async {
    final allTransactions = await getAllTransactions();
    final allCategories = await getAllCategories();

    double expenses = 0.0;

    for (final transaction in allTransactions) {
      final category = allCategories.firstWhere(
        (cat) => cat.id == transaction.categoryId,
        orElse: () => Category(
          id: '',
          name: '',
          iconCode: 0,
          colorCode: 0,
          isExpense: true,
        ),
      );

      if (category.isExpense) {
        expenses += transaction.amount;
      }
    }

    return expenses;
  }

  // ==================== Goals Methods ====================

  /// Get all goals as a stream
  Stream<List<Goal>> watchAllGoals() => select(goals).watch();

  /// Get all goals
  Future<List<Goal>> getAllGoals() => select(goals).get();

  /// Insert a goal
  Future<int> insertGoal(GoalsCompanion goal) =>
      into(goals).insert(goal);

  /// Update a goal
  Future<bool> updateGoal(GoalsCompanion goal) =>
      update(goals).replace(goal);

  /// Delete a goal
  Future<int> deleteGoal(String id) =>
      (delete(goals)..where((tbl) => tbl.id.equals(id))).go();
}

/// Helper class to hold transaction with its category
class TransactionWithCategory {
  final Transaction transaction;
  final Category? category;

  TransactionWithCategory({
    required this.transaction,
    required this.category,
  });
}

