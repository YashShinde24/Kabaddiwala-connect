import 'package:flutter/material.dart';
import '../app_colors.dart';
import '../components/collector_card.dart';
import '../components/indicators_and_badges.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isPhotoMode = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: Column(
          children: [
            // ── Sticky Top Bar
            _TopBar(),
            // ── Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── Greeting Banner
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      color: AppColors.surfaceContainerLow,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const ConnectivityIndicator(isOnline: true),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(
                                  color: AppColors.surfaceContainer,
                                  borderRadius: BorderRadius.circular(999),
                                ),
                                child: const Row(
                                  children: [
                                    Icon(Icons.location_on, size: 14, color: AppColors.secondary),
                                    SizedBox(width: 4),
                                    Text('Mayur Vihar, Delhi',
                                        style: TextStyle(
                                            fontFamily: 'Noto Sans',
                                            fontSize: 11,
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.onSurface)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          const Row(
                            children: [
                              Text('Namaste, Sunita!',
                                  style: TextStyle(
                                      fontFamily: 'Noto Sans',
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.onSurface)),
                              SizedBox(width: 6),
                              Text('🙏', style: TextStyle(fontSize: 20)),
                            ],
                          ),
                          const Text(
                            'नमस्ते सुनिता शर्मा • Sell scrap with fair market pricing today',
                            style: TextStyle(
                                fontFamily: 'Noto Sans',
                                fontSize: 12,
                                color: AppColors.onSurfaceVariant),
                          ),
                        ],
                      ),
                    ),

                    // ── AI Listing Card
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceContainerLowest,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: const [
                            BoxShadow(color: Color(0x0D131B2E), blurRadius: 10, offset: Offset(0, 3)),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Header + Mode switcher
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Row(
                                      children: [
                                        Icon(Icons.recycling, color: AppColors.secondary, size: 22),
                                        SizedBox(width: 6),
                                        Text('Add Scrap Item',
                                            style: TextStyle(
                                                fontFamily: 'Noto Sans',
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700,
                                                color: AppColors.onSurface)),
                                      ],
                                    ),
                                    Text('नया कबाड़ आइटम जोड़ें',
                                        style: TextStyle(
                                            fontFamily: 'Noto Sans',
                                            fontSize: 11,
                                            color: AppColors.onSurfaceVariant)),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            // Segmented mode toggle
                            Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: AppColors.surfaceContainerHigh,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  _ModeTab(
                                    label: 'Photo Mode (फोटो)',
                                    icon: Icons.photo_camera,
                                    isActive: _isPhotoMode,
                                    onTap: () => setState(() => _isPhotoMode = true),
                                  ),
                                  _ModeTab(
                                    label: 'Voice Mode (बोलें)',
                                    icon: Icons.mic,
                                    isActive: !_isPhotoMode,
                                    onTap: () => setState(() => _isPhotoMode = false),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 12),
                            // Mode Content
                            if (_isPhotoMode) _PhotoModeContent() else _VoiceModeContent(),
                            const SizedBox(height: 12),
                            // CTA Button
                            SizedBox(
                              width: double.infinity,
                              height: 52,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primary,
                                  foregroundColor: Colors.white,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                ),
                                onPressed: () {},
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Row(
                                      children: [
                                        Icon(Icons.post_add, size: 22),
                                        SizedBox(width: 10),
                                        Text('Continue to List Lot',
                                            style: TextStyle(
                                                fontFamily: 'Noto Sans',
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700)),
                                      ],
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                      decoration: BoxDecoration(
                                        color: AppColors.primaryFixed.withOpacity(0.25),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: const Text('₹1,250 Est.',
                                          style: TextStyle(
                                              fontFamily: 'Noto Sans',
                                              fontSize: 13,
                                              fontWeight: FontWeight.w800,
                                              color: Colors.white)),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // ── Nearby Collectors Section
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Row(
                                    children: [
                                      Icon(Icons.local_shipping, size: 20, color: AppColors.primary),
                                      SizedBox(width: 6),
                                      Text('Nearby Verified Collectors',
                                          style: TextStyle(
                                              fontFamily: 'Noto Sans',
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700,
                                              color: AppColors.onSurface)),
                                    ],
                                  ),
                                  Text('आसपास के सत्यापित कबाड़ीवाले',
                                      style: TextStyle(
                                          fontFamily: 'Noto Sans',
                                          fontSize: 11,
                                          color: AppColors.onSurfaceVariant)),
                                ],
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: AppColors.primaryFixed.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(999),
                                ),
                                child: const Text('3 Active Now',
                                    style: TextStyle(
                                        fontFamily: 'Noto Sans',
                                        fontSize: 11,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.primary)),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          CollectorCard(
                            initials: 'RG',
                            name: 'Rajiv Green Collector',
                            distanceKm: '0.8',
                            etaMinutes: '25',
                            eWasteRate: '₹42/kg',
                            paperRate: '₹14/kg',
                            plasticRate: '₹18/kg',
                            trustLevel: TrustLevel.verifiedCollector,
                            rating: 4.8,
                            onBook: () {},
                          ),
                          const SizedBox(height: 10),
                          CollectorCard(
                            initials: 'MK',
                            name: 'Mahesh Kabadiwala',
                            distanceKm: '1.4',
                            etaMinutes: '40',
                            eWasteRate: '₹38/kg',
                            paperRate: '₹13/kg',
                            plasticRate: '₹17/kg',
                            trustLevel: TrustLevel.cpcbAuthorized,
                            rating: 4.6,
                            onBook: () {},
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
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

class _TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(bottom: BorderSide(color: Color(0x14000000))),
      ),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.sync, color: AppColors.primaryFixed, size: 18),
          ),
          const SizedBox(width: 8),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Row(
                children: [
                  Text('Kabadiwala',
                      style: TextStyle(
                          fontFamily: 'Noto Sans',
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primary)),
                  SizedBox(width: 4),
                  Text('Connect',
                      style: TextStyle(
                          fontFamily: 'Noto Sans',
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: AppColors.secondary)),
                ],
              ),
              Text('Home',
                  style: TextStyle(
                      fontFamily: 'Noto Sans', fontSize: 11, color: AppColors.onSurfaceVariant)),
            ],
          ),
          const Spacer(),
          const ConnectivityIndicator(isOnline: true),
          const SizedBox(width: 8),
          // Language toggle compact
          GestureDetector(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.surfaceContainer,
                borderRadius: BorderRadius.circular(999),
              ),
              child: const Row(
                children: [
                  Text('EN',
                      style: TextStyle(
                          fontFamily: 'Noto Sans',
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primary)),
                  Text(' / ',
                      style: TextStyle(
                          fontFamily: 'Noto Sans',
                          fontSize: 11,
                          color: AppColors.outline)),
                  Text('हिं',
                      style: TextStyle(
                          fontFamily: 'Noto Sans',
                          fontSize: 11,
                          color: AppColors.onSurfaceVariant)),
                ],
              ),
            ),
            onTap: () {},
          ),
          const SizedBox(width: 8),
          CircleAvatar(
            radius: 18,
            backgroundColor: AppColors.primaryFixed,
            child: const Icon(Icons.person, color: AppColors.primary, size: 20),
          ),
        ],
      ),
    );
  }
}

