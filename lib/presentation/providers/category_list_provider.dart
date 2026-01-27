import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/category.dart';
import 'database_provider.dart';

part 'category_list_provider.g.dart';

/// Provider that streams all categories from the database
/// This will automatically update the UI when categories change
@riverpod
Stream<List<Category>> categoryList(CategoryListRef ref) {
  final repository = ref.watch(transactionRepositoryProvider);
  return repository.watchAllCategories();
}

/// Provider that gets all categories as a Future (one-time fetch)
@riverpod
Future<List<Category>> allCategories(AllCategoriesRef ref) {
  final repository = ref.watch(transactionRepositoryProvider);
  return repository.getAllCategories();
}

/// Provider to get expense categories only
@riverpod
Future<List<Category>> expenseCategories(ExpenseCategoriesRef ref) async {
  final repository = ref.watch(transactionRepositoryProvider);
  final categories = await repository.getAllCategories();
  return categories.where((cat) => cat.isExpense).toList();
}

/// Provider to get income categories only
@riverpod
Future<List<Category>> incomeCategories(IncomeCategoriesRef ref) async {
  final repository = ref.watch(transactionRepositoryProvider);
  final categories = await repository.getAllCategories();
  return categories.where((cat) => !cat.isExpense).toList();
}
