import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kharcha/theme/app_colors.dart';
import 'package:kharcha/theme/app_spacing.dart';
import 'package:kharcha/theme/app_typography.dart';
import 'package:kharcha/features/auth/user_session.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'dart:math' as math;

// ─── Data Models ─────────────────────────────────────────────────────────────

class _BarEntry {
  final String label;
  final double income;
  final double expense;
  _BarEntry(this.label, this.income, this.expense);
}

class _Segment {
  final double value;
  final Color color;
  final String label;
  final String amount;
  _Segment(this.value, this.color, this.label, this.amount);
}

class _BudgetEntry {
  final String label;
  final double spent;
  final double budget;
  final Color color;
  _BudgetEntry(this.label, this.spent, this.budget, this.color);
}

class _MerchantEntry {
  final String name;
  final String category;
  final String amount;
  final Color color;
  final String emoji;
  _MerchantEntry(this.name, this.category, this.amount, this.color, this.emoji);
}

class _PeriodData {
  final double totalSpent;
  final double totalIncome;
  final double savings;
  final double savingsRate;
  final double prevSpent;
  final List<_BarEntry> bars;
  final List<_Segment> categories;
  final List<double> cashFlow;
  final List<_BudgetEntry> budgets;
  final List<_MerchantEntry> merchants;
  final String insightText;
  final String insightTitle;
  _PeriodData({
    required this.totalSpent,
    required this.totalIncome,
    required this.savings,
    required this.savingsRate,
    required this.prevSpent,
    required this.bars,
    required this.categories,
    required this.cashFlow,
    required this.budgets,
    required this.merchants,
    required this.insightText,
    required this.insightTitle,
  });
}

// ─── Period Datasets ─────────────────────────────────────────────────────────

final _weekData = _PeriodData(
  totalSpent: 8200,
  totalIncome: 22500,
  savings: 14300,
  savingsRate: 0.636,
  prevSpent: 7100,
  bars: [
    _BarEntry('Mon', 3200, 1200),
    _BarEntry('Tue', 3200, 2800),
    _BarEntry('Wed', 3200, 900),
    _BarEntry('Thu', 3200, 3500),
    _BarEntry('Fri', 3200, 1800),
    _BarEntry('Sat', 3200, 4200),
    _BarEntry('Sun', 3200, 2100),
  ],
  categories: [
    _Segment(0.36, AppColors.accent, 'Food & Dining', 'Rs. 2,952'),
    _Segment(0.26, const Color(0xFF1C1C1E), 'Transport', 'Rs. 2,132'),
    _Segment(0.20, const Color(0xFF6B7280), 'Shopping', 'Rs. 1,640'),
    _Segment(0.11, const Color(0xFF10B981), 'Health', 'Rs. 902'),
    _Segment(0.07, const Color(0xFF8B5CF6), 'Others', 'Rs. 574'),
  ],
  cashFlow: [0.25, 0.48, 0.35, 0.60, 0.45, 0.72, 0.64],
  budgets: [
    _BudgetEntry('Food & Dining', 2952, 3500, AppColors.accent),
    _BudgetEntry('Transport', 2132, 2500, const Color(0xFF10B981)),
    _BudgetEntry('Shopping', 1640, 1500, AppColors.danger),
    _BudgetEntry('Health', 902, 1500, const Color(0xFF10B981)),
    _BudgetEntry('Others', 574, 1000, const Color(0xFF8B5CF6)),
  ],
  merchants: [
    _MerchantEntry('Starbucks', 'Food & Dining', 'Rs. 1,400', AppColors.accent, '☕'),
    _MerchantEntry('Careem', 'Transport', 'Rs. 1,200', const Color(0xFF1C1C1E), '🚗'),
    _MerchantEntry('Imtiaz Store', 'Shopping', 'Rs. 900', const Color(0xFF6B7280), '🛒'),
    _MerchantEntry('ChemistWarehouse', 'Health', 'Rs. 650', const Color(0xFF10B981), '💊'),
  ],
  insightTitle: 'Your Week Story',
  insightText:
      '"Saturday was your biggest spending day at Rs. 4,200. You\'re on track for the week — only 1 budget category overspent. Keep it up!"',
);

