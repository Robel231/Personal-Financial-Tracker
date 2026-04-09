import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart' as drift;
import '../../presentation/providers/database_provider.dart' as db_prov;
import '../../domain/entities/goal.dart' as entity;
import '../../domain/repositories/goal_repository.dart';
import '../database/app_database.dart' as db;
import 'package:flutter/material.dart';

class GoalRepositoryImpl implements GoalRepository {
  final db.AppDatabase _database;

  GoalRepositoryImpl(this._database);

  @override
  Stream<List<entity.Goal>> watchGoals() {
    return _database.watchAllGoals().map((dbGoals) {
      return dbGoals.map(_mapDbGoalToEntity).toList();
    });
  }

  @override
  Future<List<entity.Goal>> getGoals() async {
    final dbGoals = await _database.getAllGoals();
    return dbGoals.map(_mapDbGoalToEntity).toList();
  }

  @override
  Future<void> addGoal(entity.Goal goal) async {
    await _database.insertGoal(_mapEntityToDbGoal(goal));
  }

  @override
  Future<void> updateGoal(entity.Goal goal) async {
    await _database.updateGoal(_mapEntityToDbGoal(goal));
  }

  @override
  Future<void> deleteGoal(String id) async {
    await _database.deleteGoal(id);
  }

  entity.Goal _mapDbGoalToEntity(db.Goal dbGoal) {
    return entity.Goal(
      id: dbGoal.id,
      name: dbGoal.name,
      targetAmount: dbGoal.targetAmount,
      savedAmount: dbGoal.savedAmount,
      targetDate: dbGoal.targetDate,
      icon: IconData(dbGoal.iconCode, fontFamily: 'MaterialIcons'),
      color: Color(dbGoal.colorCode),
    );
  }

  db.GoalsCompanion _mapEntityToDbGoal(entity.Goal goal) {
    return db.GoalsCompanion.insert(
      id: goal.id,
      name: goal.name,
      targetAmount: goal.targetAmount,
      savedAmount: drift.Value(goal.savedAmount),
      targetDate: drift.Value(goal.targetDate),
      iconCode: goal.icon.codePoint,
      colorCode: goal.color.value,
    );
  }
}

final goalRepositoryProvider = Provider<GoalRepository>((ref) {
  final database = ref.watch(db_prov.appDatabaseProvider);
  return GoalRepositoryImpl(database);
});
