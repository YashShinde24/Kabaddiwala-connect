import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../app_colors.dart';
import '../components/indicators_and_badges.dart';
import '../components/role_card.dart';

class OnboardingScreen extends StatefulWidget {
  final VoidCallback onContinue;
  const OnboardingScreen({super.key, required this.onContinue});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _selectedRole = 1; // default: Collector
  final _phoneController = TextEditingController();
  bool _otpSent = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  void _sendOtp() async {
    if (_phoneController.text.length != 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid 10-digit mobile number')),
      );
      return;
    }
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _isLoading = false;
      _otpSent = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Status Bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    ConnectivityIndicator(isOnline: true),
                    LanguageToggle(),
                  ],
                ),
              ),

              // ── Brand Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(Icons.sync, color: AppColors.primaryFixed, size: 18),
                        ),
                        const SizedBox(width: 8),
                        const Text('KABADIWALA CONNECT',
                            style: TextStyle(
                                fontFamily: 'Noto Sans',
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1.2,
                                color: AppColors.primary)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text('Turn scrap into fair value',
                        style: TextStyle(
                            fontFamily: 'Noto Sans',
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: AppColors.onSurface)),
                    const Text('रद्दी और ई-कचरे का सही दाम',
                        style: TextStyle(
                            fontFamily: 'Noto Sans',
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColors.onSurfaceVariant)),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceContainerHigh,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: const [
                          Icon(Icons.badge, color: AppColors.secondary, size: 20),
                          SizedBox(width: 8),
                          Text('Select your role to continue • अपनी भूमिका चुनें',
                              style: TextStyle(
                                  fontFamily: 'Noto Sans',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.onSurface)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // ── Role Cards
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    RoleCard(
                      titleEn: 'Seller / Household',
                      titleHi: 'विक्रेता / घर',
                      subtitleEn: 'Quick Pickup',
                      subtitleHi: 'Immediate UPI Cash',
                      description:
                          'Sell electronics, old appliances, metal, and household recyclables safely with verified fair digital weight.',
                      icon: Icons.home,
                      iconBg: AppColors.primaryFixed,
                      iconColor: AppColors.primary,
                      accentColor: AppColors.primary,
                      benefits: sellerBenefits(),
                      isSelected: _selectedRole == 0,
                      onTap: () => setState(() => _selectedRole = 0),
                    ),
                    const SizedBox(height: 20),
                    RoleCard(
                      titleEn: 'Collector / Kabadiwala',
                      titleHi: 'कलेक्टर / कबाड़ी',
                      subtitleEn: 'Higher Margins',
                      subtitleHi: 'Route Optimization',
                      description:
                          'Receive area-wise pickup requests, access digital Bluetooth weighing slips, and sell bulk streams to certified plants.',
                      icon: Icons.electric_rickshaw,
                      iconBg: AppColors.secondaryFixed,
                      iconColor: AppColors.onSecondaryFixed,
                      accentColor: AppColors.secondary,
                      benefits: collectorBenefits(),
                      isSelected: _selectedRole == 1,
                      isPopular: true,
                      onTap: () => setState(() => _selectedRole = 1),
                    ),
                    const SizedBox(height: 20),
                    RoleCard(
                      titleEn: 'Recycler / Facility',
                      titleHi: 'अधिकृत रीसाइक्लर',
                      subtitleEn: 'CPCB EPR Verified',
                      subtitleHi: 'GST Invoicing',
                      description:
                          'Procure high-tonnage segregated plastic, metal, and certified e-waste with statutory traceability documentation.',
                      icon: Icons.factory,
                      iconBg: AppColors.tertiaryFixed,
                      iconColor: AppColors.onTertiaryFixed,
                      accentColor: AppColors.tertiary,
                      benefits: recyclerBenefits(),
                      isSelected: _selectedRole == 2,
                      onTap: () => setState(() => _selectedRole = 2),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // ── Phone Login
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceContainer,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: const [
                      BoxShadow(color: Color(0x0A000000), blurRadius: 8, offset: Offset(0, 2)),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text('Mobile Number • मोबाइल नंबर',
                              style: TextStyle(
                                  fontFamily: 'Noto Sans',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.onSurface)),
                          Row(
                            children: [
                              Icon(Icons.lock, size: 12, color: AppColors.primary),
                              SizedBox(width: 4),
                              Text('Instant OTP',
                                  style: TextStyle(
                                      fontFamily: 'Noto Sans',
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.primary)),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      // Phone input
                      Container(
                        height: 52,
                        decoration: BoxDecoration(
                          color: AppColors.surfaceContainerLowest,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColors.outlineVariant),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 14),
                              decoration: const BoxDecoration(
                                border: Border(right: BorderSide(color: AppColors.outlineVariant)),
                              ),
                              child: const Row(
                                children: [
                                  Text('🇮🇳', style: TextStyle(fontSize: 16)),
                                  SizedBox(width: 4),
                                  Text('+91',
                                      style: TextStyle(
                                          fontFamily: 'Noto Sans',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.onSurface)),
                                ],
                              ),
                            ),
                            Expanded(
                              child: TextField(
                                controller: _phoneController,
                                keyboardType: TextInputType.phone,
                                maxLength: 10,
                                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                decoration: const InputDecoration(
                                  hintText: '98765 43210',
                                  border: InputBorder.none,
                                  counterText: '',
                                  contentPadding: EdgeInsets.symmetric(horizontal: 14),
                                ),
                                style: const TextStyle(
                                    fontFamily: 'Noto Sans',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      if (_otpSent) ...[
                        const Text('Enter OTP / OTP दर्ज करें',
                            style: TextStyle(
                                fontFamily: 'Noto Sans',
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: AppColors.onSurface)),
                        const SizedBox(height: 8),
                        Container(
                          height: 52,
                          decoration: BoxDecoration(
                            color: AppColors.surfaceContainerLowest,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: AppColors.primary, width: 2),
                          ),
                          child: const TextField(
                            keyboardType: TextInputType.number,
                            maxLength: 6,
                            decoration: InputDecoration(
                              hintText: '• • • • • •',
                              border: InputBorder.none,
                              counterText: '',
                              contentPadding: EdgeInsets.symmetric(horizontal: 16),
                            ),
                            style: TextStyle(
                                fontFamily: 'Noto Sans',
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 8),
                          ),
                        ),
                        const SizedBox(height: 12),
                      ],
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          onPressed: _isLoading
                              ? null
                              : (_otpSent ? widget.onContinue : _sendOtp),
                          child: _isLoading
                              ? const SizedBox(
                                  width: 22,
                                  height: 22,
                                  child: CircularProgressIndicator(
                                      color: Colors.white, strokeWidth: 2.5),
                                )
                              : Text(
                                  _otpSent
                                      ? 'Verify & Continue →'
                                      : 'Get OTP • OTP प्राप्त करें',
                                  style: const TextStyle(
                                      fontFamily: 'Noto Sans',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
