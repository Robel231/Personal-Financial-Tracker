import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/database/app_database.dart';
import '../../data/repositories/transaction_repository_impl.dart';
import '../../domain/repositories/transaction_repository.dart';

part 'database_provider.g.dart';

/// Provider for the AppDatabase instance
/// This is a singleton that will be created once and reused throughout the app
@Riverpod(keepAlive: true)
AppDatabase appDatabase(AppDatabaseRef ref) {
  final database = AppDatabase();
  // Dispose the database when the provider is disposed
  ref.onDispose(() {
    database.close();
  });
  return database;
}

/// Provider for the TransactionRepository
/// This provides the implementation of the repository interface
@Riverpod(keepAlive: true)
TransactionRepository transactionRepository(TransactionRepositoryRef ref) {
  final database = ref.watch(appDatabaseProvider);
  return TransactionRepositoryImpl(database);
}
