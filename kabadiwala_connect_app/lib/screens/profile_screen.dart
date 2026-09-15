import 'package:flutter/material.dart';
import '../app_colors.dart';
import '../components/indicators_and_badges.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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
              // ── Header
              const Text('Profile',
                  style: TextStyle(
                      fontFamily: 'Noto Sans',
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: AppColors.onSurface)),
              const SizedBox(height: 16),

              // ── Profile Card
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
                      backgroundColor: AppColors.primaryFixed,
                      child: const Text('SS',
                          style: TextStyle(
                              fontFamily: 'Noto Sans',
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              color: AppColors.primary)),
                    ),
                    const SizedBox(width: 14),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Sunita Sharma',
                              style: TextStyle(
                                  fontFamily: 'Noto Sans',
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.onSurface)),
                          Text('+91 98765 43210',
                              style: TextStyle(
                                  fontFamily: 'Noto Sans',
                                  fontSize: 13,
                                  color: AppColors.onSurfaceVariant)),
                          SizedBox(height: 4),
                          Text('Seller · Mayur Vihar, Delhi',
                              style: TextStyle(
                                  fontFamily: 'Noto Sans',
                                  fontSize: 12,
                                  color: AppColors.onSurfaceVariant)),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.edit_outlined, color: AppColors.primary),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              // Trust badge
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: const [
                  TrustBadge(level: TrustLevel.verifiedCollector),
                ],
              ),
              const SizedBox(height: 20),

              // Stats
              const Text('Your Stats',
                  style: TextStyle(
                      fontFamily: 'Noto Sans',
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.onSurface)),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(child: _StatCard('Total Sold', '145 kg', Icons.scale, AppColors.primary)),
                  const SizedBox(width: 10),
                  Expanded(child: _StatCard('Total Earned', '₹4,680', Icons.currency_rupee, AppColors.secondary)),
                  const SizedBox(width: 10),
                  Expanded(child: _StatCard('Pickups', '12', Icons.local_shipping, AppColors.tertiary)),
                ],
              ),
              const SizedBox(height: 20),

              // Offline Sync
              const Text('Sync Status',
                  style: TextStyle(
                      fontFamily: 'Noto Sans',
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.onSurface)),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainerLowest,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.outlineVariant),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('Connection Status',
                            style: TextStyle(
                                fontFamily: 'Noto Sans',
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: AppColors.onSurface)),
                        ConnectivityIndicator(isOnline: true),
                      ],
                    ),
                    const Divider(height: 20, color: AppColors.outlineVariant),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Last Synced',
                            style: TextStyle(
                                fontFamily: 'Noto Sans',
                                fontSize: 12,
                                color: AppColors.onSurfaceVariant)),
                        Text('2 minutes ago',
                            style: TextStyle(
                                fontFamily: 'Noto Sans',
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primary)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Pending Offline Data',
                            style: TextStyle(
                                fontFamily: 'Noto Sans',
                                fontSize: 12,
                                color: AppColors.onSurfaceVariant)),
                        Text('0 items',
                            style: TextStyle(
                                fontFamily: 'Noto Sans',
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: AppColors.statusOnline)),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Settings
              const Text('Settings',
                  style: TextStyle(
                      fontFamily: 'Noto Sans',
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.onSurface)),
              const SizedBox(height: 10),
              _SettingsTile(Icons.language, 'Language', 'English'),
              _SettingsTile(Icons.notifications_outlined, 'Notifications', 'Enabled'),
              _SettingsTile(Icons.dark_mode_outlined, 'Theme', 'Light Mode'),
              _SettingsTile(Icons.help_outline, 'Help & Support', ''),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.error,
                    side: const BorderSide(color: AppColors.error),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  icon: const Icon(Icons.logout),
                  label: const Text('Sign Out',
                      style: TextStyle(
                          fontFamily: 'Noto Sans', fontSize: 14, fontWeight: FontWeight.w600)),
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

class _StatCard extends StatelessWidget {
  final String title, value;
  final IconData icon;
  final Color color;
  const _StatCard(this.title, this.value, this.icon, this.color);

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
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 6),
          Text(value,
              style: TextStyle(
                  fontFamily: 'Noto Sans',
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: color)),
          Text(title,
              style: const TextStyle(
                  fontFamily: 'Noto Sans', fontSize: 10, fontWeight: FontWeight.w600, color: AppColors.onSurface),
              textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const _SettingsTile(this.icon, this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 2),
      leading: Icon(icon, color: AppColors.primary, size: 22),
      title: Text(label,
          style: const TextStyle(
              fontFamily: 'Noto Sans', fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.onSurface)),
      trailing: value.isNotEmpty
          ? Text(value,
              style: const TextStyle(
                  fontFamily: 'Noto Sans',
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary))
          : const Icon(Icons.chevron_right, color: AppColors.onSurfaceVariant),
      onTap: () {},
    );
  }
}
