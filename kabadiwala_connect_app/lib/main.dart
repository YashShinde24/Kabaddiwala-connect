import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';
import 'screens/onboarding_screen.dart';
import 'screens/home_screen.dart';
import 'screens/listings_screen.dart';
import 'screens/price_trends_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/collector_dashboard.dart';
import 'screens/recycler_dashboard.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));
  runApp(const KabadiwalaConnectApp());
}

class KabadiwalaConnectApp extends StatelessWidget {
  const KabadiwalaConnectApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kabadiwala Connect',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Noto Sans',
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: AppColors.primary,
          onPrimary: AppColors.onPrimary,
          secondary: AppColors.secondary,
          onSecondary: AppColors.onSecondary,
          error: AppColors.error,
          onError: AppColors.onError,
          background: AppColors.background,
          onBackground: AppColors.onBackground,
          surface: AppColors.surface,
          onSurface: AppColors.onSurface,
          tertiary: AppColors.tertiary,
          onTertiary: AppColors.onTertiary,
          outline: AppColors.outline,
          outlineVariant: AppColors.outlineVariant,
          surfaceVariant: AppColors.surfaceVariant,
          onSurfaceVariant: AppColors.onSurfaceVariant,
        ),
        textTheme: GoogleFonts.notoSansTextTheme(),
        scaffoldBackgroundColor: AppColors.surface,
        splashColor: AppColors.primary.withOpacity(0.08),
        highlightColor: AppColors.primary.withOpacity(0.05),
      ),
      home: const AppEntry(),
    );
  }
}

class AppEntry extends StatefulWidget {
  const AppEntry({super.key});

  @override
  State<AppEntry> createState() => _AppEntryState();
}

class _AppEntryState extends State<AppEntry> {
  bool _onboarded = false;
  int _userRole = 0; // 0=Seller, 1=Collector, 2=Recycler

  @override
  Widget build(BuildContext context) {
    if (!_onboarded) {
      return OnboardingScreen(
        onContinue: (int role) => setState(() {
          _userRole = role;
          _onboarded = true;
        }),
      );
    }
    // Route to role-specific dashboard
    switch (_userRole) {
      case 1:
        return const CollectorDashboard();
      case 2:
        return const RecyclerDashboard();
      default:
        return const SellerShell();
    }
  }
}

// ─────────────────────────────────────────────
// Seller Shell (role 0)
// ─────────────────────────────────────────────
class SellerShell extends StatefulWidget {
  const SellerShell({super.key});

  @override
  State<SellerShell> createState() => _SellerShellState();
}

class _SellerShellState extends State<SellerShell> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    SellerHomeScreen(),
    SellerPickupScreen(),
    PriceTrendsScreen(),
    ProfileScreen(),
  ];

  static const _items = [
    _NavItem(Icons.home_outlined, Icons.home, 'Home'),
    _NavItem(Icons.local_shipping_outlined, Icons.local_shipping, 'Pickups'),
    _NavItem(Icons.trending_up_outlined, Icons.trending_up, 'Prices'),
    _NavItem(Icons.person_outline, Icons.person, 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: _SellerBottomNav(
        currentIndex: _currentIndex,
        items: _items,
        onTap: (i) => setState(() => _currentIndex = i),
      ),
    );
  }
}

class _SellerBottomNav extends StatelessWidget {
  final int currentIndex;
  final List<_NavItem> items;
  final ValueChanged<int> onTap;

  const _SellerBottomNav({
    required this.currentIndex,
    required this.items,
    required this.onTap,
  });

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
