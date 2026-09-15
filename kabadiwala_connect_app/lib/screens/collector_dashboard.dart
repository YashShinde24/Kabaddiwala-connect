import 'package:flutter/material.dart';
import '../app_colors.dart';
import '../components/indicators_and_badges.dart';

class CollectorDashboard extends StatefulWidget {
  const CollectorDashboard({super.key});

  @override
  State<CollectorDashboard> createState() => _CollectorDashboardState();
}

class _CollectorDashboardState extends State<CollectorDashboard> {
  int _tab = 0;

  static const _navItems = [
    _NavItem(Icons.work_outline, Icons.work, 'Jobs'),
    _NavItem(Icons.route_outlined, Icons.route, 'Route'),
    _NavItem(Icons.bar_chart_outlined, Icons.bar_chart, 'Earnings'),
    _NavItem(Icons.person_outline, Icons.person, 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: IndexedStack(
        index: _tab,
        children: const [
          _JobsTab(),
          _RouteTab(),
          _EarningsTab(),
          _CollectorProfileTab(),
        ],
      ),
      bottomNavigationBar: _CollectorBottomNav(
        currentIndex: _tab,
        items: _navItems,
        onTap: (i) => setState(() => _tab = i),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Jobs Tab
// ─────────────────────────────────────────────
class _JobsTab extends StatefulWidget {
  const _JobsTab();

  @override
  State<_JobsTab> createState() => _JobsTabState();
}

class _JobsTabState extends State<_JobsTab> {
  int _filter = 0;
  final _filters = ['Pending (3)', 'Active (1)', 'Completed'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: Column(
          children: [
            // Top bar
            Container(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 34, height: 34,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.electric_rickshaw, color: Colors.white, size: 18),
                      ),
                      const SizedBox(width: 10),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Collector Dashboard',
                                style: TextStyle(
                                    fontFamily: 'Noto Sans',
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.onSurface)),
                            Text('Pickup jobs in your area',
                                style: TextStyle(
                                    fontFamily: 'Noto Sans',
                                    fontSize: 11,
                                    color: AppColors.onSurfaceVariant)),
                          ],
                        ),
                      ),
                      const ConnectivityIndicator(isOnline: true),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: AppColors.statusOnlineBg,
                          borderRadius: BorderRadius.circular(999),
                          border: Border.all(color: const Color(0xFFA7F3D0)),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.circle, size: 7, color: AppColors.statusOnline),
                            SizedBox(width: 5),
                            Text('On Duty',
                                style: TextStyle(
                                    fontFamily: 'Noto Sans',
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF065F46))),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  // Filter tabs
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceContainerHigh,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: List.generate(_filters.length, (i) {
                        final active = i == _filter;
                        return Expanded(
                          child: GestureDetector(
                            onTap: () => setState(() => _filter = i),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              decoration: BoxDecoration(
                                color: active ? AppColors.surfaceContainerLowest : Colors.transparent,
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: active
                                    ? const [BoxShadow(color: Color(0x0A000000), blurRadius: 4)]
                                    : [],
                              ),
                              alignment: Alignment.center,
                              child: Text(_filters[i],
                                  style: TextStyle(
                                      fontFamily: 'Noto Sans',
                                      fontSize: 12,
                                      fontWeight: active ? FontWeight.w700 : FontWeight.w500,
                                      color: active ? AppColors.primary : AppColors.onSurfaceVariant)),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
            // Content
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  if (_filter == 0) ...[
                    _JobCard(
                      sellerName: 'Sunita Sharma',
                      address: 'B-204, Mayur Vihar Phase 1',
                      category: 'E-Waste + Plastic',
                      weight: '~12 kg',
                      estimatedValue: '₹540',
                      distanceKm: '0.8',
                      onAccept: () {},
                      onDecline: () {},
                    ),
                    const SizedBox(height: 12),
                    _JobCard(
                      sellerName: 'Ramesh Gupta',
                      address: 'Flat 5A, Anand Vihar',
                      category: 'Newspaper + Cardboard',
                      weight: '~30 kg',
                      estimatedValue: '₹420',
                      distanceKm: '1.3',
                      onAccept: () {},
                      onDecline: () {},
                    ),
                    const SizedBox(height: 12),
                    _JobCard(
                      sellerName: 'Priya Mehra',
                      address: '12, Laxmi Nagar Market',
                      category: 'Iron Scrap + Metal',
                      weight: '~25 kg',
                      estimatedValue: '₹1,125',
                      distanceKm: '2.1',
                      onAccept: () {},
                      onDecline: () {},
                    ),
                  ] else if (_filter == 1) ...[
                    _ActiveJobCard(),
                  ] else ...[
                    _CompletedJobCard(name: 'Asha Devi', date: 'Today, 10:30 AM', amount: '₹780', kg: '18 kg'),
                    const SizedBox(height: 10),
                    _CompletedJobCard(name: 'Mahesh Kumar', date: 'Yesterday, 3:45 PM', amount: '₹420', kg: '12 kg'),
                    const SizedBox(height: 10),
                    _CompletedJobCard(name: 'Neha Singh', date: 'Yesterday, 11:00 AM', amount: '₹295', kg: '8 kg'),
                  ],
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _JobCard extends StatelessWidget {
  final String sellerName, address, category, weight, estimatedValue, distanceKm;
  final VoidCallback onAccept, onDecline;

  const _JobCard({
    required this.sellerName,
    required this.address,
    required this.category,
    required this.weight,
    required this.estimatedValue,
    required this.distanceKm,
    required this.onAccept,
    required this.onDecline,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.outlineVariant),
        boxShadow: const [BoxShadow(color: Color(0x08000000), blurRadius: 4, offset: Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.statusOfflineBg,
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(color: const Color(0xFFFDE68A)),
                ),
                child: const Text('⏳ New Request',
                    style: TextStyle(
                        fontFamily: 'Noto Sans',
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF92400E))),
              ),
              const Spacer(),
              const Icon(Icons.near_me, size: 13, color: AppColors.secondary),
              const SizedBox(width: 3),
              Text('$distanceKm km away',
                  style: const TextStyle(
                      fontFamily: 'Noto Sans',
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.onSurfaceVariant)),
            ],
          ),
          const SizedBox(height: 10),
          Text(sellerName,
              style: const TextStyle(
                  fontFamily: 'Noto Sans',
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.onSurface)),
          const SizedBox(height: 2),
          Row(
            children: [
              const Icon(Icons.location_on, size: 13, color: AppColors.onSurfaceVariant),
              const SizedBox(width: 4),
              Expanded(
                child: Text(address,
                    style: const TextStyle(
                        fontFamily: 'Noto Sans',
                        fontSize: 12,
                        color: AppColors.onSurfaceVariant)),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerLow,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(category,
                        style: const TextStyle(
                            fontFamily: 'Noto Sans',
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppColors.onSurface)),
                    Text(weight,
                        style: const TextStyle(
                            fontFamily: 'Noto Sans',
                            fontSize: 12,
                            color: AppColors.onSurfaceVariant)),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text('Est. Value',
                        style: TextStyle(
                            fontFamily: 'Noto Sans',
                            fontSize: 11,
                            color: AppColors.onSurfaceVariant)),
                    Text(estimatedValue,
                        style: const TextStyle(
                            fontFamily: 'Noto Sans',
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primary)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 44,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.error,
                      side: const BorderSide(color: AppColors.error),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    onPressed: onDecline,
                    child: const Text('Decline',
                        style: TextStyle(fontFamily: 'Noto Sans', fontSize: 13, fontWeight: FontWeight.w600)),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 2,
                child: SizedBox(
                  height: 44,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    onPressed: onAccept,
                    child: const Text('Accept Pickup',
                        style: TextStyle(fontFamily: 'Noto Sans', fontSize: 13, fontWeight: FontWeight.w700)),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ActiveJobCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.primary.withOpacity(0.4), width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.statusOnlineBg,
              borderRadius: BorderRadius.circular(999),
              border: Border.all(color: const Color(0xFFA7F3D0)),
            ),
            child: const Text('🟢 En Route',
                style: TextStyle(
                    fontFamily: 'Noto Sans',
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF065F46))),
          ),
          const SizedBox(height: 12),
          const Text('Sunita Sharma',
              style: TextStyle(
                  fontFamily: 'Noto Sans',
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.onSurface)),
          const Text('B-204, Mayur Vihar Phase 1',
              style: TextStyle(
                  fontFamily: 'Noto Sans', fontSize: 13, color: AppColors.onSurfaceVariant)),
          const SizedBox(height: 12),
          // Weighing slip area
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerLow,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.scale, size: 16, color: AppColors.secondary),
                    SizedBox(width: 6),
                    Text('Digital Weighing Slip',
                        style: TextStyle(
                            fontFamily: 'Noto Sans',
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppColors.onSurface)),
                  ],
                ),
                const SizedBox(height: 8),
                _WeighRow('E-Waste (PCB)', '3.2 kg', '₹154'),
                _WeighRow('Copper Wire', '1.8 kg', '₹99'),
                _WeighRow('Plastic Bottles', '6.5 kg', '₹130'),
                const Divider(height: 16, color: AppColors.outlineVariant),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Total',
                        style: TextStyle(
                            fontFamily: 'Noto Sans',
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: AppColors.onSurface)),
                    Text('11.5 kg  ·  ₹383',
                        style: const TextStyle(
                            fontFamily: 'Noto Sans',
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primary)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          const Text('Enter Pickup OTP',
              style: TextStyle(
                  fontFamily: 'Noto Sans',
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.onSurface)),
          const SizedBox(height: 8),
          Container(
            height: 52,
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerLow,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.primary, width: 2),
            ),
            child: const TextField(
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: '• • • • • •',
                border: InputBorder.none,
              ),
              style: TextStyle(
                  fontFamily: 'Noto Sans',
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 10),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: () {},
              child: const Text('Verify & Generate QR Receipt',
                  style: TextStyle(fontFamily: 'Noto Sans', fontSize: 14, fontWeight: FontWeight.w700)),
            ),
          ),
        ],
      ),
    );
  }
}

