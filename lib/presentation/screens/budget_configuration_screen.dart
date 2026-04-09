import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/category_list_provider.dart';
import '../providers/database_provider.dart';
import '../../core/currency_formatter.dart';
import '../../domain/entities/category.dart' as entity;

class BudgetConfigurationScreen extends ConsumerWidget {
  const BudgetConfigurationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriesAsync = ref.watch(categoryListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Smart Budget (በጀት)'),
        centerTitle: true,
      ),
      body: categoriesAsync.when(
        data: (categories) {
          final expenseCategories =
              categories.where((c) => c.isExpense).toList();

          if (expenseCategories.isEmpty) {
            return const Center(child: Text('No expense categories found.'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: expenseCategories.length,
            itemBuilder: (context, index) {
              final cat = expenseCategories[index];
              final hasBudget =
                  cat.monthlyBudget != null && cat.monthlyBudget! > 0;

              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14)),
                child: ListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  leading: CircleAvatar(
                    backgroundColor: Color(cat.colorCode).withOpacity(0.15),
                    child: Icon(
                      IconData(cat.iconCode, fontFamily: 'MaterialIcons'),
                      color: Color(cat.colorCode),
                    ),
                  ),
                  title: Text(cat.name,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(
                    hasBudget
                        ? 'Monthly limit: ${CurrencyFormatter.format(cat.monthlyBudget!)}'
                        : 'No limit set – tap to add',
                    style: TextStyle(
                      color: hasBudget
                          ? const Color(0xFF6a994e)
                          : Colors.grey[500],
                    ),
                  ),
                  trailing: hasBudget
                      ? const Icon(Icons.check_circle,
                          color: Color(0xFF6a994e), size: 22)
                      : const Icon(Icons.add_circle_outline,
                          color: Colors.grey, size: 22),
                  onTap: () =>
                      _showBudgetDialog(context, ref, cat),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }

  void _showBudgetDialog(
      BuildContext context, WidgetRef ref, entity.Category category) {
    final controller = TextEditingController(
      text: (category.monthlyBudget != null && category.monthlyBudget! > 0)
          ? category.monthlyBudget!.toStringAsFixed(0)
          : '',
    );

    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text('Budget for ${category.name}'),
          content: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            autofocus: true,
            decoration: const InputDecoration(
              labelText: 'Monthly Limit',
              prefixText: 'Br ',
              border: OutlineInputBorder(),
              hintText: 'e.g. 5000',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancel'),
            ),
            if (category.monthlyBudget != null && category.monthlyBudget! > 0)
              TextButton(
                onPressed: () async {
                  final repo = ref.read(transactionRepositoryProvider);
                  final updated = category.copyWith(monthlyBudget: null);
                  await repo.updateCategory(updated);
                  ref.invalidate(categoryListProvider);
                  if (ctx.mounted) Navigator.pop(ctx);
                },
                child: const Text('Clear',
                    style: TextStyle(color: Color(0xFFbc4749))),
              ),
            FilledButton(
              onPressed: () async {
                final val = double.tryParse(controller.text);
                if (val != null && val > 0) {
                  final repo = ref.read(transactionRepositoryProvider);
                  final updated = category.copyWith(monthlyBudget: val);
                  await repo.updateCategory(updated);
                  ref.invalidate(categoryListProvider);
                }
                if (ctx.mounted) Navigator.pop(ctx);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
