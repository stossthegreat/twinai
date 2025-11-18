import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_dimensions.dart';
import '../../constants/app_text_styles.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        backgroundColor: AppColors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.emerald400),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'PRIVACY POLICY',
          style: AppTextStyles.header2.copyWith(
            color: AppColors.emerald400,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppDimensions.paddingM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: AppDimensions.paddingL),
            
            _buildSection(
              'Neural Data Collection',
              'TWIN OS collects behavioral patterns, interaction data, and neural signatures to provide personalized insights. All data processing occurs locally on your device with end-to-end encryption.',
            ),
            
            _buildSection(
              'Pattern Analysis',
              'Your behavioral patterns are analyzed using advanced neural networks. This analysis helps predict future states and provide intervention recommendations. No raw personal data leaves your device.',
            ),
            
            _buildSection(
              'Data Storage',
              'All neural data is stored locally on your device using AES-256 encryption. Optional cloud backup uses zero-knowledge encryption where even TWIN OS cannot access your raw data.',
            ),
            
            _buildSection(
              'Sharing & Third Parties',
              'TWIN OS does not share, sell, or distribute your neural data to third parties. Anonymous usage statistics may be collected to improve the neural algorithms, but this data cannot be traced back to you.',
            ),
            
            _buildSection(
              'Data Rights',
              'You have complete control over your neural data. You can export, delete, or modify your data at any time through the settings panel. Data portability is fully supported.',
            ),
            
            _buildSection(
              'Security Measures',
              'TWIN OS implements state-of-the-art security including biometric authentication, secure enclaves, and real-time threat detection to protect your neural patterns from unauthorized access.',
            ),
            
            _buildSection(
              'Updates & Changes',
              'This privacy policy may be updated to reflect new neural capabilities. You will be notified of any material changes and must consent to continue using advanced features.',
            ),
            
            const SizedBox(height: AppDimensions.paddingL),
            
            _buildFooter(),
          ],
        ),
      ),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.security,
                color: AppColors.emerald400,
                size: 24,
              ),
              const SizedBox(width: AppDimensions.paddingS),
              Text(
                'Neural Data Protection',
                style: AppTextStyles.header2.copyWith(
                  color: AppColors.emerald400,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimensions.paddingS),
          Text(
            'Your neural patterns and behavioral data are protected by advanced encryption and privacy-preserving technologies. This policy explains how TWIN OS handles your most sensitive information.',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.white80,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppDimensions.paddingL),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyles.header2.copyWith(
              color: AppColors.white90,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: AppDimensions.paddingS),
          Text(
            content,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.white70,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.paddingM),
      decoration: BoxDecoration(
        color: AppColors.white.withOpacity(0.05),
        border: Border.all(
          color: AppColors.white10,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(AppDimensions.radiusL),
      ),
      child: Column(
        children: [
          Text(
            'Last Updated: November 2025',
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.white50,
            ),
          ),
          const SizedBox(height: AppDimensions.paddingS),
          Text(
            'For questions about this privacy policy, contact neural-privacy@twinos.ai',
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.emerald400,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