final _monthData = _PeriodData(
  totalSpent: 38200,
  totalIncome: 90000,
  savings: 51800,
  savingsRate: 0.576,
  prevSpent: 33800,
  bars: [
    _BarEntry('Wk 1', 22500, 8400),
    _BarEntry('Wk 2', 22500, 10200),
    _BarEntry('Wk 3', 22500, 9600),
    _BarEntry('Wk 4', 22500, 10000),
  ],
  categories: [
    _Segment(0.38, AppColors.accent, 'Food & Dining', 'Rs. 14,516'),
    _Segment(0.24, const Color(0xFF1C1C1E), 'Transport', 'Rs. 9,168'),
    _Segment(0.19, const Color(0xFF6B7280), 'Shopping', 'Rs. 7,258'),
    _Segment(0.12, const Color(0xFF10B981), 'Health', 'Rs. 4,584'),
    _Segment(0.07, const Color(0xFF8B5CF6), 'Others', 'Rs. 2,674'),
  ],
  cashFlow: [0.15, 0.42, 0.30, 0.68, 0.55, 0.78, 0.62, 0.85, 0.70, 0.90, 0.75, 0.95],
  budgets: [
    _BudgetEntry('Food & Dining', 14516, 18000, AppColors.accent),
    _BudgetEntry('Transport', 9168, 12000, const Color(0xFF10B981)),
    _BudgetEntry('Shopping', 7258, 6000, AppColors.danger),
    _BudgetEntry('Health', 4584, 8000, const Color(0xFF10B981)),
    _BudgetEntry('Others', 2674, 5000, const Color(0xFF8B5CF6)),
  ],
  merchants: [
    _MerchantEntry('Starbucks', 'Food & Dining', 'Rs. 4,200', AppColors.accent, '☕'),
    _MerchantEntry('Careem', 'Transport', 'Rs. 3,800', const Color(0xFF1C1C1E), '🚗'),
    _MerchantEntry('Imtiaz Store', 'Shopping', 'Rs. 2,100', const Color(0xFF6B7280), '🛒'),
    _MerchantEntry('ChemistWarehouse', 'Health', 'Rs. 1,890', const Color(0xFF10B981), '💊'),
  ],
  insightTitle: 'Your March Story',
  insightText:
      '"You spent 13% more than last month, mostly on weekends. Thursday was your biggest spending day. Your savings rate of 57.6% puts you in the top 15% of users!"',
);

final _yearData = _PeriodData(
  totalSpent: 412000,
  totalIncome: 980000,
  savings: 568000,
  savingsRate: 0.580,
  prevSpent: 395000,
  bars: [
    _BarEntry('Apr', 82000, 34000),
    _BarEntry('May', 80000, 30000),
    _BarEntry('Jun', 75000, 36000),
    _BarEntry('Jul', 85000, 32000),
    _BarEntry('Aug', 78000, 28000),
    _BarEntry('Sep', 82000, 40000),
    _BarEntry('Oct', 84000, 34500),
    _BarEntry('Nov', 88000, 37200),
    _BarEntry('Dec', 90000, 52000),
    _BarEntry('Jan', 85000, 35900),
    _BarEntry('Feb', 80000, 38600),
    _BarEntry('Mar', 91000, 43800),
  ],
  categories: [
    _Segment(0.34, AppColors.accent, 'Food & Dining', 'Rs. 1,40,080'),
    _Segment(0.22, const Color(0xFF1C1C1E), 'Transport', 'Rs. 90,640'),
    _Segment(0.21, const Color(0xFF6B7280), 'Shopping', 'Rs. 86,520'),
    _Segment(0.14, const Color(0xFF10B981), 'Health', 'Rs. 57,680'),
    _Segment(0.09, const Color(0xFF8B5CF6), 'Others', 'Rs. 37,080'),
  ],
  cashFlow: [0.35, 0.42, 0.48, 0.55, 0.50, 0.62, 0.58, 0.70, 0.80, 0.72, 0.78, 0.85],
  budgets: [
    _BudgetEntry('Food & Dining', 140080, 150000, AppColors.accent),
    _BudgetEntry('Transport', 90640, 100000, const Color(0xFF10B981)),
    _BudgetEntry('Shopping', 86520, 80000, AppColors.danger),
    _BudgetEntry('Health', 57680, 70000, const Color(0xFF10B981)),
    _BudgetEntry('Others', 37080, 50000, const Color(0xFF8B5CF6)),
  ],
  merchants: [
    _MerchantEntry('Starbucks', 'Food & Dining', 'Rs. 48,200', AppColors.accent, '☕'),
    _MerchantEntry('Careem', 'Transport', 'Rs. 41,600', const Color(0xFF1C1C1E), '🚗'),
    _MerchantEntry('Imtiaz Store', 'Shopping', 'Rs. 32,100', const Color(0xFF6B7280), '🛒'),
    _MerchantEntry('ChemistWarehouse', 'Health', 'Rs. 22,800', const Color(0xFF10B981), '💊'),
  ],
  insightTitle: 'Your Year Story',
  insightText:
      '"December was your biggest spending month at Rs. 52,000 (festive season). You saved Rs. 5,68,000 this year — a 58% savings rate. Outstanding financial discipline!"',
);

