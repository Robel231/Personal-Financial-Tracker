import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'database_provider.dart';

part 'summary_provider.freezed.dart';
part 'summary_provider.g.dart';

/// Model to hold financial summary data
@freezed
class FinancialSummary with _$FinancialSummary {
  const factory FinancialSummary({
    required double totalIncome,
    required double totalExpense,
    required double balance,
  }) = _FinancialSummary;
}

/// Provider that calculates the total income
@riverpod
Future<double> totalIncome(TotalIncomeRef ref) async {
  final repository = ref.watch(transactionRepositoryProvider);
  return await repository.getTotalIncome();
}

/// Provider that calculates the total expenses
@riverpod
Future<double> totalExpense(TotalExpenseRef ref) async {
  final repository = ref.watch(transactionRepositoryProvider);
  return await repository.getTotalExpenses();
}

/// Provider that calculates the total balance (income - expense)
@riverpod
Future<double> totalBalance(TotalBalanceRef ref) async {
  final repository = ref.watch(transactionRepositoryProvider);
  return await repository.getTotalBalance();
}

/// Combined provider that provides all financial summary data
/// This is convenient for displaying all summary information together
@riverpod
Future<FinancialSummary> financialSummary(FinancialSummaryRef ref) async {
  final repository = ref.watch(transactionRepositoryProvider);
  
  // Fetch all values in parallel for better performance
  final results = await Future.wait([
    repository.getTotalIncome(),
    repository.getTotalExpenses(),
    repository.getTotalBalance(),
  ]);

  return FinancialSummary(
    totalIncome: results[0],
    totalExpense: results[1],
    balance: results[2],
  );
}
