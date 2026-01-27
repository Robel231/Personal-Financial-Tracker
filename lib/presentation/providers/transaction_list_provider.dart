import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/transaction.dart';
import 'database_provider.dart';

part 'transaction_list_provider.g.dart';

/// Provider that streams all transactions from the database
/// This will automatically update the UI when transactions change
@riverpod
Stream<List<Transaction>> transactionList(TransactionListRef ref) {
  final repository = ref.watch(transactionRepositoryProvider);
  return repository.watchAllTransactions();
}

/// Provider that gets all transactions as a Future (one-time fetch)
@riverpod
Future<List<Transaction>> allTransactions(AllTransactionsRef ref) {
  final repository = ref.watch(transactionRepositoryProvider);
  return repository.getAllTransactions();
}
