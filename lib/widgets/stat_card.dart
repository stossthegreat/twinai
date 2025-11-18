import 'package:flutter/material.dart';
import '../models/app_models.dart';
import '../constants/app_colors.dart';
import '../constants/app_dimensions.dart';
import '../constants/app_text_styles.dart';

class StatCardWidget extends StatefulWidget {
  final StatCard statCard;

  const StatCardWidget({
    Key? key,
    required this.statCard,
  }) : super(key: key);

  @override
  State<StatCardWidget> createState() => _StatCardWidgetState();
}

class _StatCardWidgetState extends State<StatCardWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  Color get borderColor {
    switch (widget.statCard.color) {
      case RiskLevel.critical:
        return AppColors.rose400;
      case RiskLevel.high:
        return AppColors.amber400;
      case RiskLevel.medium:
        return AppColors.yellow400;
      case RiskLevel.positive:
        return AppColors.emerald400;
      case RiskLevel.opportunity:
        return AppColors.emerald400;
      case RiskLevel.criticalDecision:
        return AppColors.purple400;
    }
  }

  Color get textColor {
    switch (widget.statCard.color) {
      case RiskLevel.critical:
        return AppColors.rose400;
      case RiskLevel.high:
        return AppColors.amber400;
      case RiskLevel.medium:
        return AppColors.yellow400;
      case RiskLevel.positive:
        return AppColors.emerald400;
      case RiskLevel.opportunity:
        return AppColors.emerald400;
      case RiskLevel.criticalDecision:
        return AppColors.purple400;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _pulseController,
      builder: (context, child) {
        return Container(
          padding: const EdgeInsets.all(AppDimensions.paddingS),
          decoration: BoxDecoration(
            color: AppColors.white.withOpacity(0.05),
            border: Border.all(
              color: borderColor.withOpacity(0.3),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(AppDimensions.radiusM),
            boxShadow: [
              BoxShadow(
                color: borderColor.withOpacity(
                  0.1 * (0.5 + 0.5 * _pulseController.value)
                ),
                blurRadius: 8,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.statCard.label,
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.white50,
                  letterSpacing: 1.0,
                ),
              ),
              const SizedBox(height: AppDimensions.paddingXS),
              Text(
                widget.statCard.value,
                style: AppTextStyles.header2.copyWith(
                  color: textColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
