import 'package:flutter/material.dart';
import '../app_colors.dart';
import 'indicators_and_badges.dart';

class CollectorCard extends StatelessWidget {
  final String initials;
  final String name;
  final String distanceKm;
  final String etaMinutes;
  final String eWasteRate;
  final String paperRate;
  final String plasticRate;
  final TrustLevel trustLevel;
  final double rating;
  final VoidCallback? onBook;

  const CollectorCard({
    super.key,
    required this.initials,
    required this.name,
    required this.distanceKm,
    required this.etaMinutes,
    required this.eWasteRate,
    required this.paperRate,
    required this.plasticRate,
    required this.trustLevel,
    this.rating = 4.8,
    this.onBook,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.outlineVariant),
        boxShadow: const [
          BoxShadow(color: Color(0x080F1722), blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Avatar
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.tertiaryFixed,
                  borderRadius: BorderRadius.circular(12),
                ),
                alignment: Alignment.center,
                child: Text(initials,
                    style: const TextStyle(
                        fontFamily: 'Noto Sans',
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: AppColors.onTertiaryFixed)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name,
                        style: const TextStyle(
                            fontFamily: 'Noto Sans',
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: AppColors.onSurface)),
                    const SizedBox(height: 3),
                    Row(
                      children: [
                        const Icon(Icons.near_me, size: 13, color: AppColors.secondary),
                        const SizedBox(width: 3),
                        Text('$distanceKm km away • Arrives in $etaMinutes mins',
                            style: const TextStyle(
                                fontFamily: 'Noto Sans',
                                fontSize: 11,
                                color: AppColors.onSurfaceVariant)),
                      ],
                    ),
                  ],
                ),
              ),
              TrustBadge(level: trustLevel),
            ],
          ),
          const SizedBox(height: 10),
          // Offered rates row
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerLow,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Offered Rates / ऑफर की दरें:',
                    style: TextStyle(
                        fontFamily: 'Noto Sans',
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: AppColors.onSurfaceVariant)),
                const SizedBox(height: 6),
                Wrap(
                  spacing: 10,
                  children: [
                    _RateChip('E-Waste', eWasteRate),
                    _RateChip('Paper', paperRate),
                    _RateChip('Plastic', plasticRate),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          // Rating + Book CTA
          Row(
            children: [
              const Icon(Icons.star, size: 14, color: AppColors.secondary),
              const SizedBox(width: 4),
              Text(rating.toString(),
                  style: const TextStyle(
                      fontFamily: 'Noto Sans',
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: AppColors.onSurface)),
              const Spacer(),
              if (onBook != null)
                SizedBox(
                  height: 36,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                    ),
                    onPressed: onBook,
                    child: const Text('Book / बुक करें',
                        style: TextStyle(
                            fontFamily: 'Noto Sans', fontSize: 13, fontWeight: FontWeight.w700)),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _RateChip extends StatelessWidget {
  final String label;
  final String rate;
  const _RateChip(this.label, this.rate);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(fontFamily: 'Noto Sans', fontSize: 12),
        children: [
          TextSpan(text: '$label: ', style: const TextStyle(color: AppColors.onSurfaceVariant)),
          TextSpan(
              text: rate,
              style: const TextStyle(
                  fontWeight: FontWeight.w700, color: AppColors.primary)),
        ],
      ),
    );
  }
}
