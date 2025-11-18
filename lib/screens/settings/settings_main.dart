import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_dimensions.dart';
import '../../constants/app_text_styles.dart';
import 'privacy_policy_screen.dart';
import 'terms_of_service_screen.dart';
import 'about_screen.dart';

class SettingsMainScreen extends StatefulWidget {
  const SettingsMainScreen({Key? key}) : super(key: key);

  @override
  State<SettingsMainScreen> createState() => _SettingsMainScreenState();
}

class _SettingsMainScreenState extends State<SettingsMainScreen> {
  bool _notificationsEnabled = true;
  bool _darkModeEnabled = true;
  bool _analyticsEnabled = false;
  double _animationSpeed = 1.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppDimensions.paddingM),
        child: Column(
          children: [
            // Header section
            _buildHeader(),
            
            const SizedBox(height: AppDimensions.paddingL),
            
            // Preferences section
            _buildPreferencesSection(),
            
            const SizedBox(height: AppDimensions.paddingL),
            
            // Data & Privacy section
            _buildDataPrivacySection(),
            
            const SizedBox(height: AppDimensions.paddingL),
            
            // Support section
            _buildSupportSection(),
            
            const SizedBox(height: AppDimensions.paddingL),
            
            // About section
            _buildAboutSection(),
            
            const SizedBox(height: AppDimensions.paddingXL),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.black,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: AppColors.emerald400),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(
        'TWIN OS SETTINGS',
        style: AppTextStyles.header2.copyWith(
          color: AppColors.emerald400,
        ),
      ),
      centerTitle: true,
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.paddingL),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.emerald500.withOpacity(0.2),
            AppColors.cyan500.withOpacity(0.1),
          ],
        ),
        border: Border.all(
          color: AppColors.emerald400.withOpacity(0.3),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(AppDimensions.radiusXL),
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.emerald400,
              boxShadow: [
                BoxShadow(
                  color: AppColors.emerald400.withOpacity(0.3),
                  blurRadius: 15,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: const Icon(
              Icons.settings,
              color: AppColors.black,
              size: 30,
            ),
          ),
          const SizedBox(width: AppDimensions.paddingM),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'System Configuration',
                  style: AppTextStyles.header2.copyWith(
                    color: AppColors.white90,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Neural interface personalization',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.white60,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate()
      .fadeIn(duration: 600.ms)
      .slideY(begin: -0.2, end: 0);
  }

  Widget _buildPreferencesSection() {
    return _buildSection(
      title: 'PREFERENCES',
      icon: Icons.tune,
      children: [
        _buildSwitchTile(
          title: 'Neural Notifications',
          subtitle: 'Receive pattern alerts and insights',
          value: _notificationsEnabled,
          onChanged: (value) {
            setState(() {
              _notificationsEnabled = value;
            });
          },
        ),
        _buildSwitchTile(
          title: 'Dark Neural Interface',
          subtitle: 'Optimized for neural synchronization',
          value: _darkModeEnabled,
          onChanged: (value) {
            setState(() {
              _darkModeEnabled = value;
            });
          },
        ),
        _buildSliderTile(
          title: 'Animation Speed',
          subtitle: 'Neural visualization frequency',
          value: _animationSpeed,
          onChanged: (value) {
            setState(() {
              _animationSpeed = value;
            });
          },
        ),
      ],
    );
  }

  Widget _buildDataPrivacySection() {
    return _buildSection(
      title: 'DATA & PRIVACY',
      icon: Icons.security,
      children: [
        _buildSwitchTile(
          title: 'Neural Analytics',
          subtitle: 'Help improve pattern recognition',
          value: _analyticsEnabled,
          onChanged: (value) {
            setState(() {
              _analyticsEnabled = value;
            });
          },
        ),
        _buildNavigationTile(
          title: 'Privacy Policy',
          subtitle: 'How we protect your neural data',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PrivacyPolicyScreen(),
              ),
            );
          },
        ),
        _buildNavigationTile(
          title: 'Terms of Service',
          subtitle: 'Neural interface usage agreement',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const TermsOfServiceScreen(),
              ),
            );
          },
        ),
        _buildNavigationTile(
          title: 'Data Management',
          subtitle: 'Export, delete, or backup neural data',
          onTap: () {
            // Show data management options
            _showDataManagementDialog();
          },
        ),
      ],
    );
  }

  Widget _buildSupportSection() {
    return _buildSection(
      title: 'SUPPORT',
      icon: Icons.help_outline,
      children: [
        _buildNavigationTile(
          title: 'Help Center',
          subtitle: 'Neural interface documentation',
          onTap: () {
            // Navigate to help center
          },
        ),
        _buildNavigationTile(
          title: 'Contact Support',
          subtitle: 'Connect with neural specialists',
          onTap: () {
            // Show contact options
          },
        ),
        _buildNavigationTile(
          title: 'Report Issue',
          subtitle: 'Neural anomaly reporting',
          onTap: () {
            // Show bug report form
          },
        ),
      ],
    );
  }

  Widget _buildAboutSection() {
    return _buildSection(
      title: 'ABOUT',
      icon: Icons.info_outline,
      children: [
        _buildNavigationTile(
          title: 'About TWIN OS',
          subtitle: 'Neural singularity information',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AboutScreen(),
              ),
            );
          },
        ),
        _buildNavigationTile(
          title: 'Version Information',
          subtitle: 'v3.0.1 - Neural Singularity',
          onTap: null,
        ),
        _buildNavigationTile(
          title: 'Licenses',
          subtitle: 'Open source components',
          onTap: () {
            showLicensePage(context: context);
          },
        ),
      ],
    );
  }

  Widget _buildSection({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white.withOpacity(0.05),
        border: Border.all(
          color: AppColors.white10,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(AppDimensions.radiusXL),
      ),
      child: Column(
        children: [
          // Section header
          Padding(
            padding: const EdgeInsets.all(AppDimensions.paddingM),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.emerald400.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                  ),
                  child: Icon(
                    icon,
                    color: AppColors.emerald400,
                    size: 20,
                  ),
                ),
                const SizedBox(width: AppDimensions.paddingM),
                Text(
                  title,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.emerald400,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0,
                  ),
                ),
              ],
            ),
          ),
          
          // Section content
          ...children,
        ],
      ),
    ).animate()
      .fadeIn(duration: 600.ms, delay: 200.ms)
      .slideX(begin: -0.2, end: 0);
  }

  Widget _buildSwitchTile({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingM,
        vertical: AppDimensions.paddingS,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.white90,
                  ),
                ),
                Text(
                  subtitle,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.white50,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.emerald400,
            activeTrackColor: AppColors.emerald400.withOpacity(0.3),
            inactiveThumbColor: AppColors.white40,
            inactiveTrackColor: AppColors.white10,
          ),
        ],
      ),
    );
  }

  Widget _buildSliderTile({
    required String title,
    required String subtitle,
    required double value,
    required ValueChanged<double> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingM,
        vertical: AppDimensions.paddingS,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.white90,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.white50,
                    ),
                  ),
                ],
              ),
              Text(
                '${(value * 100).round()}%',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.emerald400,
                ),
              ),
            ],
          ),
          Slider(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.emerald400,
            inactiveColor: AppColors.white20,
            thumbColor: AppColors.emerald400,
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationTile({
    required String title,
    required String subtitle,
    required VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingM,
          vertical: AppDimensions.paddingM,
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.white90,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.white50,
                    ),
                  ),
                ],
              ),
            ),
            if (onTap != null)
              Icon(
                Icons.arrow_forward_ios,
                color: AppColors.white40,
                size: 16,
              ),
          ],
        ),
      ),
    );
  }

  void _showDataManagementDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.black90,
          title: Text(
            'Data Management',
            style: AppTextStyles.header2.copyWith(
              color: AppColors.emerald400,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDataOption('Export Neural Data', Icons.download),
              _buildDataOption('Backup Patterns', Icons.backup),
              _buildDataOption('Clear Cache', Icons.clear_all),
              _buildDataOption('Delete All Data', Icons.delete_forever),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Cancel',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.white70,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDataOption(String title, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: AppColors.emerald400),
      title: Text(
        title,
        style: AppTextStyles.bodyMedium.copyWith(
          color: AppColors.white90,
        ),
      ),
      onTap: () {
        Navigator.pop(context);
        // Implement data management action
      },
    );
  }
}