class _WeighRow extends StatelessWidget {
  final String material, weight, value;
  const _WeighRow(this.material, this.weight, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          Expanded(
            child: Text(material,
                style: const TextStyle(fontFamily: 'Noto Sans', fontSize: 12, color: AppColors.onSurfaceVariant)),
          ),
          Text(weight,
              style: const TextStyle(fontFamily: 'Noto Sans', fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.onSurface)),
          const SizedBox(width: 16),
          SizedBox(
            width: 50,
            child: Text(value,
                textAlign: TextAlign.end,
                style: const TextStyle(fontFamily: 'Noto Sans', fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.secondary)),
          ),
        ],
      ),
    );
  }
}

class _CompletedJobCard extends StatelessWidget {
  final String name, date, amount, kg;
  const _CompletedJobCard({required this.name, required this.date, required this.amount, required this.kg});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.outlineVariant),
      ),
      child: Row(
        children: [
          Container(
            width: 44, height: 44,
            decoration: const BoxDecoration(
              color: AppColors.statusOnlineBg,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.check_circle, color: AppColors.statusOnline, size: 24),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: const TextStyle(
                        fontFamily: 'Noto Sans',
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: AppColors.onSurface)),
                Text(date,
                    style: const TextStyle(
                        fontFamily: 'Noto Sans', fontSize: 12, color: AppColors.onSurfaceVariant)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(amount,
                  style: const TextStyle(
                      fontFamily: 'Noto Sans',
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary)),
              Text(kg,
                  style: const TextStyle(
                      fontFamily: 'Noto Sans', fontSize: 11, color: AppColors.onSurfaceVariant)),
            ],
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Route Tab
// ─────────────────────────────────────────────
class _RouteTab extends StatelessWidget {
  const _RouteTab();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Today\'s Route',
                  style: TextStyle(
                      fontFamily: 'Noto Sans',
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: AppColors.onSurface)),
              const SizedBox(height: 4),
              const Text('Optimized pickup cluster — Mayur Vihar area',
                  style: TextStyle(fontFamily: 'Noto Sans', fontSize: 12, color: AppColors.onSurfaceVariant)),
              const SizedBox(height: 16),
              // Summary stats
              Row(
                children: [
                  _RouteStat('4', 'Stops', Icons.place, AppColors.primary),
                  const SizedBox(width: 10),
                  _RouteStat('8.4 km', 'Total', Icons.route, AppColors.secondary),
                  const SizedBox(width: 10),
                  _RouteStat('~65 min', 'ETA', Icons.timer, AppColors.tertiary),
                ],
              ),
              const SizedBox(height: 20),
              const Text('Stops',
                  style: TextStyle(
                      fontFamily: 'Noto Sans',
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.onSurface)),
              const SizedBox(height: 10),
              _RouteStop(index: 1, name: 'Sunita Sharma', address: 'B-204, Mayur Vihar Phase 1', distance: '0.8 km', status: 'current'),
              _RouteStop(index: 2, name: 'Ramesh Gupta', address: 'Flat 5A, Anand Vihar', distance: '1.3 km', status: 'upcoming'),
              _RouteStop(index: 3, name: 'Priya Mehra', address: '12, Laxmi Nagar Market', distance: '2.1 km', status: 'upcoming'),
              _RouteStop(index: 4, name: 'Mahesh Kumar', address: 'RZ-12, Vishwas Nagar', distance: '3.2 km', status: 'upcoming'),
              const SizedBox(height: 20),
              // Aggregator drop-off
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.secondaryFixed,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 44, height: 44,
                      decoration: BoxDecoration(
                        color: AppColors.secondary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(Icons.factory, color: Colors.white, size: 24),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Drop-off Point',
                              style: TextStyle(fontFamily: 'Noto Sans', fontSize: 11, color: AppColors.onSecondaryFixed)),
                          Text('GreenCycle Aggregator Hub',
                              style: TextStyle(fontFamily: 'Noto Sans', fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.onSurface)),
                          Text('Patparganj Industrial Area — 5.8 km',
                              style: TextStyle(fontFamily: 'Noto Sans', fontSize: 12, color: AppColors.onSurfaceVariant)),
                        ],
                      ),
                    ),
                    const Icon(Icons.chevron_right, color: AppColors.secondary),
                  ],
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class _RouteStat extends StatelessWidget {
  final String value, label;
  final IconData icon;
  final Color color;
  const _RouteStat(this.value, this.label, this.icon, this.color);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.outlineVariant),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 22),
            const SizedBox(height: 4),
            Text(value,
                style: TextStyle(fontFamily: 'Noto Sans', fontSize: 16, fontWeight: FontWeight.w700, color: color)),
            Text(label,
                style: const TextStyle(fontFamily: 'Noto Sans', fontSize: 10, color: AppColors.onSurfaceVariant)),
          ],
        ),
      ),
    );
  }
}

