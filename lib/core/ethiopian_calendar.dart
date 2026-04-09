/// Ethiopian Calendar (Ge'ez Calendar) Converter
/// Ethiopia uses its own calendar which is ~7-8 years behind the Gregorian calendar.
/// It has 13 months: 12 months of 30 days each + Pagume (5 or 6 days).
class EthiopianDate {
  final int year;
  final int month;
  final int day;

  const EthiopianDate({
    required this.year,
    required this.month,
    required this.day,
  });

  static const List<String> monthNamesAmharic = [
    'መስከረም', // Meskerem
    'ጥቅምት',  // Tikimt
    'ኅዳር',   // Hidar
    'ታኅሣሥ',  // Tahsas
    'ጥር',    // Tir
    'የካቲት',  // Yekatit
    'መጋቢት',  // Megabit
    'ሚያዝያ',  // Miyazia
    'ግንቦት',  // Ginbot
    'ሰኔ',    // Sene
    'ሐምሌ',   // Hamle
    'ነሐሴ',   // Nehase
    'ጳጉሜ',   // Pagume
  ];

  static const List<String> monthNamesEnglish = [
    'Meskerem',
    'Tikimt',
    'Hidar',
    'Tahsas',
    'Tir',
    'Yekatit',
    'Megabit',
    'Miyazia',
    'Ginbot',
    'Sene',
    'Hamle',
    'Nehase',
    'Pagume',
  ];

  static const List<String> dayNamesAmharic = [
    'ሰኞ',   // Monday
    'ማክሰ',  // Tuesday
    'ረቡዕ',  // Wednesday
    'ሐሙስ',  // Thursday
    'ዓርብ',  // Friday
    'ቅዳሜ',  // Saturday
    'እሑድ',  // Sunday
  ];

  /// Convert Gregorian DateTime to Ethiopian Date
  static EthiopianDate fromGregorian(DateTime gregorian) {
    // Ethiopian calendar epoch in Julian Day Number
    final jdn = _gregorianToJDN(
      gregorian.year,
      gregorian.month,
      gregorian.day,
    );
    return _jdnToEthiopian(jdn);
  }

  /// Convert Ethiopian Date to Gregorian DateTime
  DateTime toGregorian() {
    final jdn = _ethiopianToJDN(year, month, day);
    return _jdnToGregorian(jdn);
  }

  /// Get the month name in Amharic
  String get monthNameAmharic =>
      month >= 1 && month <= 13 ? monthNamesAmharic[month - 1] : '';

  /// Get the month name in English
  String get monthNameEnglish =>
      month >= 1 && month <= 13 ? monthNamesEnglish[month - 1] : '';

  /// Format: "day monthName year" in Amharic
  String formatAmharic() => '$day ${monthNameAmharic} $year';

  /// Format: "day monthName year" in English
  String formatEnglish() => '$monthNameEnglish $day, $year';

  /// Short format: "month/day/year"
  String formatShort() => '$month/$day/$year';

  @override
  String toString() => formatEnglish();

  // ========================= Internal Conversion =========================

  static int _gregorianToJDN(int year, int month, int day) {
    final a = ((14 - month) ~/ 12);
    final y = year + 4800 - a;
    final m = month + 12 * a - 3;
    return day +
        ((153 * m + 2) ~/ 5) +
        365 * y +
        (y ~/ 4) -
        (y ~/ 100) +
        (y ~/ 400) -
        32045;
  }

  static DateTime _jdnToGregorian(int jdn) {
    final a = jdn + 32044;
    final b = (4 * a + 3) ~/ 146097;
    final c = a - (146097 * b) ~/ 4;
    final d = (4 * c + 3) ~/ 1461;
    final e = c - (1461 * d) ~/ 4;
    final m = (5 * e + 2) ~/ 153;

    final day = e - (153 * m + 2) ~/ 5 + 1;
    final month = m + 3 - 12 * (m ~/ 10);
    final year = 100 * b + d - 4800 + (m ~/ 10);

    return DateTime(year, month, day);
  }

  static EthiopianDate _jdnToEthiopian(int jdn) {
    // Ethiopian epoch in JDN (Meskerem 1, Year 1 = August 29, 8 AD Julian)
    const ethiopianEpoch = 1724221;
    final r = (jdn - ethiopianEpoch) % 1461;
    final n = (r % 365) + 365 * (r ~/ 1460);

    final year = 4 * ((jdn - ethiopianEpoch) ~/ 1461) +
        (r ~/ 365) -
        (r ~/ 1460);
    final month = (n ~/ 30) + 1;
    final day = (n % 30) + 1;

    return EthiopianDate(year: year, month: month, day: day);
  }

  static int _ethiopianToJDN(int year, int month, int day) {
    const ethiopianEpoch = 1724221;
    return ethiopianEpoch +
        365 * (year - 1) +
        (year ~/ 4) +
        30 * (month - 1) +
        day -
        1;
  }
}
