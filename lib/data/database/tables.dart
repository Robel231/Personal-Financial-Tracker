import 'package:drift/drift.dart';

/// Categories table - stores expense and income categories
class Categories extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  IntColumn get iconCode => integer()();
  IntColumn get colorCode => integer()();
  BoolColumn get isExpense => boolean()();
  RealColumn get monthlyBudget => real().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Transactions table - stores all financial transactions
class Transactions extends Table {
  TextColumn get id => text()();
  RealColumn get amount => real()();
  DateTimeColumn get date => dateTime()();
  TextColumn get note => text()();
  TextColumn get categoryId => text().references(Categories, #id)();

  @override
  Set<Column> get primaryKey => {id};
}

/// Goals table - stores long-term saving targets or Equb (እቁብ)
class Goals extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  RealColumn get targetAmount => real()();
  RealColumn get savedAmount => real().withDefault(const Constant(0.0))();
  DateTimeColumn get targetDate => dateTime().nullable()();
  IntColumn get iconCode => integer()();
  IntColumn get colorCode => integer()();

  @override
  Set<Column> get primaryKey => {id};
}