class _RouteStop extends StatelessWidget {
  final int index;
  final String name, address, distance, status;
  const _RouteStop({required this.index, required this.name, required this.address, required this.distance, required this.status});

  @override
  Widget build(BuildContext context) {
    final isCurrent = status == 'current';
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isCurrent ? AppColors.primaryFixed.withOpacity(0.3) : AppColors.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isCurrent ? AppColors.primary : AppColors.outlineVariant,
            width: isCurrent ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 32, height: 32,
              decoration: BoxDecoration(
                color: isCurrent ? AppColors.primary : AppColors.surfaceContainerHigh,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text('$index',
                    style: TextStyle(
                        fontFamily: 'Noto Sans',
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: isCurrent ? Colors.white : AppColors.onSurfaceVariant)),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name,
                      style: const TextStyle(fontFamily: 'Noto Sans', fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.onSurface)),
                  Text(address,
                      style: const TextStyle(fontFamily: 'Noto Sans', fontSize: 11, color: AppColors.onSurfaceVariant)),
                ],
              ),
            ),
            Text(distance,
                style: const TextStyle(fontFamily: 'Noto Sans', fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.secondary)),
            if (isCurrent) ...[
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Text('NOW',
                    style: TextStyle(fontFamily: 'Noto Sans', fontSize: 9, fontWeight: FontWeight.w700, color: Colors.white)),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Earnings Tab
// ─────────────────────────────────────────────
class _EarningsTab extends StatelessWidget {
  const _EarningsTab();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Earnings Ledger',
                  style: TextStyle(
                      fontFamily: 'Noto Sans',
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: AppColors.onSurface)),
              const SizedBox(height: 4),
              const Text('Your pickup earnings & performance',
                  style: TextStyle(fontFamily: 'Noto Sans', fontSize: 12, color: AppColors.onSurfaceVariant)),
              const SizedBox(height: 16),
              // Today's summary card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.primary, AppColors.primaryContainer],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Today\'s Earnings',
                        style: TextStyle(fontFamily: 'Noto Sans', fontSize: 13, color: AppColors.primaryFixed)),
                    const SizedBox(height: 4),
                    const Text('₹1,495',
                        style: TextStyle(
                            fontFamily: 'Noto Sans',
                            fontSize: 36,
                            fontWeight: FontWeight.w700,
                            color: Colors.white)),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        _EarningPill('48.5 kg collected'),
                        const SizedBox(width: 8),
                        _EarningPill('4 pickups done'),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // Weekly stats
              Row(
                children: [
                  _StatBox('This Week', '₹8,240', AppColors.primary),
                  const SizedBox(width: 10),
                  _StatBox('This Month', '₹31,600', AppColors.secondary),
                  const SizedBox(width: 10),
                  _StatBox('Total', '₹1,84,500', AppColors.tertiary),
                ],
              ),
              const SizedBox(height: 20),
              // Performance
              const Text('Performance',
                  style: TextStyle(fontFamily: 'Noto Sans', fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.onSurface)),
              const SizedBox(height: 10),
              _PerfRow('Completion Rate', '94%', 0.94, AppColors.statusOnline),
              const SizedBox(height: 8),
              _PerfRow('Response Time', 'Avg 8 min', 0.80, AppColors.secondary),
              const SizedBox(height: 8),
              _PerfRow('Seller Rating', '4.7 / 5.0', 0.94, AppColors.primary),
              const SizedBox(height: 20),
              // Recent transactions
              const Text('Recent Transactions',
                  style: TextStyle(fontFamily: 'Noto Sans', fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.onSurface)),
              const SizedBox(height: 10),
              _TxRow('Sunita Sharma', 'E-Waste + Plastic · 11.5 kg', '₹383', 'Today'),
              _TxRow('Asha Devi', 'Newspaper · 18 kg', '₹270', 'Today'),
              _TxRow('Ramesh Gupta', 'Iron Scrap · 22 kg', '₹990', 'Today'),
              _TxRow('Priya Mehra', 'Mixed e-Waste · 8 kg', '₹296', 'Yesterday'),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class _EarningPill extends StatelessWidget {
  final String label;
  const _EarningPill(this.label);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(label,
          style: const TextStyle(fontFamily: 'Noto Sans', fontSize: 11, fontWeight: FontWeight.w600, color: Colors.white)),
    );
  }
}

