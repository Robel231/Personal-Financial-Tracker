import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/settings_provider.dart';
import 'budget_configuration_screen.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // ==================== Appearance ====================
          _buildSectionHeader(context, 'Appearance', Icons.palette),
          const SizedBox(height: 8),
          _buildThemeCard(context, ref, settings, theme),

          const SizedBox(height: 24),

          // ==================== Regional ====================
          _buildSectionHeader(context, 'Regional', Icons.language),
          const SizedBox(height: 8),
          _buildLanguageCard(context, ref, settings, theme),
          const SizedBox(height: 12),
          _buildEthiopianCalendarCard(context, ref, settings, theme),

          const SizedBox(height: 24),

          // ==================== Budgeting ====================
          _buildSectionHeader(context, 'Budgeting', Icons.account_balance_wallet),
          const SizedBox(height: 8),
          Card(
            child: ListTile(
              leading: const Icon(Icons.pie_chart, color: Color(0xFF386641)),
              title: const Text('Smart Budget (በጀት)'),
              subtitle: const Text('Set monthly spending limits per category'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const BudgetConfigurationScreen(),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 24),

          // ==================== About ====================
          _buildSectionHeader(context, 'About', Icons.info_outline),
          const SizedBox(height: 8),
          _buildAboutCard(context, theme),

          const SizedBox(height: 24),

          // ==================== Buy Coffee ====================
          _buildCoffeeButton(context),

          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(
    BuildContext context,
    String title,
    IconData icon,
  ) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Theme.of(context).colorScheme.primary),
        const SizedBox(width: 8),
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
        ),
      ],
    );
  }

  Widget _buildThemeCard(
    BuildContext context,
    WidgetRef ref,
    AppSettings settings,
    ThemeData theme,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Column(
          children: [
            RadioListTile<ThemeMode>(
              title: const Text('System Default'),
              subtitle: const Text('Follow device theme'),
              value: ThemeMode.system,
              groupValue: settings.themeMode,
              onChanged: (value) =>
                  ref.read(settingsProvider.notifier).setThemeMode(value!),
              secondary: const Icon(Icons.brightness_auto),
            ),
            RadioListTile<ThemeMode>(
              title: const Text('Light Mode'),
              subtitle: const Text('Bright and clean'),
              value: ThemeMode.light,
              groupValue: settings.themeMode,
              onChanged: (value) =>
                  ref.read(settingsProvider.notifier).setThemeMode(value!),
              secondary: const Icon(Icons.light_mode),
            ),
            RadioListTile<ThemeMode>(
              title: const Text('Dark Mode'),
              subtitle: const Text('Easy on the eyes'),
              value: ThemeMode.dark,
              groupValue: settings.themeMode,
              onChanged: (value) =>
                  ref.read(settingsProvider.notifier).setThemeMode(value!),
              secondary: const Icon(Icons.dark_mode),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageCard(
    BuildContext context,
    WidgetRef ref,
    AppSettings settings,
    ThemeData theme,
  ) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.translate),
        title: const Text('Language'),
        subtitle: Text(settings.localeName),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => _showLanguagePicker(context, ref, settings),
      ),
    );
  }

  void _showLanguagePicker(
    BuildContext context,
    WidgetRef ref,
    AppSettings settings,
  ) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Text(
              'Select Language',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            _buildLanguageOption(context, ref, settings, 'en', 'English', '🇬🇧'),
            _buildLanguageOption(context, ref, settings, 'am', 'አማርኛ (Amharic)', '🇪🇹'),
            _buildLanguageOption(
                context, ref, settings, 'om', 'Afaan Oromoo', '🇪🇹'),
            _buildLanguageOption(
                context, ref, settings, 'ti', 'ትግርኛ (Tigrinya)', '🇪🇹'),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageOption(
    BuildContext context,
    WidgetRef ref,
    AppSettings settings,
    String code,
    String name,
    String flag,
  ) {
    final isSelected = settings.locale == code;
    return ListTile(
      leading: Text(flag, style: const TextStyle(fontSize: 24)),
      title: Text(
        name,
        style: TextStyle(
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      trailing: isSelected
          ? Icon(Icons.check_circle,
              color: Theme.of(context).colorScheme.primary)
          : null,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      selectedTileColor:
          Theme.of(context).colorScheme.primaryContainer.withOpacity(0.3),
      selected: isSelected,
      onTap: () {
        ref.read(settingsProvider.notifier).setLocale(code);
        Navigator.pop(context);
      },
    );
  }

  Widget _buildEthiopianCalendarCard(
    BuildContext context,
    WidgetRef ref,
    AppSettings settings,
    ThemeData theme,
  ) {
    return Card(
      child: SwitchListTile(
        secondary: const Icon(Icons.calendar_month),
        title: const Text('Ethiopian Calendar'),
        subtitle: const Text('Show dates in Ethiopian calendar (ዘመነ ምህረት)'),
        value: settings.useEthiopianCalendar,
        onChanged: (_) =>
            ref.read(settingsProvider.notifier).toggleEthiopianCalendar(),
      ),
    );
  }

  Widget _buildAboutCard(BuildContext context, ThemeData theme) {
    return Card(
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
                    gradient: const LinearGradient(
                      colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.account_balance_wallet,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'ብሬ | Birre',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Version 2.0.0 – Ethiopian Edition',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Built with ❤️ for Ethiopian users.\n'
              'Track your finances in Birr, with Ethiopian calendar support, '
              'and auto-detect transactions from your bank SMS.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: Colors.grey[600],
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCoffeeButton(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF6B4226), Color(0xFF8B5E3C)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6B4226).withOpacity(0.4),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const BuyCoffeeScreen(),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text('☕', style: TextStyle(fontSize: 28)),
                ),
                const SizedBox(width: 16),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Buy Me a Coffee',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Support the developer – ቡና ግዛልኝ! 🇪🇹',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right, color: Colors.white70),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ========================= Buy Coffee Screen =========================

class BuyCoffeeScreen extends StatelessWidget {
  const BuyCoffeeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buy Me a Coffee ☕'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF6B4226), Color(0xFFA67B5B)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF6B4226).withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Text(
                    '☕',
                    style: TextStyle(fontSize: 64),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'ቡና ግዛልኝ!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Buy Me a Coffee',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'Made with ❤️ by Robel',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Message
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Icon(
                      Icons.favorite,
                      color: Colors.red[400],
                      size: 32,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'If you enjoy using this app, consider buying me an Ethiopian coffee! '
                      'Your support helps me keep building free tools for our community. '
                      'እግዚአብሔር ይስጥልኝ! 🙏',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        height: 1.6,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Telebirr Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF00BCD4), Color(0xFF0097A7)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF00BCD4).withOpacity(0.3),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.phone_android,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'Telebirr',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 16,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.3),
                      ),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          'Send to:',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Robel',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        SelectableText(
                          '0985411213',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.95),
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 2,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Open Telebirr → Send Money → Enter the number above',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Coffee amounts
            Text(
              'Suggested Amounts',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                _buildCoffeeAmount(context, '☕', 'Macchiato', 'ETB 30'),
                const SizedBox(width: 12),
                _buildCoffeeAmount(context, '☕☕', 'Buna\nCeremony', 'ETB 100'),
                const SizedBox(width: 12),
                _buildCoffeeAmount(context, '🎉', 'Big\nSupport', 'ETB 500'),
              ],
            ),

            const SizedBox(height: 32),

            // Thank you
            Text(
              'አመሰግናለሁ! 🙏',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Thank you for your support!',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildCoffeeAmount(
    BuildContext context,
    String emoji,
    String label,
    String amount,
  ) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceVariant,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Theme.of(context).colorScheme.outlineVariant,
          ),
        ),
        child: Column(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              amount,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
