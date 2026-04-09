import '../entities/goal.dart';

abstract class GoalRepository {
  Stream<List<Goal>> watchGoals();
  Future<List<Goal>> getGoals();
  Future<void> addGoal(Goal goal);
  Future<void> updateGoal(Goal goal);
  Future<void> deleteGoal(String id);
}
