import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/goal.dart';
import '../../data/repositories/goal_repository_impl.dart';

final goalListProvider = StreamProvider<List<Goal>>((ref) {
  final repository = ref.watch(goalRepositoryProvider);
  return repository.watchGoals();
});
