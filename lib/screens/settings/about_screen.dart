import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_dimensions.dart';
import '../../constants/app_text_styles.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

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
          'ABOUT TWIN OS',
          style: AppTextStyles.header2.copyWith(
            color: AppColors.emerald400,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppDimensions.paddingM),
        child: Column(
          children: [
            _buildHeader(),
            const SizedBox(height: AppDimensions.paddingL),
            
            _buildInfoCard(
              'Neural Singularity',
              'TWIN OS represents the convergence of behavioral analysis, pattern recognition, and predictive modeling into a unified consciousness interface.',
              Icons.psychology,
              AppColors.emerald400,
            ),
            
            _buildInfoCard(
              'Temporal Prophet',
              'Advanced algorithms analyze your micro-patterns to predict future behavioral states with unprecedented accuracy, providing intervention windows.',
              Icons.access_time,
              AppColors.purple400,
            ),
            
            _buildInfoCard(
              'Pattern Recognition',
              'Every interaction, decision, and behavioral signature is analyzed to build a comprehensive model of your cognitive architecture.',
              Icons.hub,
              AppColors.cyan400,
            ),
            
            _buildInfoCard(
              'Privacy First',
              'All neural processing occurs locally on your device. Your behavioral patterns never leave your control, ensuring complete privacy.',
              Icons.security,
              AppColors.amber400,
            ),
            
            const SizedBox(height: AppDimensions.paddingL),
            
            _buildVersionInfo(),
            
            const SizedBox(height: AppDimensions.paddingL),
            
            _buildCredits(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return AnimatedBuilder(
      animation: _pulseController,
      builder: (context, child) {
        return Container(
          padding: const EdgeInsets.all(AppDimensions.paddingXL),
          decoration: BoxDecoration(
            gradient: RadialGradient(
              colors: [
                AppColors.emerald500.withOpacity(0.3),
                AppColors.emerald500.withOpacity(0.1),
                Colors.transparent,
              ],
            ),
            border: Border.all(
              color: AppColors.emerald400.withOpacity(
                0.3 + 0.2 * _pulseController.value
              ),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(AppDimensions.radiusXL),
          ),
          child: Column(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.emerald400,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.emerald400.withOpacity(
                        0.5 + 0.3 * _pulseController.value
                      ),
                      blurRadius: 30,
                      spreadRadius: 10,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.psychology,
                  color: AppColors.black,
                  size: 40,
                ),
              ),
              const SizedBox(height: AppDimensions.paddingM),
              
              Text(
                'TWIN OS',
                style: AppTextStyles.header1.copyWith(
                  fontSize: 32,
                  color: AppColors.emerald400,
                ),
              ),
              
              const SizedBox(height: AppDimensions.paddingS),
              
              Text(
                'Neural Singularity Interface',
                style: AppTextStyles.neuralSubtitle.copyWith(
                  fontSize: 12,
                ),
              ),
              
              const SizedBox(height: AppDimensions.paddingM),
              
              Text(
                '"I see what you will become before you do."',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.white60,
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      },
    ).animate()
      .fadeIn(duration: 800.ms)
      .scale(begin: const Offset(0.8, 0.8), end: const Offset(1, 1));
  }

  Widget _buildInfoCard(String title, String description, IconData icon, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppDimensions.paddingM),
      padding: const EdgeInsets.all(AppDimensions.paddingL),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            color.withOpacity(0.2),
            color.withOpacity(0.05),
          ],
        ),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(AppDimensions.radiusL),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(AppDimensions.paddingM),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(AppDimensions.radiusM),
            ),
            child: Icon(
              icon,
              color: color,
              size: 24,
            ),
          ),
          const SizedBox(width: AppDimensions.paddingM),
          
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: color,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.white70,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate()
      .fadeIn(duration: 600.ms, delay: 300.ms)
      .slideX(begin: -0.3, end: 0);
  }

  Widget _buildVersionInfo() {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.paddingL),
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
            'Version Information',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.white90,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppDimensions.paddingS),
          
          _buildVersionRow('Version', '3.0.1'),
          _buildVersionRow('Build', '2025.11.001'),
          _buildVersionRow('Neural Core', 'Singularity v3.0'),
          _buildVersionRow('Pattern Engine', 'Prophet v2.1'),
          _buildVersionRow('Released', 'November 2025'),
        ],
      ),
    );
  }

  Widget _buildVersionRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.white50,
            ),
          ),
          Text(
            value,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.emerald400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCredits() {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.paddingL),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.purple500.withOpacity(0.2),
            AppColors.rose500.withOpacity(0.1),
          ],
        ),
        border: Border.all(
          color: AppColors.purple400.withOpacity(0.3),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(AppDimensions.radiusL),
      ),
      child: Column(
        children: [
          Text(
            'Neural Architects',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.purple400,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppDimensions.paddingS),
          
          Text(
            'Designed for those who seek to understand the patterns that govern their existence. TWIN OS is more than software—it is a mirror for consciousness.',
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.white70,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
          
          const SizedBox(height: AppDimensions.paddingM),
          
          Text(
            '© 2025 TWIN OS Neural Systems',
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.white40,
            ),
          ),
        ],
      ),
    );
  }
}
