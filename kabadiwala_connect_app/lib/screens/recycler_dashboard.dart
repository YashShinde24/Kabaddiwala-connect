import 'package:flutter/material.dart';
import '../app_colors.dart';
import '../components/indicators_and_badges.dart';

class RecyclerDashboard extends StatefulWidget {
  const RecyclerDashboard({super.key});

  @override
  State<RecyclerDashboard> createState() => _RecyclerDashboardState();
}

class _RecyclerDashboardState extends State<RecyclerDashboard> {
  int _tab = 0;

  static const _navItems = [
    _NavItem(Icons.inventory_2_outlined, Icons.inventory_2, 'Inventory'),
    _NavItem(Icons.storefront_outlined, Icons.storefront, 'Marketplace'),
    _NavItem(Icons.verified_outlined, Icons.verified, 'Compliance'),
    _NavItem(Icons.person_outline, Icons.person, 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: IndexedStack(
        index: _tab,
        children: const [
          _InventoryTab(),
          _MarketplaceTab(),
          _ComplianceTab(),
          _RecyclerProfileTab(),
        ],
      ),
      bottomNavigationBar: _RecyclerBottomNav(
        currentIndex: _tab,
        items: _navItems,
        onTap: (i) => setState(() => _tab = i),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Inventory Tab
// ─────────────────────────────────────────────
class _InventoryTab extends StatefulWidget {
  const _InventoryTab();

  @override
  State<_InventoryTab> createState() => _InventoryTabState();
}

class _InventoryTabState extends State<_InventoryTab> {
  int _filter = 0;
  final _filters = ['Incoming (4)', 'Confirmed', 'Processing'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: Column(
          children: [
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
                          color: AppColors.tertiary,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.factory, color: Colors.white, size: 18),
                      ),
                      const SizedBox(width: 10),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Recycler Dashboard',
                                style: TextStyle(fontFamily: 'Noto Sans', fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.onSurface)),
                            Text('GreenCycle Facility, Patparganj',
                                style: TextStyle(fontFamily: 'Noto Sans', fontSize: 11, color: AppColors.onSurfaceVariant)),
                          ],
                        ),
                      ),
                      const ConnectivityIndicator(isOnline: true),
                    ],
                  ),
                  const SizedBox(height: 14),
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
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  if (_filter == 0) ...[
                    _LotCard(
                      collectorName: 'Rajiv Green Collector',
                      lotId: 'LOT-2024-0341',
                      category: 'E-Waste (PCB + Cables)',
                      weight: '28.5 kg',
                      quotedPrice: '₹13,680',
                      eta: 'Arriving in ~20 min',
                      status: 'incoming',
                    ),
                    const SizedBox(height: 12),
                    _LotCard(
                      collectorName: 'Mahesh Kabadiwala',
                      lotId: 'LOT-2024-0342',
                      category: 'Mixed Plastic (HDPE + PET)',
                      weight: '65 kg',
                      quotedPrice: '₹1,300',
                      eta: 'Arriving in ~45 min',
                      status: 'incoming',
                    ),
                    const SizedBox(height: 12),
                    _LotCard(
                      collectorName: 'Suresh Waste Services',
                      lotId: 'LOT-2024-0343',
                      category: 'Copper Wire + Aluminium',
                      weight: '12 kg',
                      quotedPrice: '₹9,240',
                      eta: 'Arriving in ~1 hr',
                      status: 'incoming',
                    ),
                  ] else if (_filter == 1) ...[
                    _LotCard(
                      collectorName: 'Ramesh Collector',
                      lotId: 'LOT-2024-0338',
                      category: 'CRT Monitors + LCD',
                      weight: '42 kg',
                      quotedPrice: '₹3,360',
                      eta: 'Confirmed at 10:15 AM',
                      status: 'confirmed',
                    ),
                  ] else ...[
                    _ProcessingCard(
                      lotId: 'LOT-2024-0330',
                      category: 'Shredder · E-Waste Board',
                      weight: '120 kg',
                      started: 'Started 2 hours ago',
                    ),
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

class _LotCard extends StatelessWidget {
  final String collectorName, lotId, category, weight, quotedPrice, eta, status;
  const _LotCard({
    required this.collectorName,
    required this.lotId,
    required this.category,
    required this.weight,
    required this.quotedPrice,
    required this.eta,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final isIncoming = status == 'incoming';
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isIncoming ? AppColors.tertiary.withOpacity(0.4) : AppColors.outlineVariant,
          width: isIncoming ? 2 : 1,
        ),
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
                  color: isIncoming ? AppColors.tertiaryFixed : AppColors.statusOnlineBg,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(isIncoming ? '🚛 Incoming' : '✅ Confirmed',
                    style: TextStyle(
                        fontFamily: 'Noto Sans',
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: isIncoming ? AppColors.tertiary : AppColors.statusOnline)),
              ),
              const Spacer(),
              Text(lotId,
                  style: const TextStyle(fontFamily: 'Noto Sans', fontSize: 11, color: AppColors.onSurfaceVariant)),
            ],
          ),
          const SizedBox(height: 10),
          Text(collectorName,
              style: const TextStyle(fontFamily: 'Noto Sans', fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.onSurface)),
          const SizedBox(height: 2),
          Row(
            children: [
              const Icon(Icons.access_time, size: 12, color: AppColors.onSurfaceVariant),
              const SizedBox(width: 4),
              Text(eta, style: const TextStyle(fontFamily: 'Noto Sans', fontSize: 12, color: AppColors.onSurfaceVariant)),
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
                        style: const TextStyle(fontFamily: 'Noto Sans', fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.onSurface)),
                    Text(weight, style: const TextStyle(fontFamily: 'Noto Sans', fontSize: 12, color: AppColors.onSurfaceVariant)),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text('Quoted', style: TextStyle(fontFamily: 'Noto Sans', fontSize: 11, color: AppColors.onSurfaceVariant)),
                    Text(quotedPrice,
                        style: const TextStyle(fontFamily: 'Noto Sans', fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.tertiary)),
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
                  height: 42,
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppColors.outlineVariant),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    icon: const Icon(Icons.qr_code_scanner, size: 16, color: AppColors.primary),
                    label: const Text('Scan QR', style: TextStyle(fontFamily: 'Noto Sans', fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.primary)),
                    onPressed: () {},
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 2,
                child: SizedBox(
                  height: 42,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.tertiary,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    onPressed: () {},
                    child: const Text('Confirm Intake', style: TextStyle(fontFamily: 'Noto Sans', fontSize: 13, fontWeight: FontWeight.w700)),
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

class _ProcessingCard extends StatelessWidget {
  final String lotId, category, weight, started;
  const _ProcessingCard({required this.lotId, required this.category, required this.weight, required this.started});

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
            width: 48, height: 48,
            decoration: BoxDecoration(
              color: AppColors.tertiaryFixed,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.precision_manufacturing, color: AppColors.tertiary, size: 26),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(lotId, style: const TextStyle(fontFamily: 'Noto Sans', fontSize: 12, color: AppColors.onSurfaceVariant)),
                Text(category, style: const TextStyle(fontFamily: 'Noto Sans', fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.onSurface)),
                Text('$weight · $started', style: const TextStyle(fontFamily: 'Noto Sans', fontSize: 12, color: AppColors.onSurfaceVariant)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.tertiaryFixed,
              borderRadius: BorderRadius.circular(999),
            ),
            child: const Text('In Process', style: TextStyle(fontFamily: 'Noto Sans', fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.tertiary)),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Marketplace Tab
// ─────────────────────────────────────────────
class _MarketplaceTab extends StatefulWidget {
  const _MarketplaceTab();

  @override
  State<_MarketplaceTab> createState() => _MarketplaceTabState();
}

class _MarketplaceTabState extends State<_MarketplaceTab> {
  int _categoryFilter = 0;
  final _categories = ['All', 'E-Waste', 'Plastic', 'Metal', 'Paper'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.storefront, color: AppColors.tertiary, size: 22),
                      SizedBox(width: 8),
                      Text('Scrap Marketplace',
                          style: TextStyle(fontFamily: 'Noto Sans', fontSize: 20, fontWeight: FontWeight.w700, color: AppColors.onSurface)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  const Text('Browse available collector lots near you',
                      style: TextStyle(fontFamily: 'Noto Sans', fontSize: 12, color: AppColors.onSurfaceVariant)),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 34,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: _categories.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 8),
                      itemBuilder: (context, i) => GestureDetector(
                        onTap: () => setState(() => _categoryFilter = i),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                          decoration: BoxDecoration(
                            color: _categoryFilter == i ? AppColors.tertiary : AppColors.surfaceContainerLow,
                            borderRadius: BorderRadius.circular(999),
                            border: Border.all(color: _categoryFilter == i ? AppColors.tertiary : AppColors.outlineVariant),
                          ),
                          child: Text(_categories[i],
                              style: TextStyle(
                                  fontFamily: 'Noto Sans',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: _categoryFilter == i ? Colors.white : AppColors.onSurfaceVariant)),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  _MarketListing(
                    collectorName: 'Rajiv Green Collector',
                    badge: 'Verified',
                    category: 'E-Waste — PCB + Cables',
                    weight: '45 kg',
                    askingPrice: '₹21,600',
                    location: 'Mayur Vihar · 3.2 km',
                    tags: ['Grade A PCB', 'Copper Wire'],
                  ),
                  const SizedBox(height: 12),
                  _MarketListing(
                    collectorName: 'Suresh Waste Services',
                    badge: 'Verified',
                    category: 'Mixed Plastic (HDPE + PET)',
                    weight: '120 kg',
                    askingPrice: '₹2,400',
                    location: 'Anand Vihar · 5.1 km',
                    tags: ['Sorted', 'Clean'],
                  ),
                  const SizedBox(height: 12),
                  _MarketListing(
                    collectorName: 'Delhi Scrap Hub',
                    badge: 'Verified',
                    category: 'Copper + Aluminium',
                    weight: '32 kg',
                    askingPrice: '₹22,400',
                    location: 'Laxmi Nagar · 6.8 km',
                    tags: ['High Purity', 'Segregated'],
                  ),
                  const SizedBox(height: 12),
                  _MarketListing(
                    collectorName: 'Mahesh Kabadiwala',
                    badge: 'Verified',
                    category: 'Newspaper + Cardboard',
                    weight: '200 kg',
                    askingPrice: '₹3,000',
                    location: 'Vishwas Nagar · 4.5 km',
                    tags: ['Dry', 'Compressed'],
                  ),
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

class _MarketListing extends StatelessWidget {
  final String collectorName, badge, category, weight, askingPrice, location;
  final List<String> tags;
  const _MarketListing({
    required this.collectorName,
    required this.badge,
    required this.category,
    required this.weight,
    required this.askingPrice,
    required this.location,
    required this.tags,
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
              CircleAvatar(
                radius: 18,
                backgroundColor: AppColors.primaryFixed,
                child: Text(collectorName[0],
                    style: const TextStyle(fontFamily: 'Noto Sans', fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.primary)),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(collectorName,
                        style: const TextStyle(fontFamily: 'Noto Sans', fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.onSurface)),
                    Row(
                      children: [
                        const Icon(Icons.verified, size: 12, color: AppColors.statusOnline),
                        const SizedBox(width: 3),
                        Text(badge, style: const TextStyle(fontFamily: 'Noto Sans', fontSize: 11, color: AppColors.statusOnline)),
                        const SizedBox(width: 8),
                        const Icon(Icons.location_on, size: 12, color: AppColors.onSurfaceVariant),
                        const SizedBox(width: 2),
                        Text(location, style: const TextStyle(fontFamily: 'Noto Sans', fontSize: 11, color: AppColors.onSurfaceVariant)),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text('Asking', style: TextStyle(fontFamily: 'Noto Sans', fontSize: 10, color: AppColors.onSurfaceVariant)),
                  Text(askingPrice, style: const TextStyle(fontFamily: 'Noto Sans', fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.tertiary)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerLow,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(category, style: const TextStyle(fontFamily: 'Noto Sans', fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.onSurface)),
                Text(weight, style: const TextStyle(fontFamily: 'Noto Sans', fontSize: 13, color: AppColors.onSurfaceVariant)),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 6,
            children: tags.map((t) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: AppColors.tertiaryFixed,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(t, style: const TextStyle(fontFamily: 'Noto Sans', fontSize: 11, color: AppColors.tertiary, fontWeight: FontWeight.w600)),
            )).toList(),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 40,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppColors.outlineVariant),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    onPressed: () {},
                    child: const Text('Contact', style: TextStyle(fontFamily: 'Noto Sans', fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.onSurface)),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                flex: 2,
                child: SizedBox(
                  height: 40,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.tertiary,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    onPressed: () {},
                    child: const Text('Make Offer', style: TextStyle(fontFamily: 'Noto Sans', fontSize: 12, fontWeight: FontWeight.w700)),
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

// ─────────────────────────────────────────────
// Compliance Tab
// ─────────────────────────────────────────────
class _ComplianceTab extends StatelessWidget {
  const _ComplianceTab();

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
              const Row(
                children: [
                  Icon(Icons.verified_user, color: AppColors.tertiary, size: 22),
                  SizedBox(width: 8),
                  Text('Compliance & Traceability',
                      style: TextStyle(fontFamily: 'Noto Sans', fontSize: 20, fontWeight: FontWeight.w700, color: AppColors.onSurface)),
                ],
              ),
              const SizedBox(height: 4),
              const Text('EPR registration, chain-of-custody records',
                  style: TextStyle(fontFamily: 'Noto Sans', fontSize: 12, color: AppColors.onSurfaceVariant)),
              const SizedBox(height: 16),
              // EPR Badge
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.tertiary, AppColors.tertiaryContainer],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(Icons.verified, color: Colors.white, size: 28),
                        ),
                        const SizedBox(width: 12),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Authorized Recycler',
                                style: TextStyle(fontFamily: 'Noto Sans', fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white)),
                            Text('RECYCLER_VERIFIED Status',
                                style: TextStyle(fontFamily: 'Noto Sans', fontSize: 12, color: Color(0xFFCCE5FF))),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    _CertRow('EPR Registration No.', 'CPCB/EPR/DL/2024/GC-00341'),
                    const SizedBox(height: 6),
                    _CertRow('Valid Until', '31 March 2026'),
                    const SizedBox(height: 6),
                    _CertRow('Facility Type', 'E-Waste Dismantler & Recycler'),
                    const SizedBox(height: 6),
                    _CertRow('Materials Authorized', 'Cat. 1, 2, 3, 6 (E-Waste Rules 2022)'),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Chain of custody stats
              const Text('Chain-of-Custody Summary',
                  style: TextStyle(fontFamily: 'Noto Sans', fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.onSurface)),
              const SizedBox(height: 10),
              Row(
                children: [
                  _ComplianceStat('147', 'Lots Received', AppColors.tertiary),
                  const SizedBox(width: 10),
                  _ComplianceStat('4.2 T', 'E-Waste Processed', AppColors.primary),
                  const SizedBox(width: 10),
                  _ComplianceStat('100%', 'Traceability', AppColors.statusOnline),
                ],
              ),
              const SizedBox(height: 20),
              // Recent custody records
              const Text('Recent Custody Records',
                  style: TextStyle(fontFamily: 'Noto Sans', fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.onSurface)),
              const SizedBox(height: 10),
              _CustodyRecord(
                lotId: 'LOT-2024-0338',
                collector: 'Ramesh Collector',
                material: 'CRT + LCD Monitors · 42 kg',
                date: 'Today, 10:15 AM',
                hasQr: true,
              ),
              const SizedBox(height: 8),
              _CustodyRecord(
                lotId: 'LOT-2024-0331',
                collector: 'Suresh Waste Services',
                material: 'Mixed Plastic · 85 kg',
                date: 'Yesterday, 4:30 PM',
                hasQr: true,
              ),
              const SizedBox(height: 8),
              _CustodyRecord(
                lotId: 'LOT-2024-0325',
                collector: 'Rajiv Green Collector',
                material: 'PCB + Copper Wire · 28 kg',
                date: '13 Sep, 2:00 PM',
                hasQr: true,
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.tertiary,
                    side: const BorderSide(color: AppColors.tertiary),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  icon: const Icon(Icons.download_outlined),
                  label: const Text('Export EPR Compliance Report', style: TextStyle(fontFamily: 'Noto Sans', fontSize: 14, fontWeight: FontWeight.w600)),
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

class _CertRow extends StatelessWidget {
  final String label, value;
  const _CertRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$label: ', style: const TextStyle(fontFamily: 'Noto Sans', fontSize: 12, color: Color(0xFFCCE5FF))),
        Expanded(child: Text(value, style: const TextStyle(fontFamily: 'Noto Sans', fontSize: 12, fontWeight: FontWeight.w700, color: Colors.white))),
      ],
    );
  }
}

class _ComplianceStat extends StatelessWidget {
  final String value, label;
  final Color color;
  const _ComplianceStat(this.value, this.label, this.color);

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
            Text(value, style: TextStyle(fontFamily: 'Noto Sans', fontSize: 18, fontWeight: FontWeight.w700, color: color)),
            const SizedBox(height: 2),
            Text(label, style: const TextStyle(fontFamily: 'Noto Sans', fontSize: 10, color: AppColors.onSurfaceVariant), textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}

class _CustodyRecord extends StatelessWidget {
  final String lotId, collector, material, date;
  final bool hasQr;
  const _CustodyRecord({required this.lotId, required this.collector, required this.material, required this.date, required this.hasQr});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.outlineVariant),
      ),
      child: Row(
        children: [
          Container(
            width: 40, height: 40,
            decoration: BoxDecoration(
              color: AppColors.tertiaryFixed,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.qr_code, color: AppColors.tertiary, size: 22),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(lotId, style: const TextStyle(fontFamily: 'Noto Sans', fontSize: 11, color: AppColors.onSurfaceVariant)),
                    const SizedBox(width: 8),
                    const Icon(Icons.check_circle, size: 13, color: AppColors.statusOnline),
                    const Text(' Verified', style: TextStyle(fontFamily: 'Noto Sans', fontSize: 11, color: AppColors.statusOnline)),
                  ],
                ),
                Text(collector, style: const TextStyle(fontFamily: 'Noto Sans', fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.onSurface)),
                Text(material, style: const TextStyle(fontFamily: 'Noto Sans', fontSize: 11, color: AppColors.onSurfaceVariant)),
              ],
            ),
          ),
          Text(date, style: const TextStyle(fontFamily: 'Noto Sans', fontSize: 10, color: AppColors.onSurfaceVariant)),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Recycler Profile Tab
// ─────────────────────────────────────────────
class _RecyclerProfileTab extends StatelessWidget {
  const _RecyclerProfileTab();

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
              const Text('Profile', style: TextStyle(fontFamily: 'Noto Sans', fontSize: 22, fontWeight: FontWeight.w700, color: AppColors.onSurface)),
              const SizedBox(height: 16),
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
                      backgroundColor: AppColors.tertiaryFixed,
                      child: const Text('GC', style: TextStyle(fontFamily: 'Noto Sans', fontSize: 22, fontWeight: FontWeight.w700, color: AppColors.tertiary)),
                    ),
                    const SizedBox(width: 14),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('GreenCycle Pvt. Ltd.', style: TextStyle(fontFamily: 'Noto Sans', fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.onSurface)),
                          Text('Patparganj Industrial Area, Delhi', style: TextStyle(fontFamily: 'Noto Sans', fontSize: 12, color: AppColors.onSurfaceVariant)),
                          SizedBox(height: 4),
                          Text('+91 11-2639 5500', style: TextStyle(fontFamily: 'Noto Sans', fontSize: 12, color: AppColors.onSurfaceVariant)),
                        ],
                      ),
                    ),
                    IconButton(icon: const Icon(Icons.edit_outlined, color: AppColors.tertiary), onPressed: () {}),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.tertiaryFixed,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.tertiaryContainer),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.verified, color: AppColors.tertiary, size: 24),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Authorized Recycler', style: TextStyle(fontFamily: 'Noto Sans', fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.tertiary)),
                          Text('CPCB EPR Registered · E-Waste Rules 2022', style: TextStyle(fontFamily: 'Noto Sans', fontSize: 11, color: AppColors.onSurfaceVariant)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Text('Facility Stats', style: TextStyle(fontFamily: 'Noto Sans', fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.onSurface)),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(child: _ProfileStat2('Lots Received', '147', Icons.inventory_2, AppColors.tertiary)),
                  const SizedBox(width: 10),
                  Expanded(child: _ProfileStat2('E-Waste Processed', '4.2 T', Icons.precision_manufacturing, AppColors.primary)),
                  const SizedBox(width: 10),
                  Expanded(child: _ProfileStat2('Partners', '28', Icons.handshake, AppColors.secondary)),
                ],
              ),
              const SizedBox(height: 20),
              const Text('Accepted Materials', style: TextStyle(fontFamily: 'Noto Sans', fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.onSurface)),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8, runSpacing: 8,
                children: [
                  _MatTag('PCB / Motherboards', Icons.memory),
                  _MatTag('CRT / LCD Monitors', Icons.monitor),
                  _MatTag('Copper Wire', Icons.cable),
                  _MatTag('Hard Plastic', Icons.format_shapes),
                  _MatTag('Batteries', Icons.battery_full),
                ],
              ),
              const SizedBox(height: 20),
              ListTile(dense: true, contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.notifications_outlined, color: AppColors.tertiary, size: 22),
                title: const Text('Notifications', style: TextStyle(fontFamily: 'Noto Sans', fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.onSurface)),
                trailing: const Text('Enabled', style: TextStyle(fontFamily: 'Noto Sans', fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.tertiary)),
                onTap: () {},
              ),
              ListTile(dense: true, contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.help_outline, color: AppColors.tertiary, size: 22),
                title: const Text('Help & Support', style: TextStyle(fontFamily: 'Noto Sans', fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.onSurface)),
                trailing: const Icon(Icons.chevron_right, color: AppColors.onSurfaceVariant),
                onTap: () {},
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity, height: 48,
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

class _ProfileStat2 extends StatelessWidget {
  final String label, value;
  final IconData icon;
  final Color color;
  const _ProfileStat2(this.label, this.value, this.icon, this.color);

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

class _MatTag extends StatelessWidget {
  final String label;
  final IconData icon;
  const _MatTag(this.label, this.icon);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.tertiaryFixed,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: AppColors.tertiary),
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
class _RecyclerBottomNav extends StatelessWidget {
  final int currentIndex;
  final List<_NavItem> items;
  final ValueChanged<int> onTap;
  const _RecyclerBottomNav({required this.currentIndex, required this.items, required this.onTap});

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
                      color: active ? AppColors.tertiary : AppColors.onSurfaceVariant,
                      size: 26,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(items[i].label,
                      style: TextStyle(
                          fontFamily: 'Noto Sans',
                          fontSize: 10,
                          fontWeight: active ? FontWeight.w700 : FontWeight.w400,
                          color: active ? AppColors.tertiary : AppColors.onSurfaceVariant)),
                  const SizedBox(height: 3),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: active ? 6 : 0, height: active ? 6 : 0,
                    decoration: const BoxDecoration(color: AppColors.secondary, shape: BoxShape.circle),
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
