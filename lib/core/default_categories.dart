import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../../domain/entities/category.dart';
import '../../domain/repositories/transaction_repository.dart';

/// Helper class to initialize default categories with Ethiopian context
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
      // ==================== Expense Categories ====================
      Category(
        id: uuid.v4(),
        name: 'Food & Drinks',
        iconCode: Icons.restaurant.codePoint,
        colorCode: Colors.orange.value,
        isExpense: true,
      ),
      Category(
        id: uuid.v4(),
        name: 'Transport',
        iconCode: Icons.directions_bus.codePoint,
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
        name: 'Bills & Utilities',
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
        name: 'Entertainment',
        iconCode: Icons.movie.codePoint,
        colorCode: Colors.pink.value,
        isExpense: true,
      ),
      Category(
        id: uuid.v4(),
        name: 'Rent / Housing',
        iconCode: Icons.home.codePoint,
        colorCode: Colors.brown.value,
        isExpense: true,
      ),
      
      // Ethiopian-specific expense categories
      Category(
        id: uuid.v4(),
        name: 'Equb (እቁብ)',
        iconCode: Icons.group.codePoint,
        colorCode: const Color(0xFF009639).value, // Ethiopian green
        isExpense: true,
      ),
      Category(
        id: uuid.v4(),
        name: 'Iddir (እድር)',
        iconCode: Icons.people.codePoint,
        colorCode: const Color(0xFF6D4C41).value,
        isExpense: true,
      ),
      Category(
        id: uuid.v4(),
        name: 'Telebirr',
        iconCode: Icons.phone_android.codePoint,
        colorCode: const Color(0xFF00BCD4).value,
        isExpense: true,
      ),
      Category(
        id: uuid.v4(),
        name: 'CBE Birr',
        iconCode: Icons.account_balance.codePoint,
        colorCode: const Color(0xFF1565C0).value,
        isExpense: true,
      ),
      Category(
        id: uuid.v4(),
        name: 'Church / Mosque',
        iconCode: Icons.brightness_7.codePoint,
        colorCode: const Color(0xFFFFB300).value,
        isExpense: true,
      ),
      Category(
        id: uuid.v4(),
        name: 'Other Expense',
        iconCode: Icons.more_horiz.codePoint,
        colorCode: Colors.grey.value,
        isExpense: true,
      ),
      
      // ==================== Income Categories ====================
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
        name: 'Business',
        iconCode: Icons.store.codePoint,
        colorCode: const Color(0xFF4CAF50).value,
        isExpense: false,
      ),
      Category(
        id: uuid.v4(),
        name: 'Equb Payout (እቁብ)',
        iconCode: Icons.monetization_on.codePoint,
        colorCode: const Color(0xFF009639).value,
        isExpense: false,
      ),
      Category(
        id: uuid.v4(),
        name: 'Remittance',
        iconCode: Icons.send.codePoint,
        colorCode: Colors.cyan.value,
        isExpense: false,
      ),
      Category(
        id: uuid.v4(),
        name: 'Gift / Support',
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
