import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../config/routes.dart';
import '../../../services/auth_service.dart';
import '../../../shared/widgets/gradient_background.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final user = authService.user;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: GradientBackground(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Section
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white.withOpacity(0.2)),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.white.withOpacity(0.2),
                      child: Icon(
                        Icons.person,
                        size: 40,
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user?.name ?? 'User',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            user?.phone ?? 'Phone number not available',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white.withOpacity(0.8),
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.white),
                      onPressed: () {
                        // Navigate to edit profile
                        Navigator.pushNamed(context, AppRoutes.profileSetup);
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              
              // Account Settings
              _buildSectionTitle('Account Settings'),
              _buildSettingItem(
                context,
                icon: Icons.person_outline,
                title: 'Edit Profile',
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.profileSetup);
                },
              ),
              _buildSettingItem(
                context,
                icon: Icons.notifications_outlined,
                title: 'Notification Settings',
                onTap: () {
                  // Navigate to notification settings
                },
              ),
              _buildSettingItem(
                context,
                icon: Icons.language_outlined,
                title: 'Language',
                subtitle: 'English',
                onTap: () {
                  // Show language selection dialog
                },
              ),
              
              const SizedBox(height: 16),
              
              // App Settings
              _buildSectionTitle('App Settings'),
              _buildSettingItem(
                context,
                icon: Icons.color_lens_outlined,
                title: 'Theme',
                subtitle: 'System Default',
                onTap: () {
                  // Show theme selection dialog
                },
              ),
              _buildSettingItem(
                context,
                icon: Icons.storage_outlined,
                title: 'Clear Cache',
                onTap: () {
                  // Show clear cache confirmation dialog
                  _showClearCacheDialog(context);
                },
              ),
              
              const SizedBox(height: 16),
              
              // About & Legal
              _buildSectionTitle('About & Legal'),
              _buildSettingItem(
                context,
                icon: Icons.info_outline,
                title: 'About Us',
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.aboutUs);
                },
              ),
              _buildSettingItem(
                context,
                icon: Icons.privacy_tip_outlined,
                title: 'Privacy Policy',
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.privacyPolicy);
                },
              ),
              _buildSettingItem(
                context,
                icon: Icons.gavel_outlined,
                title: 'Terms & Conditions',
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.termsConditions);
                },
              ),
              _buildSettingItem(
                context,
                icon: Icons.help_outline,
                title: 'Help & Support',
                onTap: () {
                  // Navigate to help & support
                },
              ),
              
              const SizedBox(height: 24),
              
              // Sign Out Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () async {
                    // Show sign out confirmation dialog
                    final confirm = await _showSignOutDialog(context);
                    if (confirm == true) {
                      await authService.signOut();
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        AppRoutes.signup,
                        (route) => false,
                      );
                    }
                  },
                  icon: const Icon(Icons.logout),
                  label: const Text('Sign Out'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              
              const SizedBox(height: 24),
              
              // App Version
              Center(
                child: Text(
                  'Version 1.0.0',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white.withOpacity(0.6),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildSettingItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    String? subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(
        title,
        style: const TextStyle(color: Colors.white),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle,
              style: TextStyle(color: Colors.white.withOpacity(0.7)),
            )
          : null,
      trailing: const Icon(Icons.chevron_right, color: Colors.white),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
    );
  }

  Future<bool?> _showSignOutDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sign Out'),
        content: const Text('Are you sure you want to sign out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Sign Out'),
          ),
        ],
      ),
    );
  }

  Future<void> _showClearCacheDialog(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear Cache'),
        content: const Text('This will clear all cached data. Continue?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // Clear cache logic here
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Cache cleared successfully'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text('Clear'),
          ),
        ],
      ),
    );
  }
}