String _fmt(double v) {
  if (v >= 100000) return 'Rs. ${(v / 1000).toStringAsFixed(0)}k';
  if (v >= 1000) {
    final s = v.toInt().toString();
    return 'Rs. ${s.replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]},')}';
  }
  return 'Rs. ${v.toInt()}';
}

// ─── Screen ──────────────────────────────────────────────────────────────────

class AnalyticsScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const AnalyticsScreen({super.key, this.onBack});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen>
    with TickerProviderStateMixin {
  String _period = 'Month';
  int _chartTab = 0;

  late AnimationController _entrance;
  late AnimationController _chartAnim;
  late AnimationController _donutAnim;
  late AnimationController _pulse;

  _PeriodData get _data =>
      _period == 'Week' ? _weekData : _period == 'Year' ? _yearData : _monthData;

  @override
  void initState() {
    super.initState();
    _entrance = AnimationController(vsync: this, duration: const Duration(milliseconds: 1600))..forward();
    _chartAnim = AnimationController(vsync: this, duration: const Duration(milliseconds: 900))..forward();
    _donutAnim = AnimationController(vsync: this, duration: const Duration(milliseconds: 1200))..forward();
    _pulse = AnimationController(vsync: this, duration: const Duration(milliseconds: 2000))..repeat(reverse: true);
  }

  @override
  void dispose() {
    _entrance.dispose();
    _chartAnim.dispose();
    _donutAnim.dispose();
    _pulse.dispose();
    super.dispose();
  }

  void _changePeriod(String p) {
    if (p == _period) return;
    HapticFeedback.lightImpact();
    setState(() {
      _period = p;
      _chartTab = 0;
    });
    _chartAnim.forward(from: 0);
    _donutAnim.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    final d = _data;
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.screenHorizontal, AppSpacing.md,
            AppSpacing.screenHorizontal, 140,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _header(),
              const SizedBox(height: AppSpacing.lg),
              _periodSelector(),
              const SizedBox(height: AppSpacing.xl),
              _summaryRow(d),
              const SizedBox(height: AppSpacing.xl),
              _incomeExpenseChart(d),
              const SizedBox(height: AppSpacing.xl),
              _savingsCard(d),
              const SizedBox(height: AppSpacing.xl),
              _cashFlowSection(d),
              const SizedBox(height: AppSpacing.xl),
              _categorySection(d),
              const SizedBox(height: AppSpacing.xl),
              _budgetSection(d),
              const SizedBox(height: AppSpacing.xl),
              _merchantSection(d),
              const SizedBox(height: AppSpacing.xl),
              _insightCard(d),
            ],
          ),
        ),
      ),
    );
  }

  Widget _header() {
    final session = UserSession.instance;
    return _fadeSlide(0.0, 0.3,
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(children: [
            if (widget.onBack != null) ...[
              _circleBtn(PhosphorIcons.caretLeft(PhosphorIconsStyle.bold),
                  onTap: () { HapticFeedback.lightImpact(); widget.onBack?.call(); }),
              const SizedBox(width: 14),
            ],
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(session.greeting,
                style: AppTypography.caption.copyWith(
                  color: AppColors.textTertiary, fontWeight: FontWeight.w500)),
              Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                Text('Analytics',
                  style: AppTypography.h2.copyWith(fontWeight: FontWeight.w900)),
                if (session.isLoggedIn) ...[
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(mainAxisSize: MainAxisSize.min, children: [
                      Container(
                        width: 18, height: 18,
                        decoration: const BoxDecoration(
                          color: AppColors.accent,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(session.initial,
                            style: const TextStyle(
                              color: Colors.white, fontSize: 10,
                              fontWeight: FontWeight.w800)),
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text(session.name,
                        style: AppTypography.caption.copyWith(
                          color: Colors.white, fontWeight: FontWeight.w700)),
                    ]),
                  ),
                ],
              ]),
            ]),
          ]),
          _circleBtn(PhosphorIcons.shareNetwork(PhosphorIconsStyle.light)),
        ],
      ),
    );
  }

  Widget _circleBtn(IconData icon, {VoidCallback? onTap}) => GestureDetector(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white, shape: BoxShape.circle,
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 12, offset: const Offset(0, 4))],
      ),
      child: Icon(icon, color: AppColors.primary, size: 20),
    ),
  );

  // ── Period Selector ──────────────────────────────────────────────────────────

  Widget _periodSelector() => _fadeSlide(0.1, 0.4,
    Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(color: AppColors.surfaceVariant, borderRadius: BorderRadius.circular(16)),
      child: Row(
        children: ['Week', 'Month', 'Year'].map((p) {
          final sel = _period == p;
          return Expanded(
            child: GestureDetector(
              onTap: () => _changePeriod(p),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 220),
                curve: Curves.easeOutCubic,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: sel ? AppColors.primary : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: sel
                    ? [BoxShadow(color: AppColors.primary.withValues(alpha: 0.25), blurRadius: 8, offset: const Offset(0, 2))]
                    : null,
                ),
                alignment: Alignment.center,
                child: Text(p,
                  style: AppTypography.bodySmall.copyWith(
                    fontWeight: sel ? FontWeight.w700 : FontWeight.w600,
                    color: sel ? Colors.white : AppColors.textPrimary.withValues(alpha: 0.45),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    ),
  );

  // ── Summary Row ───────────────────────────────────────────────────────────────

  Widget _summaryRow(_PeriodData d) {
    final pctDiff = ((d.totalSpent - d.prevSpent) / d.prevSpent * 100).abs().toStringAsFixed(0);
    final isUp = d.totalSpent > d.prevSpent;
    return _fadeSlide(0.15, 0.45,
      Row(children: [
        Expanded(child: _statCard('Total Spent', _fmt(d.totalSpent),
          '${isUp ? "↑" : "↓"} $pctDiff% vs last',
          isUp ? AppColors.danger : AppColors.success,
          PhosphorIcons.currencyCircleDollar(PhosphorIconsStyle.bold),
          AppColors.danger, const Color(0xFFFFEDEA))),
        const SizedBox(width: 10),
        Expanded(child: _statCard('Income', _fmt(d.totalIncome), 'This $_period',
          AppColors.success,
          PhosphorIcons.arrowDown(PhosphorIconsStyle.bold),
          AppColors.success, const Color(0xFFDFF5EA))),
        const SizedBox(width: 10),
        Expanded(child: _statCard('Savings', _fmt(d.savings),
          '${(d.savingsRate * 100).toStringAsFixed(1)}% rate',
          AppColors.accent,
          PhosphorIcons.piggyBank(PhosphorIconsStyle.bold),
          AppColors.accent, const Color(0xFFFFF4E0))),
      ]),
    );
  }

  Widget _statCard(String label, String value, String sub, Color subColor,
      IconData icon, Color iconColor, Color bg) =>
    Container(
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 12, offset: const Offset(0, 4))],
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          padding: const EdgeInsets.all(7),
          decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(10)),
          child: Icon(icon, color: iconColor, size: 14),
        ),
        const SizedBox(height: 10),
        Text(value, style: AppTypography.h3.copyWith(fontSize: 13, fontWeight: FontWeight.w900)),
        const SizedBox(height: 2),
        Text(label, style: AppTypography.caption.copyWith(fontSize: 10)),
        const SizedBox(height: 3),
        Text(sub, style: AppTypography.caption.copyWith(color: subColor, fontWeight: FontWeight.w700, fontSize: 10)),
      ]),
    );

  // ── Income vs Expense Chart ───────────────────────────────────────────────────

  Widget _incomeExpenseChart(_PeriodData d) {
    final bars = d.bars;
    final maxVal = bars.map((b) => b.income).reduce((a, b) => a > b ? a : b);
    final showIncome = _chartTab != 2;
    final showExpense = _chartTab != 1;

    return _fadeSlide(0.2, 0.5,
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        _sectionTitle('Income vs Expenses',
            sub: _period == 'Week' ? 'Daily this week'
                : _period == 'Month' ? 'Weekly this month'
                : 'Monthly this year'),
        const SizedBox(height: AppSpacing.md),
        Container(
          padding: const EdgeInsets.all(18),
          decoration: _card(),
          child: Column(children: [
            // Tabs
            Row(children: [
              _chartTabBtn(0, 'Overview'),
              const SizedBox(width: 8),
              _chartTabBtn(1, 'Income'),
              const SizedBox(width: 8),
              _chartTabBtn(2, 'Expense'),
            ]),
            const SizedBox(height: 16),
            // Legend
            Row(children: [
              _dot(AppColors.success), const SizedBox(width: 5),
              Text('Income', style: AppTypography.caption.copyWith(fontWeight: FontWeight.w600)),
              const SizedBox(width: 14),
              _dot(AppColors.accent), const SizedBox(width: 5),
              Text('Expense', style: AppTypography.caption.copyWith(fontWeight: FontWeight.w600)),
            ]),
            const SizedBox(height: 18),
            SizedBox(
              height: 150,
              child: AnimatedBuilder(
                animation: _chartAnim,
                builder: (_, __) => Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: bars.map((b) {
                    final barW = showIncome && showExpense ? 11.0 : 20.0;
                    return Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                      Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
                        if (showIncome) Container(
                          width: barW,
                          height: (140 * (b.income / maxVal) * _chartAnim.value).clamp(2.0, 140.0),
                          decoration: BoxDecoration(color: AppColors.success, borderRadius: BorderRadius.circular(4)),
                        ),
                        if (showIncome && showExpense) const SizedBox(width: 2),
                        if (showExpense) Container(
                          width: barW,
                          height: (140 * (b.expense / maxVal) * _chartAnim.value).clamp(2.0, 140.0),
                          decoration: BoxDecoration(color: AppColors.accent, borderRadius: BorderRadius.circular(4)),
                        ),
                      ]),
                    ]);
                  }).toList(),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: bars.map((b) => Text(b.label,
                style: AppTypography.caption.copyWith(color: AppColors.textPrimary.withValues(alpha: 0.4), fontSize: 10),
              )).toList(),
            ),
          ]),
        ),
      ]),
    );
  }

  Widget _chartTabBtn(int idx, String label) {
    final active = _chartTab == idx;
    return GestureDetector(
      onTap: () {
        HapticFeedback.selectionClick();
        setState(() => _chartTab = idx);
        _chartAnim.forward(from: 0);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: active ? AppColors.primary : AppColors.surfaceVariant,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(label,
          style: AppTypography.caption.copyWith(
            fontWeight: FontWeight.w700,
            color: active ? Colors.white : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }

  // ── Savings Rate Card ──────────────────────────────────────────────────────────

  Widget _savingsCard(_PeriodData d) => _fadeSlide(0.25, 0.55,
    Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft, end: Alignment.bottomRight,
          colors: [Color(0xFF1C1C1E), Color(0xFF3A3A4A)],
        ),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [BoxShadow(color: AppColors.primary.withValues(alpha: 0.3), blurRadius: 24, offset: const Offset(0, 12))],
      ),
      child: Row(children: [
        SizedBox(
          width: 105, height: 105,
          child: AnimatedBuilder(
            animation: _donutAnim,
            builder: (_, __) => CustomPaint(
              painter: _ArcPainter(
                progress: d.savingsRate * _donutAnim.value,
                bg: Colors.white.withValues(alpha: 0.1),
                fg: AppColors.accent,
              ),
              child: Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
                Text('${(d.savingsRate * 100).toStringAsFixed(1)}%',
                  style: AppTypography.h3.copyWith(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 16)),
                Text('saved', style: AppTypography.caption.copyWith(color: Colors.white54)),
              ])),
            ),
          ),
        ),
        const SizedBox(width: 20),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Savings Rate', style: AppTypography.h3.copyWith(color: Colors.white, fontWeight: FontWeight.w800)),
          const SizedBox(height: 6),
          Text('You saved ${_fmt(d.savings)} this $_period.',
            style: AppTypography.bodySmall.copyWith(color: Colors.white.withValues(alpha: 0.65), height: 1.5)),
          const SizedBox(height: 12),
          Wrap(spacing: 6, children: [
            _badge('🏆', 'Top 15%'),
            _badge('📈', '+4% MoM'),
          ]),
        ])),
      ]),
    ),
  );

  Widget _badge(String emoji, String text) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
    decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(20)),
    child: Row(mainAxisSize: MainAxisSize.min, children: [
      Text(emoji, style: const TextStyle(fontSize: 11)),
      const SizedBox(width: 4),
      Text(text, style: AppTypography.caption.copyWith(color: Colors.white, fontWeight: FontWeight.w700)),
    ]),
  );

  // ── Cash Flow Line Chart ──────────────────────────────────────────────────────

  Widget _cashFlowSection(_PeriodData d) => _fadeSlide(0.3, 0.6,
    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      _sectionTitle('Cash Flow', sub: 'Balance trend this $_period'),
      const SizedBox(height: AppSpacing.md),
      Container(
        padding: const EdgeInsets.all(18),
        decoration: _card(),
        child: Column(children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            _cashStat('Income', _fmt(d.totalIncome), AppColors.success),
            _cashStat('Spent', _fmt(d.totalSpent), AppColors.danger),
            _cashStat('Saved', _fmt(d.savings), AppColors.accent),
          ]),
          const SizedBox(height: 20),
          SizedBox(
            height: 120,
            child: AnimatedBuilder(
              animation: _chartAnim,
              builder: (_, __) => CustomPaint(
                size: const Size(double.infinity, 120),
                painter: _LinePainter(
                  points: d.cashFlow,
                  progress: _chartAnim.value,
                  lineColor: AppColors.accent,
                  fillColor: AppColors.accent.withValues(alpha: 0.08),
                ),
              ),
            ),
          ),
          const SizedBox(height: 6),
          _cashFlowXLabels(d),
        ]),
      ),
    ]),
  );

  Widget _cashFlowXLabels(_PeriodData d) {
    List<String> labels;
    if (_period == 'Week') labels = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    else if (_period == 'Month') labels = ['1', '7', '14', '21', '25', '28', '30', '—', '—', '—', '—', '—'];
    else labels = ['J', 'F', 'M', 'A', 'M', 'J', 'J', 'A', 'S', 'O', 'N', 'D'];
    final count = d.cashFlow.length;
    final show = labels.length >= count ? labels.sublist(0, count) : labels;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: show.map((l) => Text(l,
        style: AppTypography.caption.copyWith(color: AppColors.textPrimary.withValues(alpha: 0.35), fontSize: 9),
      )).toList(),
    );
  }

  Widget _cashStat(String label, String val, Color color) => Column(children: [
    Text(val, style: AppTypography.caption.copyWith(fontWeight: FontWeight.w800, color: color, fontSize: 12)),
    Text(label, style: AppTypography.caption.copyWith(color: AppColors.textTertiary)),
  ]);

  // ── Category Donut ────────────────────────────────────────────────────────────

  Widget _categorySection(_PeriodData d) => _fadeSlide(0.35, 0.65,
    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      _sectionTitle('Category Breakdown', sub: 'Where money went'),
      const SizedBox(height: AppSpacing.md),
      Container(
        padding: const EdgeInsets.all(18),
        decoration: _card(),
        child: Column(children: [
          Row(children: [
            Expanded(flex: 5, child: AspectRatio(
              aspectRatio: 1,
              child: AnimatedBuilder(
                animation: _donutAnim,
                builder: (_, __) => Stack(alignment: Alignment.center, children: [
                  CustomPaint(
                    size: Size.infinite,
                    painter: _DonutPainter(progress: _donutAnim.value, segs: d.categories),
                  ),
                  Column(mainAxisSize: MainAxisSize.min, children: [
                    Text(_fmt(d.totalSpent),
                      style: AppTypography.h3.copyWith(fontWeight: FontWeight.w900, fontSize: 12)),
                    Text('Spent', style: AppTypography.caption.copyWith(color: AppColors.textTertiary)),
                  ]),
                ]),
              ),
            )),
            const SizedBox(width: 20),
            Expanded(flex: 6, child: Column(
              children: d.categories.map((s) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Row(children: [
                  _dot(s.color),
                  const SizedBox(width: 8),
                  Expanded(child: Text(s.label,
                    style: AppTypography.caption.copyWith(fontWeight: FontWeight.w600),
                    overflow: TextOverflow.ellipsis)),
                  Text(s.amount,
                    style: AppTypography.caption.copyWith(color: AppColors.textSecondary, fontWeight: FontWeight.w700, fontSize: 10)),
                ]),
              )).toList(),
            )),
          ]),
          const SizedBox(height: 16),
          ...d.categories.map((s) => Padding(
            padding: const EdgeInsets.only(bottom: 9),
            child: Row(children: [
              SizedBox(width: 78, child: Text(s.label,
                style: AppTypography.caption.copyWith(fontSize: 10), overflow: TextOverflow.ellipsis)),
              const SizedBox(width: 8),
              Expanded(child: Stack(children: [
                Container(height: 6, decoration: BoxDecoration(color: AppColors.border, borderRadius: BorderRadius.circular(3))),
                AnimatedBuilder(
                  animation: _donutAnim,
                  builder: (_, __) => FractionallySizedBox(
                    widthFactor: s.value * _donutAnim.value,
                    child: Container(height: 6, decoration: BoxDecoration(color: s.color, borderRadius: BorderRadius.circular(3))),
                  ),
                ),
              ])),
              const SizedBox(width: 8),
              SizedBox(width: 30, child: Text('${(s.value * 100).toInt()}%',
                style: AppTypography.caption.copyWith(fontWeight: FontWeight.w700, color: s.color, fontSize: 10),
                textAlign: TextAlign.right)),
            ]),
          )),
        ]),
      ),
    ]),
  );

  // ── Budget Progress ────────────────────────────────────────────────────────────

  Widget _budgetSection(_PeriodData d) => _fadeSlide(0.4, 0.7,
    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      _sectionTitle('Budget Progress', sub: '${_period}ly limits'),
      const SizedBox(height: AppSpacing.md),
      Container(
        padding: const EdgeInsets.all(18),
        decoration: _card(),
        child: Column(
          children: d.budgets.asMap().entries.map((e) {
            final i = e.key;
            final b = e.value;
            return Column(children: [
              if (i > 0) const SizedBox(height: 16),
              _budgetRow(b),
            ]);
          }).toList(),
        ),
      ),
    ]),
  );

  Widget _budgetRow(_BudgetEntry b) {
    final pct = (b.spent / b.budget).clamp(0.0, 1.0);
    final over = b.spent > b.budget;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Row(children: [
          _dot(b.color),
          const SizedBox(width: 8),
          Text(b.label, style: AppTypography.body.copyWith(fontWeight: FontWeight.w700, fontSize: 13)),
        ]),
        Row(children: [
          if (over) Padding(
            padding: const EdgeInsets.only(right: 4),
            child: Icon(PhosphorIcons.warningCircle(PhosphorIconsStyle.fill), color: AppColors.danger, size: 15),
          ),
          Text(
            over ? 'Over by ${_fmt(b.spent - b.budget)}' : '${_fmt(b.budget - b.spent)} left',
            style: AppTypography.caption.copyWith(
              color: over ? AppColors.danger : AppColors.textSecondary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ]),
      ]),
      const SizedBox(height: 7),
      Stack(children: [
        Container(height: 8, decoration: BoxDecoration(color: AppColors.border, borderRadius: BorderRadius.circular(4))),
        AnimatedBuilder(
          animation: _chartAnim,
          builder: (_, __) => FractionallySizedBox(
            widthFactor: pct * _chartAnim.value,
            child: Container(
              height: 8,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: over
                  ? [AppColors.danger, AppColors.danger.withValues(alpha: 0.7)]
                  : [b.color, b.color.withValues(alpha: 0.7)]),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ),
      ]),
      const SizedBox(height: 4),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(_fmt(b.spent), style: AppTypography.caption.copyWith(color: AppColors.textSecondary)),
        Text('${(pct * 100).toInt()}% of ${_fmt(b.budget)}',
          style: AppTypography.caption.copyWith(fontWeight: FontWeight.w700, color: b.color)),
      ]),
    ]);
  }

  // ── Top Merchants ─────────────────────────────────────────────────────────────

  Widget _merchantSection(_PeriodData d) => _fadeSlide(0.45, 0.75,
    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      _sectionTitle('Top Merchants', sub: 'Highest spending this $_period'),
      const SizedBox(height: AppSpacing.md),
      Container(
        decoration: _card(),
        child: Column(
          children: d.merchants.asMap().entries.map((e) {
            final i = e.key;
            final m = e.value;
            return Column(children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                child: Row(children: [
                  Container(
                    width: 42, height: 42,
                    decoration: BoxDecoration(color: m.color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(12)),
                    child: Center(child: Text(m.emoji, style: const TextStyle(fontSize: 20))),
                  ),
                  const SizedBox(width: 12),
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(m.name, style: AppTypography.body.copyWith(fontWeight: FontWeight.w700, fontSize: 13)),
                    Text(m.category, style: AppTypography.caption.copyWith(color: AppColors.textTertiary)),
                  ])),
                  Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                    Text(m.amount, style: AppTypography.body.copyWith(fontWeight: FontWeight.w800, fontSize: 13)),
                    Text('#${i + 1}', style: AppTypography.caption.copyWith(color: m.color, fontWeight: FontWeight.w700)),
                  ]),
                ]),
              ),
              if (i < d.merchants.length - 1)
                Divider(height: 1, thickness: 1, color: AppColors.divider, indent: 18, endIndent: 18),
            ]);
          }).toList(),
        ),
      ),
    ]),
  );

  // ── AI Insight Card ────────────────────────────────────────────────────────────

  Widget _insightCard(_PeriodData d) => _fadeSlide(0.5, 0.8,
    Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: AppColors.accent.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: AppColors.accent.withValues(alpha: 0.18)),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          AnimatedBuilder(
            animation: _pulse,
            builder: (_, __) => Transform.scale(
              scale: 1.0 + 0.06 * _pulse.value,
              child: const Text('✨', style: TextStyle(fontSize: 22)),
            ),
          ),
          const SizedBox(width: 10),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Smart Insight',
              style: AppTypography.caption.copyWith(color: AppColors.accent.withValues(alpha: 0.7), fontWeight: FontWeight.w600)),
            Text(d.insightTitle,
              style: AppTypography.h3.copyWith(color: AppColors.accent, fontWeight: FontWeight.w800)),
          ]),
        ]),
        const SizedBox(height: 14),
        Text(d.insightText,
          style: AppTypography.body.copyWith(height: 1.65, color: AppColors.primary.withValues(alpha: 0.7), fontSize: 14)),
        const SizedBox(height: 18),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Row(children: [
            Text('Read Full Story',
              style: AppTypography.bodySmall.copyWith(fontWeight: FontWeight.w800, color: AppColors.accent)),
            const SizedBox(width: 4),
            Icon(PhosphorIcons.arrowRight(PhosphorIconsStyle.bold), color: AppColors.accent, size: 14),
          ]),
          Row(children: [
            _chip('💡 Save More'),
            const SizedBox(width: 6),
            _chip('📊 Trends'),
          ]),
        ]),
      ]),
    ),
  );

  Widget _chip(String text) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(color: AppColors.accent.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(20)),
    child: Text(text, style: AppTypography.caption.copyWith(color: AppColors.accent, fontWeight: FontWeight.w700, fontSize: 10)),
  );

  // ── Helpers ────────────────────────────────────────────────────────────────────

  Widget _fadeSlide(double from, double to, Widget child) => FadeTransition(
    opacity: CurvedAnimation(parent: _entrance, curve: Interval(from, to, curve: Curves.easeOut)),
    child: SlideTransition(
      position: Tween<Offset>(begin: const Offset(0, 0.06), end: Offset.zero).animate(
        CurvedAnimation(parent: _entrance, curve: Interval(from, to, curve: Curves.easeOutCubic))),
      child: child,
    ),
  );

  BoxDecoration _card() => BoxDecoration(
    color: Colors.white, borderRadius: BorderRadius.circular(24),
    boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 16, offset: const Offset(0, 6))],
  );

  Widget _sectionTitle(String t, {String? sub}) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(t, style: AppTypography.h3.copyWith(fontWeight: FontWeight.w800)),
      if (sub != null) Text(sub, style: AppTypography.caption.copyWith(color: AppColors.textTertiary)),
    ],
  );

  Widget _dot(Color c) => Container(
    width: 8, height: 8, decoration: BoxDecoration(color: c, shape: BoxShape.circle));
}

