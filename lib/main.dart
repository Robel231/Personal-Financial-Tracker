import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/app_theme.dart';
import 'core/default_categories.dart';
import 'presentation/providers/database_provider.dart';
import 'presentation/providers/settings_provider.dart';
import 'presentation/screens/home_screen.dart';
import 'presentation/screens/add_transaction_screen.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  void initState() {
    super.initState();
    // Initialize default categories on first launch
    Future.microtask(() async {
      final repository = ref.read(transactionRepositoryProvider);
      await DefaultCategories.initializeDefaultCategories(repository);
    });
  }

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(settingsProvider);

    return MaterialApp(
      title: 'ብሬ | Birre',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme(),
      darkTheme: AppTheme.darkTheme(),
      themeMode: settings.themeMode,
      home: const HomeScreen(),
      routes: {
        '/add-transaction': (context) => const AddTransactionScreen(),
      },
    );
  }
}
