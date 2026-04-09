import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// App settings state
class AppSettings {
  final ThemeMode themeMode;
  final bool useEthiopianCalendar;
  final String locale; // 'en', 'am', 'om', 'ti'

  const AppSettings({
    this.themeMode = ThemeMode.system,
    this.useEthiopianCalendar = true,
    this.locale = 'en',
  });

  AppSettings copyWith({
    ThemeMode? themeMode,
    bool? useEthiopianCalendar,
    String? locale,
  }) {
    return AppSettings(
      themeMode: themeMode ?? this.themeMode,
      useEthiopianCalendar: useEthiopianCalendar ?? this.useEthiopianCalendar,
      locale: locale ?? this.locale,
    );
  }

  String get localeName {
    switch (locale) {
      case 'am':
        return 'አማርኛ';
      case 'om':
        return 'Afaan Oromoo';
      case 'ti':
        return 'ትግርኛ';
      case 'en':
      default:
        return 'English';
    }
  }
}

/// Settings notifier for managing app settings
class SettingsNotifier extends StateNotifier<AppSettings> {
  SettingsNotifier() : super(const AppSettings());

  void setThemeMode(ThemeMode mode) {
    state = state.copyWith(themeMode: mode);
  }

  void toggleEthiopianCalendar() {
    state = state.copyWith(useEthiopianCalendar: !state.useEthiopianCalendar);
  }

  void setLocale(String locale) {
    state = state.copyWith(locale: locale);
  }
}

/// Provider for app settings
final settingsProvider =
    StateNotifierProvider<SettingsNotifier, AppSettings>((ref) {
  return SettingsNotifier();
});
