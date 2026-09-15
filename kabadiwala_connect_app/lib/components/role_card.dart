import 'package:flutter/material.dart';
import '../app_colors.dart';

/// Role card used in the Onboarding screen
class RoleCard extends StatelessWidget {
  final String titleEn;
  final String titleHi;
  final String subtitleEn;
  final String subtitleHi;
  final String description;
  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final Color accentColor;
  final bool isSelected;
  final bool isPopular;
  final List<_Benefit> benefits;
  final VoidCallback onTap;

  const RoleCard({
    super.key,
    required this.titleEn,
    required this.titleHi,
    required this.subtitleEn,
    required this.subtitleHi,
    required this.description,
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    required this.accentColor,
    required this.benefits,
    required this.onTap,
    this.isSelected = false,
    this.isPopular = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? accentColor : AppColors.outlineVariant,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0x0A131B2E),
              blurRadius: isSelected ? 12 : 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(color: iconBg, borderRadius: BorderRadius.circular(12)),
                      child: Icon(icon, color: iconColor, size: 28),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(titleEn,
                                  style: const TextStyle(
                                      fontFamily: 'Noto Sans',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.onSurface)),
                              const SizedBox(width: 6),
                              Text('($titleHi)',
                                  style: TextStyle(
                                      fontFamily: 'Noto Sans',
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      color: accentColor)),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: iconBg,
                              borderRadius: BorderRadius.circular(999),
                            ),
                            child: Text('$subtitleEn • $subtitleHi',
                                style: const TextStyle(
                                    fontFamily: 'Noto Sans',
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.onPrimaryFixed)),
                          ),
                        ],
                      ),
                    ),
                    // Radio indicator
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: isSelected ? accentColor : AppColors.surfaceContainerHighest,
                        shape: BoxShape.circle,
                      ),
                      child: isSelected
                          ? const Icon(Icons.check, size: 15, color: Colors.white)
                          : null,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(description,
                    style: const TextStyle(
                        fontFamily: 'Noto Sans',
                        fontSize: 12,
                        height: 1.5,
                        color: AppColors.onSurfaceVariant)),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: benefits
                      .map((b) => _BenefitChip(icon: b.icon, label: b.label, color: b.color))
                      .toList(),
                ),
              ],
            ),
            if (isPopular)
              Positioned(
                top: -22,
                right: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.secondary,
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.star, color: Colors.white, size: 12),
                      SizedBox(width: 3),
                      Text('MOST POPULAR • सबसे लोकप्रिय',
                          style: TextStyle(
                              fontFamily: 'Noto Sans',
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: Colors.white)),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _Benefit {
  final IconData icon;
  final String label;
  final Color color;
  const _Benefit(this.icon, this.label, this.color);
}

class _BenefitChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  const _BenefitChip({required this.icon, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: color),
          const SizedBox(width: 4),
          Text(label,
              style: const TextStyle(
                  fontFamily: 'Noto Sans', fontSize: 11, color: AppColors.onSurface)),
        ],
      ),
    );
  }
}

// Expose _Benefit for use in screens
List<_Benefit> sellerBenefits() => [
      _Benefit(Icons.door_front_door, 'Free doorstep evaluation', AppColors.primary),
      _Benefit(Icons.price_change, 'Daily Rate Card (पारदर्शी दरें)', AppColors.secondary),
      _Benefit(Icons.photo_camera, '1-Tap Photo Listing', AppColors.primary),
    ];

List<_Benefit> collectorBenefits() => [
      _Benefit(Icons.scale, 'Instant Smart Scale Slips', AppColors.primary),
      _Benefit(Icons.route, 'Optimized Cluster Routes', AppColors.secondary),
      _Benefit(Icons.verified, 'Guaranteed CPCB Buyers', AppColors.primary),
    ];

List<_Benefit> recyclerBenefits() => [
      _Benefit(Icons.receipt_long, 'EPR Compliance Manifests', AppColors.primary),
      _Benefit(Icons.account_balance, 'Direct RTGS / Bank Payout', AppColors.secondary),
      _Benefit(Icons.forklift, 'Yard Gate Batch Inward', AppColors.primary),
    ];
