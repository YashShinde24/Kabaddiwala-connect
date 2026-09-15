import 'package:flutter/material.dart';
import '../app_colors.dart';

// ---------------------------------------------------------------------------
// Animated Connectivity / Sync Indicator
// ---------------------------------------------------------------------------
class ConnectivityIndicator extends StatefulWidget {
  final bool isOnline;
  const ConnectivityIndicator({super.key, this.isOnline = true});

  @override
  State<ConnectivityIndicator> createState() => _ConnectivityIndicatorState();
}

class _ConnectivityIndicatorState extends State<ConnectivityIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _pulse;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
    _pulse = Tween<double>(begin: 0.4, end: 1.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = widget.isOnline ? AppColors.primary : AppColors.statusOffline;
    final label = widget.isOnline ? 'Online' : 'Offline';

    return Container(
      height: 28,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.primaryFixed.withOpacity(0.25),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedBuilder(
            animation: _pulse,
            builder: (context, _) => Opacity(
              opacity: _pulse.value,
              child: Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              ),
            ),
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              fontFamily: 'Noto Sans',
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(width: 4),
          const Icon(Icons.sync, size: 14, color: AppColors.primary),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Language Toggle Pill (EN / हिं / मराठी)
// ---------------------------------------------------------------------------
class LanguageToggle extends StatefulWidget {
  const LanguageToggle({super.key});

  @override
  State<LanguageToggle> createState() => _LanguageToggleState();
}

class _LanguageToggleState extends State<LanguageToggle> {
  int _selected = 0;
  final _langs = ['English', 'हिन्दी', 'मराठी'];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainer,
        borderRadius: BorderRadius.circular(999),
        boxShadow: const [BoxShadow(color: Color(0x0A000000), blurRadius: 4)],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(_langs.length, (i) {
          final active = i == _selected;
          return GestureDetector(
            onTap: () => setState(() => _selected = i),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: active ? AppColors.primary : Colors.transparent,
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text(
                _langs[i],
                style: TextStyle(
                  fontFamily: 'Noto Sans',
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: active ? AppColors.onPrimary : AppColors.onSurfaceVariant,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Trust Badge Chip
// ---------------------------------------------------------------------------
enum TrustLevel { cpcbAuthorized, verifiedCollector, unverified }

class TrustBadge extends StatelessWidget {
  final TrustLevel level;
  const TrustBadge({super.key, required this.level});

  @override
  Widget build(BuildContext context) {
    late Color bg, border, textColor;
    late IconData icon;
    late String label;

    switch (level) {
      case TrustLevel.cpcbAuthorized:
        bg = const Color(0xFFECFDF5);
        border = const Color(0xFFA7F3D0);
        textColor = const Color(0xFF065F46);
        icon = Icons.verified_user;
        label = '✅ CPCB Authorized';
        break;
      case TrustLevel.verifiedCollector:
        bg = const Color(0xFFF0F9FF);
        border = const Color(0xFFBAE6FD);
        textColor = const Color(0xFF0369A1);
        icon = Icons.star;
        label = '⭐ Verified Collector';
        break;
      case TrustLevel.unverified:
        bg = const Color(0xFFFFFBEB);
        border = const Color(0xFFFDE68A);
        textColor = const Color(0xFF92400E);
        icon = Icons.warning_amber_rounded;
        label = '⚠️ Unverified';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: textColor),
          const SizedBox(width: 4),
          Text(label,
              style: TextStyle(
                fontFamily: 'Noto Sans',
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: textColor,
              )),
        ],
      ),
    );
  }
}
