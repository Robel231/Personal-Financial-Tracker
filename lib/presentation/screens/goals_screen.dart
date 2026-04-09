import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/goal.dart';
import '../providers/goal_list_provider.dart';
import '../../core/currency_formatter.dart';
import 'package:uuid/uuid.dart';
import '../../data/repositories/goal_repository_impl.dart';

class GoalsScreen extends ConsumerStatefulWidget {
  const GoalsScreen({super.key});

  @override
  ConsumerState<GoalsScreen> createState() => _GoalsScreenState();
}

class _GoalsScreenState extends ConsumerState<GoalsScreen> {
  @override
  Widget build(BuildContext context) {
    final goalsAsync = ref.watch(goalListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Equb & Goals'),
        centerTitle: true,
      ),
      body: goalsAsync.when(
        data: (goals) {
          if (goals.isEmpty) {
            return const Center(
              child: Text(
                'No goals yet. Start saving for your first Equb!',
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: goals.length,
            itemBuilder: (context, index) {
              final goal = goals[index];
              return _buildGoalCard(context, goal);
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Error loading goals: $e')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddEditGoalDialog(context, null),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildGoalCard(BuildContext context, Goal goal) {
    final theme = Theme.of(context);
    final progress = goal.progressPercentage;

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => _showAddEditGoalDialog(context, goal),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: goal.color.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(goal.icon, color: goal.color),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          goal.name,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${CurrencyFormatter.format(goal.savedAmount)} / ${CurrencyFormatter.format(goal.targetAmount)}',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.add_circle, color: theme.colorScheme.primary),
                    onPressed: () => _showAddFundsDialog(context, goal),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 10,
                  backgroundColor: goal.color.withOpacity(0.2),
                  valueColor: AlwaysStoppedAnimation<Color>(goal.color),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${(progress * 100).toStringAsFixed(1)}%',
                    style: TextStyle(
                      color: goal.color,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (goal.targetDate != null)
                    Text(
                      'Target: ${goal.targetDate!.year}-${goal.targetDate!.month.toString().padLeft(2, '0')}-${goal.targetDate!.day.toString().padLeft(2, '0')}',
                      style: TextStyle(color: Colors.grey[500], fontSize: 12),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showAddFundsDialog(BuildContext context, Goal goal) {
    final amountController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Funds to ${goal.name}'),
          content: TextField(
            controller: amountController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Amount to add',
              prefixText: 'Br ',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () async {
                final amount = double.tryParse(amountController.text) ?? 0.0;
                if (amount > 0) {
                  final repository = ref.read(goalRepositoryProvider);
                  final updatedGoal = goal.copyWith(
                    savedAmount: goal.savedAmount + amount,
                  );
                  await repository.updateGoal(updatedGoal);
                }
                if (context.mounted) Navigator.pop(context);
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _showAddEditGoalDialog(BuildContext context, Goal? existingGoal) {
    final nameController = TextEditingController(text: existingGoal?.name);
    final amountController = TextEditingController(
      text: existingGoal?.targetAmount.toStringAsFixed(2) ?? '',
    );

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(existingGoal == null ? 'New Goal / Equb' : 'Edit Goal'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Goal Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Target Amount',
                    prefixText: 'Br ',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            if (existingGoal != null)
              TextButton(
                onPressed: () async {
                  final repository = ref.read(goalRepositoryProvider);
                  await repository.deleteGoal(existingGoal.id);
                  if (context.mounted) Navigator.pop(context);
                },
                child: const Text('Delete', style: TextStyle(color: Colors.red)),
              ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () async {
                final name = nameController.text.trim();
                final amount = double.tryParse(amountController.text) ?? 0.0;
                if (name.isNotEmpty && amount > 0) {
                  final repository = ref.read(goalRepositoryProvider);
                  if (existingGoal == null) {
                    final goal = Goal(
                      id: const Uuid().v4(),
                      name: name,
                      targetAmount: amount,
                      icon: Icons.savings,
                      color: const Color(0xFF6a994e), // Sage Green
                    );
                    await repository.addGoal(goal);
                  } else {
                    final updatedGoal = existingGoal.copyWith(
                      name: name,
                      targetAmount: amount,
                    );
                    await repository.updateGoal(updatedGoal);
                  }
                  if (context.mounted) Navigator.pop(context);
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
