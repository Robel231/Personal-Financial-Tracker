import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import '../../core/currency_formatter.dart';
import '../providers/spending_by_category_provider.dart';
import '../providers/transaction_list_provider.dart';
import '../providers/category_list_provider.dart';

class StatsScreen extends ConsumerStatefulWidget {
  const StatsScreen({super.key});

  @override
  ConsumerState<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends ConsumerState<StatsScreen> {
  late int _selectedMonth;
  late int _selectedYear;
  bool _isExpense = true; // Default to expense view
  int _touchedIndex = -1;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _selectedMonth = now.month;
    _selectedYear = now.year;
  }

  void _showMonthPicker() async {
    final now = DateTime.now();
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(_selectedYear, _selectedMonth),
      firstDate: DateTime(2020),
      lastDate: now,
      initialDatePickerMode: DatePickerMode.year,
    );

    if (selectedDate != null) {
      setState(() {
        _selectedMonth = selectedDate.month;
        _selectedYear = selectedDate.year;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final spendingAsync = ref.watch(
      spendingByCategoryProvider(
        month: _selectedMonth,
        year: _selectedYear,
        isExpense: _isExpense,
      ),
    );

    final monthlyTotalAsync = ref.watch(
      monthlyTotalProvider(
        month: _selectedMonth,
        year: _selectedYear,
        isExpense: _isExpense,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Statistics'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Month Selector
          _buildMonthSelector(),

          // Expense/Income Toggle
          _buildTypeToggle(),

          const SizedBox(height: 16),

          // Total Amount Card
          _buildTotalCard(monthlyTotalAsync),

          const SizedBox(height: 24),

          // Pie Chart and Legend
          Expanded(
            child: spendingAsync.when(
              data: (spendingData) {
                if (spendingData.isEmpty) {
                  return _buildEmptyState();
                }
                return _buildChartSection(spendingData);
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(
                child: Text('Error: $error'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMonthSelector() {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(
          Icons.calendar_month,
          color: Theme.of(context).colorScheme.onPrimaryContainer,
        ),
        title: Text(
          DateFormat('MMMM yyyy').format(
            DateTime(_selectedYear, _selectedMonth),
          ),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onPrimaryContainer,
          ),
        ),
        trailing: Icon(
          Icons.arrow_drop_down,
          color: Theme.of(context).colorScheme.onPrimaryContainer,
        ),
        onTap: _showMonthPicker,
      ),
    );
  }

  Widget _buildTypeToggle() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _isExpense = true),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: _isExpense
                      ? Colors.red.withOpacity(0.9)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Expenses',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: _isExpense ? Colors.white : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _isExpense = false),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: !_isExpense
                      ? Colors.green.withOpacity(0.9)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Income',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: !_isExpense ? Colors.white : Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTotalCard(AsyncValue<double> totalAsync) {
    return totalAsync.when(
      data: (total) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: _isExpense
                ? [Colors.red.shade400, Colors.red.shade600]
                : [Colors.green.shade400, Colors.green.shade600],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: (_isExpense ? Colors.red : Colors.green).withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          children: [
            Text(
              'Total ${_isExpense ? 'Expenses' : 'Income'}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              CurrencyFormatter.format(total),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      loading: () => const SizedBox(height: 80),
      error: (_, __) => const SizedBox(height: 80),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.pie_chart_outline,
            size: 64,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'No ${_isExpense ? 'expenses' : 'income'} this month',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChartSection(List<CategorySpending> spendingData) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Pie Chart
          SizedBox(
            height: 280,
            child: PieChart(
              PieChartData(
                pieTouchData: PieTouchData(
                  touchCallback: (FlTouchEvent event, pieTouchResponse) {
                    setState(() {
                      if (!event.isInterestedForInteractions ||
                          pieTouchResponse == null ||
                          pieTouchResponse.touchedSection == null) {
                        _touchedIndex = -1;
                        return;
                      }
                      _touchedIndex =
                          pieTouchResponse.touchedSection!.touchedSectionIndex;
                    });
                  },
                ),
                sectionsSpace: 2,
                centerSpaceRadius: 60,
                sections: _buildPieChartSections(spendingData),
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Weekly Bar Chart
          _buildWeeklyBarChart(),

          const SizedBox(height: 24),

          // Legend
          _buildLegend(spendingData),
        ],
      ),
    );
  }

  List<PieChartSectionData> _buildPieChartSections(
    List<CategorySpending> spendingData,
  ) {
    return spendingData.asMap().entries.map((entry) {
      final index = entry.key;
      final data = entry.value;
      final isTouched = index == _touchedIndex;
      final radius = isTouched ? 110.0 : 100.0;
      final fontSize = isTouched ? 18.0 : 14.0;

      return PieChartSectionData(
        color: Color(data.category.colorCode),
        value: data.totalAmount,
        title: '${data.percentage.toStringAsFixed(1)}%',
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );
    }).toList();
  }

  Widget _buildLegend(List<CategorySpending> spendingData) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Breakdown',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 12),
          ...spendingData.map((data) => _buildLegendItem(data)),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildLegendItem(CategorySpending data) {
    final budget = data.category.monthlyBudget;
    final hasBudget = budget != null && budget > 0;
    final budgetRatio = hasBudget ? data.totalAmount / budget : 0.0;
    final isWarning = hasBudget && budgetRatio >= 0.8 && budgetRatio < 1.0;
    final isOverBudget = hasBudget && budgetRatio >= 1.0;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isOverBudget
              ? const Color(0xFFbc4749)
              : isWarning
                  ? Colors.orange
                  : Colors.grey[300]!,
          width: (isOverBudget || isWarning) ? 2 : 1,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Color(data.category.colorCode).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  IconData(
                    data.category.iconCode,
                    fontFamily: 'MaterialIcons',
                  ),
                  color: Color(data.category.colorCode),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.category.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      '${data.transactionCount} transaction${data.transactionCount != 1 ? 's' : ''}',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    CurrencyFormatter.format(data.totalAmount, useShort: true),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Color(data.category.colorCode),
                    ),
                  ),
                  Text(
                    '${data.percentage.toStringAsFixed(1)}%',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
          // Budget progress bar
          if (hasBudget) ...[
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: budgetRatio > 1.0 ? 1.0 : budgetRatio,
                minHeight: 6,
                backgroundColor: Colors.grey[200],
                valueColor: AlwaysStoppedAnimation<Color>(
                  isOverBudget
                      ? const Color(0xFFbc4749)
                      : isWarning
                          ? Colors.orange
                          : const Color(0xFF6a994e),
                ),
              ),
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  isOverBudget
                      ? '⚠️ Over budget!'
                      : isWarning
                          ? '⚠️ ${(budgetRatio * 100).toStringAsFixed(0)}% used'
                          : '${(budgetRatio * 100).toStringAsFixed(0)}% of budget',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: isOverBudget
                        ? const Color(0xFFbc4749)
                        : isWarning
                            ? Colors.orange
                            : const Color(0xFF6a994e),
                  ),
                ),
                Text(
                  'Limit: ${CurrencyFormatter.format(budget, useShort: true)}',
                  style: TextStyle(fontSize: 11, color: Colors.grey[500]),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildWeeklyBarChart() {
    final transactionsAsync = ref.watch(transactionListProvider);
    final categoriesAsync = ref.watch(categoryListProvider);

    return transactionsAsync.when(
      data: (transactions) {
        return categoriesAsync.when(
          data: (categories) {
            // Build weekly totals for selected month
            final Map<int, double> weeklyTotals = {};
            for (final t in transactions) {
              if (t.date.month == _selectedMonth && t.date.year == _selectedYear) {
                final cat = categories.where((c) => c.id == t.categoryId).firstOrNull;
                if (cat == null) continue;
                final matchesType = _isExpense ? cat.isExpense : !cat.isExpense;
                if (!matchesType) continue;

                final weekOfMonth = ((t.date.day - 1) / 7).floor();
                weeklyTotals[weekOfMonth] = (weeklyTotals[weekOfMonth] ?? 0) + t.amount;
              }
            }

            if (weeklyTotals.isEmpty) return const SizedBox.shrink();

            final maxVal = weeklyTotals.values.fold(0.0, (a, b) => a > b ? a : b);

            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Weekly Trend',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 180,
                    child: BarChart(
                      BarChartData(
                        alignment: BarChartAlignment.spaceAround,
                        maxY: maxVal * 1.2,
                        barTouchData: BarTouchData(
                          touchTooltipData: BarTouchTooltipData(
                            getTooltipItem: (group, groupIndex, rod, rodIndex) {
                              return BarTooltipItem(
                                CurrencyFormatter.format(rod.toY, useShort: true),
                                const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              );
                            },
                          ),
                        ),
                        titlesData: FlTitlesData(
                          show: true,
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (value, meta) {
                                final labels = ['Week 1', 'Week 2', 'Week 3', 'Week 4', 'Week 5'];
                                if (value.toInt() < labels.length) {
                                  return Padding(
                                    padding: const EdgeInsets.only(top: 8),
                                    child: Text(
                                      labels[value.toInt()],
                                      style: const TextStyle(fontSize: 11),
                                    ),
                                  );
                                }
                                return const SizedBox.shrink();
                              },
                            ),
                          ),
                          leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        ),
                        borderData: FlBorderData(show: false),
                        gridData: const FlGridData(show: false),
                        barGroups: List.generate(5, (i) {
                          final val = weeklyTotals[i] ?? 0;
                          return BarChartGroupData(
                            x: i,
                            barRods: [
                              BarChartRodData(
                                toY: val,
                                width: 22,
                                borderRadius: const BorderRadius.vertical(top: Radius.circular(6)),
                                gradient: LinearGradient(
                                  colors: _isExpense
                                      ? [const Color(0xFFbc4749), const Color(0xFFbc4749).withOpacity(0.6)]
                                      : [const Color(0xFF386641), const Color(0xFF6a994e)],
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                ),
                              ),
                            ],
                          );
                        }),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
          loading: () => const SizedBox.shrink(),
          error: (_, __) => const SizedBox.shrink(),
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
    );
  }
}
