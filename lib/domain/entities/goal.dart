import 'package:flutter/material.dart';

class Goal {
  final String id;
  final String name;
  final double targetAmount;
  final double savedAmount;
  final DateTime? targetDate;
  final IconData icon;
  final Color color;

  Goal({
    required this.id,
    required this.name,
    required this.targetAmount,
    this.savedAmount = 0.0,
    this.targetDate,
    required this.icon,
    required this.color,
  });

  Goal copyWith({
    String? id,
    String? name,
    double? targetAmount,
    double? savedAmount,
    DateTime? targetDate,
    IconData? icon,
    Color? color,
  }) {
    return Goal(
      id: id ?? this.id,
      name: name ?? this.name,
      targetAmount: targetAmount ?? this.targetAmount,
      savedAmount: savedAmount ?? this.savedAmount,
      targetDate: targetDate ?? this.targetDate,
      icon: icon ?? this.icon,
      color: color ?? this.color,
    );
  }

  // Calculate percentage visually (capped at 1.0 = 100%)
  double get progressPercentage {
    if (targetAmount == 0) return 0.0;
    final ratio = savedAmount / targetAmount;
    return ratio > 1.0 ? 1.0 : ratio;
  }
}