class _PhotoModeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // AI viewfinder area
        Container(
          height: 168,
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Stack(
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.camera_alt, size: 40, color: AppColors.primary.withOpacity(0.4)),
                    const SizedBox(height: 8),
                    const Text('Tap to scan your scrap',
                        style: TextStyle(
                            fontFamily: 'Noto Sans',
                            fontSize: 13,
                            color: AppColors.onSurfaceVariant)),
                  ],
                ),
              ),
              // AI detection overlay
              Positioned(
                top: 10,
                left: 10,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: const Row(
                    children: [
                      SizedBox(
                        width: 8,
                        height: 8,
                        child: CircularProgressIndicator(
                            color: Colors.white, strokeWidth: 2),
                      ),
                      SizedBox(width: 6),
                      Text('AI Vision Detected',
                          style: TextStyle(
                              fontFamily: 'Noto Sans',
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: Colors.white)),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.inverseSurface.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: const Text('98.4% Accuracy',
                      style: TextStyle(
                          fontFamily: 'Noto Sans',
                          fontSize: 11,
                          color: AppColors.inverseOnSurface)),
                ),
              ),
              Positioned(
                bottom: 10,
                left: 10,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceContainerLowest.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text('Grade A Motherboard + Cu Wires',
                      style: TextStyle(
                          fontFamily: 'Noto Sans',
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primary)),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        // Valuation card
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerLow,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Motherboard & High-grade PCB',
                          style: TextStyle(
                              fontFamily: 'Noto Sans',
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: AppColors.onSurface)),
                      Text('कंप्यूटर मदरबोर्ड (Grade A)',
                          style: TextStyle(
                              fontFamily: 'Noto Sans',
                              fontSize: 11,
                              color: AppColors.onSurfaceVariant)),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: AppColors.primaryFixed,
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: const Text('Good / Reusable',
                        style: TextStyle(
                            fontFamily: 'Noto Sans',
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: AppColors.onPrimaryFixedVariant)),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  color: AppColors.secondaryFixed,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.trending_up, color: AppColors.secondary, size: 20),
                        SizedBox(width: 6),
                        Text('Estimated Fair Value',
                            style: TextStyle(
                                fontFamily: 'Noto Sans',
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: AppColors.onSecondaryFixed)),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text('₹480 – ₹550',
                            style: TextStyle(
                                fontFamily: 'Noto Sans',
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: AppColors.secondary)),
                        SizedBox(width: 2),
                        Text('/ kg',
                            style: TextStyle(
                                fontFamily: 'Noto Sans',
                                fontSize: 11,
                                color: AppColors.onSecondaryFixedVariant)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _VoiceModeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
              boxShadow: const [BoxShadow(color: Color(0x30164E33), blurRadius: 20)],
            ),
            child: const Icon(Icons.mic, color: Colors.white, size: 28),
          ),
          const SizedBox(height: 12),
          const Text('Press & hold to speak',
              style: TextStyle(
                  fontFamily: 'Noto Sans',
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: AppColors.onSurface)),
          const Text('बोलकर कबाड़ की लिस्ट बनाएं',
              style: TextStyle(
                  fontFamily: 'Noto Sans',
                  fontSize: 11,
                  color: AppColors.onSurfaceVariant)),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerLowest.withOpacity(0.8),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              '"मेरे पास 5 पुराने पंखे और 2 लैपटॉप की बैटरी हैं"',
              style: TextStyle(
                  fontFamily: 'Noto Sans',
                  fontSize: 13,
                  fontStyle: FontStyle.italic,
                  color: AppColors.onSurface),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class _ModeTab extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isActive;
  final VoidCallback onTap;

  const _ModeTab({
    required this.label,
    required this.icon,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
          decoration: BoxDecoration(
            color: isActive ? AppColors.surfaceContainerLowest : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            boxShadow: isActive
                ? const [BoxShadow(color: Color(0x0A000000), blurRadius: 4)]
                : [],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon,
                  size: 16,
                  color: isActive ? AppColors.primary : AppColors.onSurfaceVariant),
              const SizedBox(width: 6),
              Flexible(
                child: Text(label,
                    style: TextStyle(
                        fontFamily: 'Noto Sans',
                        fontSize: 12,
                        fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                        color: isActive ? AppColors.primary : AppColors.onSurfaceVariant)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
