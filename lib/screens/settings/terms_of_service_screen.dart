import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_dimensions.dart';
import '../../constants/app_text_styles.dart';

class TermsOfServiceScreen extends StatelessWidget {
  const TermsOfServiceScreen({Key? key}) : super(key: key);

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
          'TERMS OF SERVICE',
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
              'Neural Interface Agreement',
              'By using TWIN OS, you agree to interface with an advanced neural prediction system. This system analyzes behavioral patterns and provides predictive insights that may be highly accurate and personally revealing.',
            ),
            
            _buildSection(
              'Acceptable Use',
              'TWIN OS is designed for personal insight and behavioral optimization. You may not use the system for harmful purposes, to manipulate others, or to make critical life decisions without human judgment and professional consultation.',
            ),
            
            _buildSection(
              'Prediction Accuracy',
              'While TWIN OS achieves high accuracy rates, predictions are probabilistic and should not be treated as certainties. The system provides insights and recommendations, not absolute truths about your future.',
            ),
            
            _buildSection(
              'Personal Responsibility',
              'You remain fully responsible for your decisions and actions. TWIN OS provides information and analysis, but you must exercise your own judgment, especially for important personal, professional, or health-related decisions.',
            ),
            
            _buildSection(
              'Neural Pattern Licensing',
              'You retain ownership of your neural patterns and behavioral data. By using TWIN OS, you grant the system permission to analyze this data locally on your device to provide insights and predictions.',
            ),
            
            _buildSection(
              'System Limitations',
              'TWIN OS cannot predict external events, other people\'s actions, or outcomes dependent on factors outside your behavioral patterns. The system focuses on your internal patterns and their likely manifestations.',
            ),
            
            _buildSection(
              'Updates & Modifications',
              'TWIN OS may receive neural algorithm updates that improve accuracy or add new capabilities. Significant changes to terms of service will require your explicit consent.',
            ),
            
            _buildSection(
              'Termination',
              'You may discontinue using TWIN OS at any time. Upon termination, you can export your data or request complete deletion of neural patterns from the system.',
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
            AppColors.amber500.withOpacity(0.2),
            AppColors.rose500.withOpacity(0.1),
          ],
        ),
        border: Border.all(
          color: AppColors.amber400.withOpacity(0.3),
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
                Icons.gavel,
                color: AppColors.amber400,
                size: 24,
              ),
              const SizedBox(width: AppDimensions.paddingS),
              Text(
                'Neural Interface Terms',
                style: AppTextStyles.header2.copyWith(
                  color: AppColors.amber400,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimensions.paddingS),
          Text(
            'These terms govern your use of the TWIN OS neural prediction system. Please read carefully as this system provides powerful insights into your behavioral patterns and future probabilities.',
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
            'Effective Date: November 2025',
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.white50,
            ),
          ),
          const SizedBox(height: AppDimensions.paddingS),
          Text(
            'For legal questions, contact legal@twinos.ai',
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.amber400,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
