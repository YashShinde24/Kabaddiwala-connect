import 'package:flutter/material.dart';
import '../app_colors.dart';

class PriceItemCard extends StatelessWidget {
  final String nameEn;
  final String nameHi;
  final IconData icon;
  final String price;
  final String delta;
  final bool isPositive;

  const PriceItemCard({
    super.key,
    required this.nameEn,
    required this.nameHi,
    required this.icon,
    required this.price,
    required this.delta,
    required this.isPositive,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.outlineVariant),
        boxShadow: const [
          BoxShadow(color: Color(0x060F1722), blurRadius: 2, offset: Offset(0, 1)),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.08),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: AppColors.primary, size: 26),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(nameEn,
                    style: const TextStyle(
                        fontFamily: 'Noto Sans',
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: AppColors.onSurface)),
                Text(nameHi,
                    style: const TextStyle(
                        fontFamily: 'Noto Sans',
                        fontSize: 11,
                        color: AppColors.onSurfaceVariant)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Price amber pill
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFBEB),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(price,
                    style: const TextStyle(
                        fontFamily: 'Noto Sans',
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF92400E))),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Icon(
                    isPositive ? Icons.arrow_upward : Icons.arrow_downward,
                    size: 11,
                    color: isPositive ? Colors.green : Colors.red,
                  ),
                  const SizedBox(width: 2),
                  Text(delta,
                      style: TextStyle(
                          fontFamily: 'Noto Sans',
                          fontSize: 11,
                          color: isPositive ? Colors.green : Colors.red)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
