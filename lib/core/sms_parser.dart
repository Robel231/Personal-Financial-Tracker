/// SMS Parser for Ethiopian banks and mobile money services
/// Parses incoming SMS from Telebirr, CBE Birr, Awash, Dashen, etc.
class SmsParser {
  /// Known sender addresses for Ethiopian financial institutions
  static const List<String> knownSenders = [
    'Telebirr',
    'telebirr',
    'CBE',
    'CBEBirr',
    'cbe',
    'AwashBank',
    'Awash',
    'DashenBank',
    'Dashen',
    'Abyssinia',
    'BOA',
    'Amhara',
    'Zemen',
    'Nib',
    'Wegagen',
    'Berhan',
    'Bunna',
    'Cooperative',
    'CoopBank',
    'Enat',
    'OromiaBank',
  ];

  /// Smart Regex rules for precision matching Ethiopian Bank formats
  static final List<_SmartSmsRule> _smartRules = [
    // English receive formats
    _SmartSmsRule(r'received\s+(?:from\s+(?<party>[a-zA-Z0-9\s]+?)\s+)?(?:ETB|Birr|Br\.?)\s*(?<amount>[0-9,]+\.?\d*)', true),
    _SmartSmsRule(r'received\s+(?:ETB|Birr|Br\.?)\s*(?<amount>[0-9,]+\.?\d*)(?:\s*from\s+(?<party>[a-zA-Z0-9\s]+?))?(?=\s*(?:Ref|Txn)|\.$|$)', true),
    _SmartSmsRule(r'received\s*(?<amount>[0-9,]+\.?\d*)\s*(?:ETB|Birr|Br\.?)(?:\s*from\s+(?<party>[a-zA-Z0-9\s]+?))?(?=\s*(?:Ref|Txn)|\.$|$)', true),
    _SmartSmsRule(r'(?:credited|deposited)\s+(?:with\s+)?(?:ETB|Birr|Br\.?)?\s*(?<amount>[0-9,]+\.?\d*)', true),

    // English transfer/expense formats
    _SmartSmsRule(r'(?:transferred|sent)\s+(?:to\s+(?<party>[a-zA-Z0-9\s]+?)\s+)?(?:ETB|Birr|Br\.?)\s*(?<amount>[0-9,]+\.?\d*)', false),
    _SmartSmsRule(r'(?:transferred|sent)\s+(?:ETB|Birr|Br\.?)\s*(?<amount>[0-9,]+\.?\d*)(?:\s*to\s+(?<party>[a-zA-Z0-9\s]+?))?(?=\s*(?:Ref|Txn)|\.$|$)', false),
    _SmartSmsRule(r'(?:transferred|sent)\s*(?<amount>[0-9,]+\.?\d*)\s*(?:ETB|Birr|Br\.?)(?:\s*to\s+(?<party>[a-zA-Z0-9\s]+?))?(?=\s*(?:Ref|Txn)|\.$|$)', false),
    
    _SmartSmsRule(r'(?:paid|payment\s+to)\s+(?<party>[a-zA-Z0-9\s]+?)?\s*(?:ETB|Birr|Br\.?)\s*(?<amount>[0-9,]+\.?\d*)', false),
    _SmartSmsRule(r'(?:paid|payment\s+to)\s+(?:ETB|Birr|Br\.?)\s*(?<amount>[0-9,]+\.?\d*)(?:\s*to\s+(?<party>[a-zA-Z0-9\s]+?))?', false),

    _SmartSmsRule(r'(?:withdrawn|debited)\s+(?:from\s+.*?\/)?(?:ETB|Birr|Br\.?)\s*(?<amount>[0-9,]+\.?\d*)', false),
    _SmartSmsRule(r'purchase\s+(?:of\s+)?(?:ETB|Birr|Br\.?)?\s*(?<amount>[0-9,]+\.?\d*)', false),

    // Amharic received / income
    _SmartSmsRule(r'(?:ተቀብለዋል|ገቢ)\s*((?:ከ\s*(?<party>[^\s]+)\s*)?)?(?:ETB|Birr|Br\.?)?\s*(?<amount>[0-9,]+\.?\d*)', true),
    
    // Amharic expense / transferred / paid
    _SmartSmsRule(r'(?:ወጪ|ተላልፏል|ተከፍሏል)\s*((?:ለ\s*(?<party>[^\s]+)\s*)?)?(?:ETB|Birr|Br\.?)?\s*(?<amount>[0-9,]+\.?\d*)', false),
  ];

  /// Check if the SMS sender is a known financial institution
  static bool isFinancialSms(String sender) {
    final senderLower = sender.toLowerCase();
    return knownSenders.any(
      (known) => senderLower.contains(known.toLowerCase()),
    );
  }

  /// Parse an SMS body and extract the transaction details
  static ParsedTransaction? parseSms(String sender, String body) {
    try {
      // 1. Try smart regex rules first for maximum precision
      for (final rule in _smartRules) {
        final match = rule.pattern.firstMatch(body);
        if (match != null) {
          final amountStr = match.namedGroup('amount')?.replaceAll(',', '');
          if (amountStr != null) {
            final amount = double.tryParse(amountStr);
            if (amount != null && amount > 0) {
              String? party;
              try {
                // Ignore match errors if party is uncaptured
                party = match.namedGroup('party')?.trim();
              } catch (_) {}

              final isCredit = rule.isIncome;
              
              // Extract Ref if exists via heuristic text search
              String description = _extractDescription(body, sender);
              if (party != null && party.isNotEmpty) {
                 final prefix = isCredit ? 'From' : 'To';
                 description = '$prefix $party - $description';
              }

              final balance = _extractBalance(body);

              return ParsedTransaction(
                amount: amount,
                isIncome: isCredit,
                description: description,
                sender: sender,
                balance: balance,
                rawMessage: body,
              );
            }
          }
        }
      }

      // 2. Fallback to heuristic parser
      final amount = _extractAmount(body);
      if (amount == null || amount <= 0) return null;

      final isCredit = _isCredit(body);
      final description = _extractDescription(body, sender);
      final balance = _extractBalance(body);

      return ParsedTransaction(
        amount: amount,
        isIncome: isCredit,
        description: description,
        sender: sender,
        balance: balance,
        rawMessage: body,
      );
    } catch (_) {
      return null;
    }
  }