class _StatBox extends StatelessWidget {
  final String label, value;
  final Color color;
  const _StatBox(this.label, this.value, this.color);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          color: AppColors.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.outlineVariant),
        ),
        child: Column(
          children: [
            Text(value,
                style: TextStyle(fontFamily: 'Noto Sans', fontSize: 14, fontWeight: FontWeight.w700, color: color)),
            const SizedBox(height: 2),
            Text(label,
                style: const TextStyle(fontFamily: 'Noto Sans', fontSize: 10, color: AppColors.onSurfaceVariant),
                textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}

class _PerfRow extends StatelessWidget {
  final String label, value;
  final double progress;
  final Color color;
  const _PerfRow(this.label, this.value, this.progress, this.color);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: const TextStyle(fontFamily: 'Noto Sans', fontSize: 13, color: AppColors.onSurface)),
            Text(value, style: TextStyle(fontFamily: 'Noto Sans', fontSize: 13, fontWeight: FontWeight.w700, color: color)),
          ],
        ),
        const SizedBox(height: 4),
        ClipRRect(
          borderRadius: BorderRadius.circular(999),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 6,
            backgroundColor: AppColors.surfaceContainerHigh,
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ),
      ],
    );
  }
}

class _TxRow extends StatelessWidget {
  final String name, detail, amount, date;
  const _TxRow(this.name, this.detail, this.amount, this.date);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.outlineVariant),
        ),
        child: Row(
          children: [
            Container(
              width: 38, height: 38,
              decoration: BoxDecoration(
                color: AppColors.primaryFixed,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.receipt_long, color: AppColors.primary, size: 20),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: const TextStyle(fontFamily: 'Noto Sans', fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.onSurface)),
                  Text(detail, style: const TextStyle(fontFamily: 'Noto Sans', fontSize: 11, color: AppColors.onSurfaceVariant)),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(amount, style: const TextStyle(fontFamily: 'Noto Sans', fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.primary)),
                Text(date, style: const TextStyle(fontFamily: 'Noto Sans', fontSize: 10, color: AppColors.onSurfaceVariant)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Profile Tab
// ─────────────────────────────────────────────
class _CollectorProfileTab extends StatelessWidget {
  const _CollectorProfileTab();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Profile',
                  style: TextStyle(fontFamily: 'Noto Sans', fontSize: 22, fontWeight: FontWeight.w700, color: AppColors.onSurface)),
              const SizedBox(height: 16),
              // Profile card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainerLowest,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.outlineVariant),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: AppColors.secondaryFixed,
                      child: const Text('RG',
                          style: TextStyle(fontFamily: 'Noto Sans', fontSize: 22, fontWeight: FontWeight.w700, color: AppColors.secondary)),
                    ),
                    const SizedBox(width: 14),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Rajiv Green Collector',
                              style: TextStyle(fontFamily: 'Noto Sans', fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.onSurface)),
                          Text('+91 98765 12345',
                              style: TextStyle(fontFamily: 'Noto Sans', fontSize: 13, color: AppColors.onSurfaceVariant)),
                          SizedBox(height: 4),
                          Text('Mayur Vihar, Delhi',
                              style: TextStyle(fontFamily: 'Noto Sans', fontSize: 12, color: AppColors.onSurfaceVariant)),
                        ],
                      ),
                    ),
                    IconButton(icon: const Icon(Icons.edit_outlined, color: AppColors.primary), onPressed: () {}),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              // Verification badge
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.statusOnlineBg,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFA7F3D0)),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.verified, color: AppColors.statusOnline, size: 24),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Collector Verified',
                              style: TextStyle(fontFamily: 'Noto Sans', fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xFF065F46))),
                          Text('KYC confirmed · Operating since Jan 2024',
                              style: TextStyle(fontFamily: 'Noto Sans', fontSize: 11, color: AppColors.onSurfaceVariant)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Text('Stats',
                  style: TextStyle(fontFamily: 'Noto Sans', fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.onSurface)),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(child: _ProfileStat('Pickups', '248', Icons.local_shipping, AppColors.primary)),
                  const SizedBox(width: 10),
                  Expanded(child: _ProfileStat('Total Earned', '₹1.8L', Icons.currency_rupee, AppColors.secondary)),
                  const SizedBox(width: 10),
                  Expanded(child: _ProfileStat('Rating', '4.8 ⭐', Icons.star, AppColors.tertiary)),
                ],
              ),
              const SizedBox(height: 20),
              const Text('Materials Collected',
                  style: TextStyle(fontFamily: 'Noto Sans', fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.onSurface)),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _MaterialChip('E-Waste', Icons.memory, AppColors.primary),
                  _MaterialChip('Plastic', Icons.local_drink, AppColors.secondary),
                  _MaterialChip('Paper', Icons.newspaper, AppColors.tertiary),
                  _MaterialChip('Metal', Icons.hardware, AppColors.onSurfaceVariant),
                ],
              ),
              const SizedBox(height: 20),
              ListTile(
                dense: true, contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.notifications_outlined, color: AppColors.primary, size: 22),
                title: const Text('Notifications', style: TextStyle(fontFamily: 'Noto Sans', fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.onSurface)),
                trailing: const Text('Enabled', style: TextStyle(fontFamily: 'Noto Sans', fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.primary)),
                onTap: () {},
              ),
              ListTile(
                dense: true, contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.help_outline, color: AppColors.primary, size: 22),
                title: const Text('Help & Support', style: TextStyle(fontFamily: 'Noto Sans', fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.onSurface)),
                trailing: const Icon(Icons.chevron_right, color: AppColors.onSurfaceVariant),
                onTap: () {},
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.error,
                    side: const BorderSide(color: AppColors.error),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  icon: const Icon(Icons.logout),
                  label: const Text('Sign Out', style: TextStyle(fontFamily: 'Noto Sans', fontSize: 14, fontWeight: FontWeight.w600)),
                  onPressed: () {},
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfileStat extends StatelessWidget {
  final String label, value;
  final IconData icon;
  final Color color;
  const _ProfileStat(this.label, this.value, this.icon, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.outlineVariant),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 22),
          const SizedBox(height: 4),
          Text(value, style: TextStyle(fontFamily: 'Noto Sans', fontSize: 14, fontWeight: FontWeight.w700, color: color)),
          Text(label, style: const TextStyle(fontFamily: 'Noto Sans', fontSize: 10, color: AppColors.onSurfaceVariant), textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

class _MaterialChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  const _MaterialChip(this.label, this.icon, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.outlineVariant),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 5),
          Text(label, style: const TextStyle(fontFamily: 'Noto Sans', fontSize: 12, color: AppColors.onSurface)),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Bottom Nav
