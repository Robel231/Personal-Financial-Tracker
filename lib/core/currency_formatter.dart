import 'package:intl/intl.dart';

/// Ethiopian Birr currency formatter
class CurrencyFormatter {
  static const String currencySymbol = 'ETB';
  static const String currencySymbolShort = 'Br';

  /// Format amount as Ethiopian Birr
  /// Example: "ETB 1,234.56" or "Br 1,234.56"
  static String format(double amount, {bool useShort = false}) {
    final formatter = NumberFormat.currency(
      symbol: useShort ? '$currencySymbolShort ' : '$currencySymbol ',
      decimalDigits: 2,
    );
    return formatter.format(amount);
  }

  /// Format amount with sign (+ or -)
  static String formatWithSign(double amount, {required bool isExpense}) {
    final prefix = isExpense ? '- ' : '+ ';
    return '$prefix${format(amount, useShort: true)}';
  }

  /// Format amount compactly for small spaces
  static String formatCompact(double amount) {
    if (amount >= 1000000) {
      return '${currencySymbolShort} ${(amount / 1000000).toStringAsFixed(1)}M';
    } else if (amount >= 1000) {
      return '${currencySymbolShort} ${(amount / 1000).toStringAsFixed(1)}K';
    }
    return format(amount, useShort: true);
  }
}