// ─── Custom Painters ──────────────────────────────────────────────────────────

class _DonutPainter extends CustomPainter {
  final double progress;
  final List<_Segment> segs;
  _DonutPainter({required this.progress, required this.segs});

  @override
  void paint(Canvas canvas, Size size) {
    final c = Offset(size.width / 2, size.height / 2);
    final r = math.min(size.width, size.height) / 2;
    final sw = r * 0.28;
    final rect = Rect.fromCircle(center: c, radius: r - sw / 2);
    double start = -math.pi / 2;
    for (final s in segs) {
      final sweep = (2 * math.pi * s.value * progress - 0.03).clamp(0.0, 2 * math.pi);
      canvas.drawArc(rect, start, sweep, false,
        Paint()..color = s.color..style = PaintingStyle.stroke..strokeWidth = sw..strokeCap = StrokeCap.round);
      start += 2 * math.pi * s.value * progress;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => true;
}

class _ArcPainter extends CustomPainter {
  final double progress;
  final Color bg;
  final Color fg;
  _ArcPainter({required this.progress, required this.bg, required this.fg});

  @override
  void paint(Canvas canvas, Size size) {
    final c = Offset(size.width / 2, size.height / 2);
    final r = math.min(size.width, size.height) / 2 - 8;
    final rect = Rect.fromCircle(center: c, radius: r);
    const sw = 10.0;
    canvas.drawArc(rect, math.pi * 0.75, math.pi * 1.5, false,
      Paint()..color = bg..style = PaintingStyle.stroke..strokeWidth = sw..strokeCap = StrokeCap.round);
    canvas.drawArc(rect, math.pi * 0.75, math.pi * 1.5 * progress, false,
      Paint()..color = fg..style = PaintingStyle.stroke..strokeWidth = sw..strokeCap = StrokeCap.round);
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => true;
}

class _LinePainter extends CustomPainter {
  final List<double> points;
  final double progress;
  final Color lineColor;
  final Color fillColor;
  _LinePainter({required this.points, required this.progress, required this.lineColor, required this.fillColor});

  @override
  void paint(Canvas canvas, Size size) {
    if (points.length < 2) return;
    final total = (points.length * progress).round().clamp(2, points.length);
    final pts = points.sublist(0, total);
    final stepX = size.width / (points.length - 1);
    final offsets = <Offset>[for (int i = 0; i < pts.length; i++) Offset(i * stepX, size.height * (1 - pts[i]))];

    final fill = Path()..moveTo(offsets.first.dx, size.height);
    for (final o in offsets) fill.lineTo(o.dx, o.dy);
    fill..lineTo(offsets.last.dx, size.height)..close();
    canvas.drawPath(fill, Paint()..color = fillColor);

    final line = Path()..moveTo(offsets[0].dx, offsets[0].dy);
    for (int i = 1; i < offsets.length; i++) {
      final p = offsets[i - 1];
      final q = offsets[i];
      line.cubicTo((p.dx + q.dx) / 2, p.dy, (p.dx + q.dx) / 2, q.dy, q.dx, q.dy);
    }
    canvas.drawPath(line, Paint()
      ..color = lineColor..strokeWidth = 2.5..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round..strokeJoin = StrokeJoin.round);

    canvas.drawCircle(offsets.last, 4, Paint()..color = lineColor);
    canvas.drawCircle(offsets.last, 7, Paint()..color = lineColor.withValues(alpha: 0.2));
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => true;
}