// ─────────────────────────────────────────────
class _CollectorBottomNav extends StatelessWidget {
  final int currentIndex;
  final List<_NavItem> items;
  final ValueChanged<int> onTap;
  const _CollectorBottomNav({required this.currentIndex, required this.items, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64 + MediaQuery.of(context).padding.bottom,
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
      decoration: const BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        border: Border(top: BorderSide(color: AppColors.outlineVariant, width: 1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(items.length, (i) {
          final active = i == currentIndex;
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => onTap(i),
            child: SizedBox(
              width: 72,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    child: Icon(
                      active ? items[i].activeIcon : items[i].icon,
                      key: ValueKey(active),
                      color: active ? AppColors.primary : AppColors.onSurfaceVariant,
                      size: 26,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(items[i].label,
                      style: TextStyle(
                          fontFamily: 'Noto Sans',
                          fontSize: 10,
                          fontWeight: active ? FontWeight.w700 : FontWeight.w400,
                          color: active ? AppColors.primary : AppColors.onSurfaceVariant)),
                  const SizedBox(height: 3),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: active ? 6 : 0,
                    height: active ? 6 : 0,
                    decoration: const BoxDecoration(
                      color: AppColors.secondary,
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _NavItem {
  final IconData icon, activeIcon;
  final String label;
  const _NavItem(this.icon, this.activeIcon, this.label);
}
