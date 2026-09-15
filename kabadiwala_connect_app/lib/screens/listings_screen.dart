import 'package:flutter/material.dart';
import '../app_colors.dart';
import '../components/indicators_and_badges.dart';

class SellerPickupScreen extends StatefulWidget {
  const SellerPickupScreen({super.key});

  @override
  State<SellerPickupScreen> createState() => _SellerPickupScreenState();
}

class _SellerPickupScreenState extends State<SellerPickupScreen> {
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
                      Icon(Icons.local_shipping, color: AppColors.primary, size: 22),
                      SizedBox(width: 8),
                      Text('My Pickups',
                          style: TextStyle(
                              fontFamily: 'Noto Sans',
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: AppColors.onSurface)),
                    ],
                  ),
                  const Text('Track your scrap pickup requests',
                      style: TextStyle(
                          fontFamily: 'Noto Sans',
                          fontSize: 12,
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
                        _Tab('Pending (1)', 0, _tabIndex, () => setState(() => _tabIndex = 0)),
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
                    _SellerPendingCard(
                      collectorName: 'Rajiv Green Collector',
                      category: 'E-Waste + Plastic',
                      weight: '~12 kg',
                      estimatedValue: '₹540',
                      eta: '25 min',
                      onCancel: () {},
                    ),
                  ] else if (_tabIndex == 1) ...[
                    _SellerActiveCard(),
                  ] else ...[
                    _SellerCompletedCard(
                      collectorName: 'Mahesh Kabadiwala',
                      category: 'Newspaper + Metal',
                      date: 'Today, 10:30 AM',
                      paidAmount: '₹780',
                      kg: '20 kg',
                    ),
                    const SizedBox(height: 10),
                    _SellerCompletedCard(
                      collectorName: 'Rajiv Green Collector',
                      category: 'E-Waste',
                      date: 'Yesterday, 3:45 PM',
                      paidAmount: '₹420',
                      kg: '8 kg',
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

class _SellerPendingCard extends StatelessWidget {
  final String collectorName, category, weight, estimatedValue, eta;
  final VoidCallback onCancel;

  const _SellerPendingCard({
    required this.collectorName,
    required this.category,
    required this.weight,
    required this.estimatedValue,
    required this.eta,
    required this.onCancel,
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
                child: const Text('⏳ Awaiting Collector',
                    style: TextStyle(
                        fontFamily: 'Noto Sans',
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF92400E))),
              ),
              const Spacer(),
              const Icon(Icons.timer, size: 13, color: AppColors.secondary),
              const SizedBox(width: 3),
              Text('ETA: $eta',
                  style: const TextStyle(
                      fontFamily: 'Noto Sans',
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.onSurfaceVariant)),
            ],
          ),
          const SizedBox(height: 10),
          Text(collectorName,
              style: const TextStyle(
                  fontFamily: 'Noto Sans', fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.onSurface)),
          const SizedBox(height: 8),
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
                    Text(weight,
                        style: const TextStyle(fontFamily: 'Noto Sans', fontSize: 12, color: AppColors.onSurfaceVariant)),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text('Est. Value',
                        style: TextStyle(fontFamily: 'Noto Sans', fontSize: 11, color: AppColors.onSurfaceVariant)),
                    Text(estimatedValue,
                        style: const TextStyle(fontFamily: 'Noto Sans', fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.primary)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            height: 40,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.error,
                side: const BorderSide(color: AppColors.error),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: onCancel,
              child: const Text('Cancel Request', style: TextStyle(fontFamily: 'Noto Sans', fontSize: 13, fontWeight: FontWeight.w600)),
            ),
          ),
        ],
      ),
    );
  }
}

class _SellerActiveCard extends StatelessWidget {
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
            child: const Text('🟢 Collector En Route',
                style: TextStyle(
                    fontFamily: 'Noto Sans',
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF065F46))),
          ),
          const SizedBox(height: 12),
          const Text('Rajiv Green Collector',
              style: TextStyle(fontFamily: 'Noto Sans', fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.onSurface)),
          const Text('Arriving in ~25 minutes',
              style: TextStyle(fontFamily: 'Noto Sans', fontSize: 13, color: AppColors.onSurfaceVariant)),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.primaryFixed.withOpacity(0.3),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Row(
              children: [
                Icon(Icons.qr_code, color: AppColors.primary, size: 20),
                SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Your Pickup OTP', style: TextStyle(fontFamily: 'Noto Sans', fontSize: 11, color: AppColors.onSurfaceVariant)),
                      Text('7 4 8 2 1 6', style: TextStyle(fontFamily: 'Noto Sans', fontSize: 24, fontWeight: FontWeight.w700, color: AppColors.primary, letterSpacing: 6)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          const Text('Share this OTP with the collector at the time of handover.',
              style: TextStyle(fontFamily: 'Noto Sans', fontSize: 12, color: AppColors.onSurfaceVariant)),
        ],
      ),
    );
  }
}

class _SellerCompletedCard extends StatelessWidget {
  final String collectorName, category, date, paidAmount, kg;
  const _SellerCompletedCard({
    required this.collectorName,
    required this.category,
    required this.date,
    required this.paidAmount,
    required this.kg,
  });

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
            decoration: const BoxDecoration(color: AppColors.statusOnlineBg, shape: BoxShape.circle),
            child: const Icon(Icons.check_circle, color: AppColors.statusOnline, size: 24),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(collectorName,
                    style: const TextStyle(fontFamily: 'Noto Sans', fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.onSurface)),
                Text('$category · $kg',
                    style: const TextStyle(fontFamily: 'Noto Sans', fontSize: 12, color: AppColors.onSurfaceVariant)),
                Text(date, style: const TextStyle(fontFamily: 'Noto Sans', fontSize: 11, color: AppColors.onSurfaceVariant)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(paidAmount,
                  style: const TextStyle(fontFamily: 'Noto Sans', fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.primary)),
              const Text('Paid via UPI', style: TextStyle(fontFamily: 'Noto Sans', fontSize: 10, color: AppColors.statusOnline, fontWeight: FontWeight.w600)),
            ],
          ),
        ],
      ),
    );
  }
}