  /// Extract amount from SMS body
  static double? _extractAmount(String body) {
    // Common patterns:
    // "ETB 1,234.56" or "Birr 1,234.56" or "1234.56 ETB"
    // "Amount: 1234.56" or "amount 1,234.56"
    // "debited Br. 500.00" or "credited Br 1000"
    final patterns = [
      RegExp(r'(?:ETB|Birr|Br\.?)\s*([0-9,]+\.?\d*)', caseSensitive: false),
      RegExp(r'([0-9,]+\.?\d*)\s*(?:ETB|Birr|Br)', caseSensitive: false),
      RegExp(r'(?:amount|amt)[:\s]*([0-9,]+\.?\d*)', caseSensitive: false),
      RegExp(r'(?:debited|credited)[:\s]*(?:ETB|Birr|Br\.?)?\s*([0-9,]+\.?\d*)',
          caseSensitive: false),
      RegExp(r'([0-9,]+\.?\d{2})', caseSensitive: false),
    ];

    for (final pattern in patterns) {
      final match = pattern.firstMatch(body);
      if (match != null) {
        final amountStr = match.group(1)!.replaceAll(',', '');
        final amount = double.tryParse(amountStr);
        if (amount != null && amount > 0) return amount;
      }
    }
    return null;
  }

  /// Determine if this is a credit (income) or debit (expense)
  static bool _isCredit(String body) {
    final bodyLower = body.toLowerCase();
    final creditKeywords = [
      'credited',
      'received',
      'deposited',
      'transfer to you',
      'sent to you',
      'incoming',
      'credit',
      'ተቀብለዋል', // Amharic: received
      'ገቢ',       // Amharic: income
    ];

    final debitKeywords = [
      'debited',
      'withdrawn',
      'paid',
      'sent',
      'purchase',
      'payment',
      'transferred',
      'debit',
      'ወጪ',       // Amharic: expense
      'ተላልፏል',   // Amharic: transferred
    ];

    for (final keyword in creditKeywords) {
      if (bodyLower.contains(keyword.toLowerCase())) return true;
    }
    for (final keyword in debitKeywords) {
      if (bodyLower.contains(keyword.toLowerCase())) return false;
    }

    // Default to expense if uncertain
    return false;
  }

  /// Extract description/reference from SMS
  static String _extractDescription(String body, String sender) {
    // Try to extract reference number
    final refPattern = RegExp(
      r'(?:ref|reference|txn|transaction)[:\s#]*(\w+)',
      caseSensitive: false,
    );
    final refMatch = refPattern.firstMatch(body);
    if (refMatch != null) {
      return '$sender - Ref: ${refMatch.group(1)}';
    }

    return '$sender Transaction';
  }

  /// Extract remaining balance if present
  static double? _extractBalance(String body) {
    final patterns = [
      RegExp(
        r'(?:balance|bal|available)[:\s]*(?:ETB|Birr|Br\.?)?\s*([0-9,]+\.?\d*)',
        caseSensitive: false,
      ),
      RegExp(
        r'(?:ETB|Birr|Br\.?)\s*([0-9,]+\.?\d*)\s*(?:balance|remaining)',
        caseSensitive: false,
      ),
    ];

    for (final pattern in patterns) {
      final match = pattern.firstMatch(body);
      if (match != null) {
        return double.tryParse(match.group(1)!.replaceAll(',', ''));
      }
    }
    return null;
  }

  /// Get the likely category tag based on the sender
  static String getSenderCategory(String sender) {
    final senderLower = sender.toLowerCase();
    if (senderLower.contains('telebirr')) return 'Telebirr';
    if (senderLower.contains('cbe')) return 'CBE Birr';
    if (senderLower.contains('awash')) return 'Awash Bank';
    if (senderLower.contains('dashen')) return 'Dashen Bank';
    if (senderLower.contains('abyssinia') || senderLower.contains('boa')) {
      return 'Bank of Abyssinia';
    }
    return 'Bank Transfer';
  }
}

/// Parsed transaction data from SMS
class ParsedTransaction {
  final double amount;
  final bool isIncome;
  final String description;
  final String sender;
  final double? balance;
  final String rawMessage;

  const ParsedTransaction({
    required this.amount,
    required this.isIncome,
    required this.description,
    required this.sender,
    this.balance,
    required this.rawMessage,
  });

  @override
  String toString() =>
      'ParsedTransaction(amount: $amount, isIncome: $isIncome, desc: $description)';
}

/// A matched rule that encapsulates a regex pattern and its context
class _SmartSmsRule {
  final RegExp pattern;
  final bool isIncome;

  _SmartSmsRule(String regexString, this.isIncome)
      : pattern = RegExp(regexString, caseSensitive: false, unicode: true);
}
