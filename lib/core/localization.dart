class AppLocalizations {
  static const Map<String, Map<String, String>> _translations = {
    'en': {
      'totalBalance': 'Total Balance',
      'income': 'Income',
      'expense': 'Expense',
      'recentTransactions': 'Recent Transactions',
      'addTransaction': 'Add Transaction',
      'home': 'Home',
      'stats': 'Stats',
      'sms': 'SMS',
      'settings': 'Settings',
      'noTransactions': 'Tap + to add your first transaction',
      'date': 'Date',
    },
    'am': {
      'totalBalance': 'አጠቃላይ ቀሪ ሂሳብ',
      'income': 'ገቢ',
      'expense': 'ወጪ',
      'recentTransactions': 'የቅርብ ጊዜ ዝውውሮች',
      'addTransaction': 'ዝውውር አክል',
      'home': 'ዋና',
      'stats': 'ስታትስቲክስ',
      'sms': 'መልእክት',
      'settings': 'ቅንብሮች',
      'noTransactions': 'የመጀመሪያዎን ዝውውር ለማከል + ይንኩ',
      'date': 'ቀን',
    },
    'om': {
      'totalBalance': 'Haftee Waliigalaa',
      'income': 'Galii',
      'expense': 'Baasii',
      'recentTransactions': 'Darbiinsa Dhihoo',
      'addTransaction': 'Darbiinsa Dabali',
      'home': 'Iddoo duraa',
      'stats': 'Istaatistiksii',
      'sms': 'Ergaa',
      'settings': 'Qindaa\'ina',
      'noTransactions': 'Tuqi + darbiinsa kee jalqabaa dabaluuf',
      'date': 'Guyyaa',
    },
    'ti': {
      'totalBalance': 'ጠቕላላ ዝተረፈ',
      'income': 'ኣታዊ',
      'expense': 'ወጻኢ',
      'recentTransactions': 'ናይ ቀረባ ግዜ ዝውውራት',
      'addTransaction': 'ዝውውር ወስኽ',
      'home': 'ዋና',
      'stats': 'ስታትስቲክስ',
      'sms': 'መልእኽቲ',
      'settings': 'ቅጥዕታት',
      'noTransactions': 'ፈላማይ ዝውውርካ ንምውሳኽ + ጠውቕ',
      'date': 'ዕለት',
    },
  };

  static String get(String locale, String key) {
    return _translations[locale]?[key] ?? _translations['en']?[key] ?? key;
  }
}
