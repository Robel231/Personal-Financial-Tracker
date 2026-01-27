import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../../domain/entities/category.dart';
import '../../domain/repositories/transaction_repository.dart';

/// Helper class to initialize default categories
class DefaultCategories {
  static Future<void> initializeDefaultCategories(
    TransactionRepository repository,
  ) async {
    final existingCategories = await repository.getAllCategories();
    
    // Only add default categories if none exist
    if (existingCategories.isEmpty) {
      final defaultCategories = _getDefaultCategories();
      
      for (final category in defaultCategories) {
        await repository.insertCategory(category);
      }
    }
  }

  static List<Category> _getDefaultCategories() {
    const uuid = Uuid();
    
    return [
      // Expense Categories
      Category(
        id: uuid.v4(),
        name: 'Food',
        iconCode: Icons.restaurant.codePoint,
        colorCode: Colors.orange.value,
        isExpense: true,
      ),
      Category(
        id: uuid.v4(),
        name: 'Transport',
        iconCode: Icons.directions_car.codePoint,
        colorCode: Colors.blue.value,
        isExpense: true,
      ),
      Category(
        id: uuid.v4(),
        name: 'Shopping',
        iconCode: Icons.shopping_bag.codePoint,
        colorCode: Colors.purple.value,
        isExpense: true,
      ),
      Category(
        id: uuid.v4(),
        name: 'Entertainment',
        iconCode: Icons.movie.codePoint,
        colorCode: Colors.pink.value,
        isExpense: true,
      ),
      Category(
        id: uuid.v4(),
        name: 'Bills',
        iconCode: Icons.receipt_long.codePoint,
        colorCode: Colors.red.value,
        isExpense: true,
      ),
      Category(
        id: uuid.v4(),
        name: 'Health',
        iconCode: Icons.local_hospital.codePoint,
        colorCode: Colors.teal.value,
        isExpense: true,
      ),
      Category(
        id: uuid.v4(),
        name: 'Education',
        iconCode: Icons.school.codePoint,
        colorCode: Colors.indigo.value,
        isExpense: true,
      ),
      Category(
        id: uuid.v4(),
        name: 'Other',
        iconCode: Icons.more_horiz.codePoint,
        colorCode: Colors.grey.value,
        isExpense: true,
      ),
      
      // Income Categories
      Category(
        id: uuid.v4(),
        name: 'Salary',
        iconCode: Icons.account_balance_wallet.codePoint,
        colorCode: Colors.green.value,
        isExpense: false,
      ),
      Category(
        id: uuid.v4(),
        name: 'Freelance',
        iconCode: Icons.work.codePoint,
        colorCode: Colors.lightGreen.value,
        isExpense: false,
      ),
      Category(
        id: uuid.v4(),
        name: 'Investment',
        iconCode: Icons.trending_up.codePoint,
        colorCode: Colors.cyan.value,
        isExpense: false,
      ),
      Category(
        id: uuid.v4(),
        name: 'Gift',
        iconCode: Icons.card_giftcard.codePoint,
        colorCode: Colors.amber.value,
        isExpense: false,
      ),
      Category(
        id: uuid.v4(),
        name: 'Other Income',
        iconCode: Icons.attach_money.codePoint,
        colorCode: Colors.lime.value,
        isExpense: false,
      ),
    ];
  }
}
