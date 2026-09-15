import 'package:flutter/material.dart';
import '../app_colors.dart';
import '../components/indicators_and_badges.dart';

class MatchScreen extends StatefulWidget {
  const MatchScreen({super.key});

  @override
  State<MatchScreen> createState() => _MatchScreenState();
}

class _MatchScreenState extends State<MatchScreen> {
  int _tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      Icon(Icons.handshake, color: AppColors.primary, size: 22),
                      SizedBox(width: 8),
                      Text('Match & Coordination',
                          style: TextStyle(
                              fontFamily: 'Noto Sans',
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: AppColors.onSurface)),
                    ],
                  ),
                  const Text('पिकअप मिलान और समन्वय',
                      style: TextStyle(
                          fontFamily: 'Noto Sans',
                          fontSize: 11,
                          color: AppColors.onSurfaceVariant)),
                  const SizedBox(height: 12),
                  // Tab toggle
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceContainerHigh,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        _Tab('Pending (3)', 0, _tabIndex, () => setState(() => _tabIndex = 0)),
                        _Tab('Active (1)', 1, _tabIndex, () => setState(() => _tabIndex = 1)),
                        _Tab('Completed', 2, _tabIndex, () => setState(() => _tabIndex = 2)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  if (_tabIndex == 0) ...[
                    _PickupRequestCard(
                      sellerName: 'Sunita Sharma',
                      address: 'B-204, Mayur Vihar Phase 1',
                      category: 'E-Waste + Plastic',
                      weight: '~12 kg',
                      estimatedValue: '₹540',
                      distanceKm: '0.8',
                      status: 'Pending',
                      onAccept: () {},
                      onDecline: () {},
                    ),
                    const SizedBox(height: 12),
                    _PickupRequestCard(
                      sellerName: 'Ramesh Gupta',
                      address: 'Flat 5A, Anand Vihar',
                      category: 'Newspaper + Cardboard',
                      weight: '~30 kg',
                      estimatedValue: '₹420',
                      distanceKm: '1.3',
                      status: 'Pending',
                      onAccept: () {},
                      onDecline: () {},
                    ),
                    const SizedBox(height: 12),
                    _PickupRequestCard(
                      sellerName: 'Priya Mehra',
                      address: '12, Laxmi Nagar Market',
                      category: 'Iron Scrap + Metal',
                      weight: '~25 kg',
                      estimatedValue: '₹1,125',
                      distanceKm: '2.1',
                      status: 'Pending',
                      onAccept: () {},
                      onDecline: () {},
                    ),
                  ] else if (_tabIndex == 1) ...[
                    _ActivePickupCard(),
                  ] else ...[
                    _CompletedPickupCard(
                        name: 'Asha Devi', date: 'Today, 10:30 AM', amount: '₹780'),
                    const SizedBox(height: 10),
                    _CompletedPickupCard(
                        name: 'Mahesh Kumar', date: 'Yesterday, 3:45 PM', amount: '₹420'),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Tab extends StatelessWidget {
  final String label;
  final int index;
  final int current;
  final VoidCallback onTap;
  const _Tab(this.label, this.index, this.current, this.onTap);

  @override
  Widget build(BuildContext context) {
    final active = index == current;
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
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
          child: Text(label,
              style: TextStyle(
                  fontFamily: 'Noto Sans',
                  fontSize: 12,
                  fontWeight: active ? FontWeight.w700 : FontWeight.w500,
                  color: active ? AppColors.primary : AppColors.onSurfaceVariant)),
        ),
      ),
    );
  }
}

class _PickupRequestCard extends StatelessWidget {
  final String sellerName, address, category, weight, estimatedValue, distanceKm, status;
  final VoidCallback onAccept, onDecline;

  const _PickupRequestCard({
    required this.sellerName,
    required this.address,
    required this.category,
    required this.weight,
    required this.estimatedValue,
    required this.distanceKm,
    required this.status,
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
                  color: const Color(0xFFFFFBEB),
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(color: const Color(0xFFFDE68A)),
                ),
                child: const Text('⏳ Awaiting Response',
                    style: TextStyle(
                        fontFamily: 'Noto Sans',
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF92400E))),
              ),
              const Spacer(),
              Icon(Icons.near_me, size: 13, color: AppColors.secondary),
              const SizedBox(width: 3),
              Text('$distanceKm km',
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
                    child: const Text('Decline / नकारें',
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
                    child: const Text('Accept Pickup / स्वीकार करें',
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

class _ActivePickupCard extends StatelessWidget {
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
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.statusOnlineBg,
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(color: const Color(0xFFA7F3D0)),
                ),
                child: const Text('🟢 En Route • रास्ते में',
                    style: TextStyle(
                        fontFamily: 'Noto Sans',
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF065F46))),
              ),
            ],
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
          const Text('Enter Pickup OTP / OTP दर्ज करें',
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
              child: const Text('Verify & Proceed to Weighing',
                  style: TextStyle(fontFamily: 'Noto Sans', fontSize: 14, fontWeight: FontWeight.w700)),
            ),
          ),
        ],
      ),
    );
  }
}

class _CompletedPickupCard extends StatelessWidget {
  final String name, date, amount;
  const _CompletedPickupCard({required this.name, required this.date, required this.amount});

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
            width: 44,
            height: 44,
            decoration: BoxDecoration(
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
          Text(amount,
              style: const TextStyle(
                  fontFamily: 'Noto Sans',
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary)),
        ],
      ),
    );
  }
}
