import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'dart:math' as math;
import '../models/app_models.dart';
import '../constants/app_colors.dart';
import '../constants/app_dimensions.dart';
import '../constants/app_text_styles.dart';

class PatternMode extends StatefulWidget {
  const PatternMode({Key? key}) : super(key: key);

  @override
  State<PatternMode> createState() => _PatternModeState();
}

class _PatternModeState extends State<PatternMode>
    with SingleTickerProviderStateMixin {
  late AnimationController _networkController;

  final List<Pattern> patterns = [
    Pattern(
      name: "Nocturnal Thought Cascade",
      risk: RiskLevel.critical,
      frequency: "Every 3.2 days",
      trigger: "Social comparison + isolation + screen time >2hrs",
      signature: "Begins 22:00-01:00. Catastrophic thinking. Dopamine seeking. Self-blame loop.",
      interventions: "Detected 47 times. Success rate of early intervention: 73%.",
      connections: ["Withdrawal Mode", "Sleep Debt Accumulator"],
    ),
    Pattern(
      name: "Overdrive → Burnout Cycle",
      risk: RiskLevel.high,
      frequency: "Every 2-3 weeks",
      trigger: "New project excitement + validation seeking",
      signature: "3 days hyperfocus (productivity +240%) → crash → 2-day recovery fog.",
      interventions: "Predicted 89% of occurrences. Mitigation protocols available.",
      connections: ["Perfectionist Override", "Day 3 Crash"],
    ),
    Pattern(
      name: "Withdrawal Shield Protocol",
      risk: RiskLevel.medium,
      frequency: "Variable (stress-dependent)",
      trigger: "Perceived disappointment + fear of judgment",
      signature: "Social retreat. Communication reduction. Internal rumination spike.",
      interventions: "Usually resolves in 36-48hrs. Watch for compounding with other patterns.",
      connections: ["Nocturnal Thought Cascade"],
    ),
    Pattern(
      name: "Morning Clarity Window",
      risk: RiskLevel.positive,
      frequency: "Daily (conditions permitting)",
      trigger: "Quality sleep + morning light + low stress",
      signature: "Problem-solving peak. Creative synthesis. Emotional stability.",
      interventions: "Maximize this window. Block 07:00-10:00 for deep work.",
      connections: ["Flow State Attractor"],
    ),
  ];

  @override
  void initState() {
    super.initState();
    _networkController = AnimationController(
      duration: const Duration(seconds: 6),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _networkController.dispose();
    super.dispose();
  }

  Color _getRiskColor(RiskLevel risk) {
    switch (risk) {
      case RiskLevel.critical:
        return AppColors.rose500;
      case RiskLevel.high:
        return AppColors.amber500;
      case RiskLevel.medium:
        return AppColors.yellow500;
      case RiskLevel.positive:
        return AppColors.emerald500;
      default:
        return AppColors.cyan500;
    }
  }

  String _getRiskLabel(RiskLevel risk) {
    switch (risk) {
      case RiskLevel.critical:
        return "CRITICAL";
      case RiskLevel.high:
        return "HIGH";
      case RiskLevel.medium:
        return "MEDIUM";
      case RiskLevel.positive:
        return "POSITIVE";
      default:
        return "UNKNOWN";
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppDimensions.paddingM),
      child: Column(
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'BEHAVIORAL ARCHITECTURE',
                style: AppTextStyles.header2.copyWith(
                  color: AppColors.cyan400,
                  letterSpacing: 1.0,
                ),
              ),
              RichText(
                text: TextSpan(
                  style: AppTextStyles.caption,
                  children: [
                    TextSpan(
                      text: '847',
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.cyan400,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const TextSpan(
                      text: ' PATTERNS MAPPED',
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: AppDimensions.paddingL),

          // Network topology visualization
          _buildNetworkVisualization(),

          const SizedBox(height: AppDimensions.paddingL),

          // Pattern cards
          ...patterns.asMap().entries.map((entry) {
            final index = entry.key;
            final pattern = entry.value;
            return _buildPatternCard(pattern, index);
          }),
        ],
      ),
    );
  }

  Widget _buildNetworkVisualization() {
    return Container(
      height: 180,
      decoration: BoxDecoration(
        color: AppColors.black.withOpacity(0.4),
        border: Border.all(
          color: AppColors.cyan400.withOpacity(0.2),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(AppDimensions.radiusXL),
      ),
      child: Stack(
        children: [
          // Network visualization
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _networkController,
              builder: (context, child) {
                return CustomPaint(
                  painter: NetworkTopologyPainter(
                    animation: _networkController.value,
                  ),
                );
              },
            ),
          ),
          
          // Center label
          const Center(
            child: Text(
              'INTERCONNECTED SYSTEM TOPOLOGY',
              style: TextStyle(
                fontSize: 10,
                color: AppColors.cyan400,
                letterSpacing: 2.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPatternCard(Pattern pattern, int index) {
    final riskColor = _getRiskColor(pattern.risk);
    final riskLabel = _getRiskLabel(pattern.risk);
    
    return Padding(
      padding: const EdgeInsets.only(bottom: AppDimensions.paddingM),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              riskColor.withOpacity(0.2),
              riskColor.withOpacity(0.1),
            ],
          ),
          border: Border.all(
            color: riskColor.withOpacity(0.5),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(AppDimensions.radiusXL),
        ),
        child: Stack(
          children: [
            // Background pattern
            Positioned.fill(
              child: CustomPaint(
                painter: PatternBackgroundPainter(),
              ),
            ),

            // Content
            Padding(
              padding: const EdgeInsets.all(AppDimensions.paddingM),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              pattern.name,
                              style: AppTextStyles.header2.copyWith(
                                color: AppColors.white90,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              pattern.frequency,
                              style: AppTextStyles.caption.copyWith(
                                color: AppColors.white50,
                                letterSpacing: 1.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppDimensions.paddingS,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: riskColor.withOpacity(0.2),
                          border: Border.all(
                            color: riskColor,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(AppDimensions.radiusS),
                        ),
                        child: Text(
                          riskLabel,
                          style: AppTextStyles.captionWide.copyWith(
                            color: riskColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: AppDimensions.paddingM),

                  // Details sections
                  _buildDetailSection('TRIGGER', pattern.trigger),
                  const SizedBox(height: AppDimensions.paddingS),
                  _buildDetailSection('SIGNATURE', pattern.signature),
                  const SizedBox(height: AppDimensions.paddingS),
                  _buildDetailSection('INTERVENTIONS', pattern.interventions),

                  // Pattern connections
                  if (pattern.connections.isNotEmpty) ...[
                    const SizedBox(height: AppDimensions.paddingM),
                    const Divider(color: AppColors.white10),
                    const SizedBox(height: AppDimensions.paddingS),
                    
                    Text(
                      'CONNECTED TO',
                      style: AppTextStyles.captionWide.copyWith(
                        color: AppColors.white50,
                      ),
                    ),
                    const SizedBox(height: AppDimensions.paddingXS),
                    
                    Wrap(
                      spacing: AppDimensions.paddingXS,
                      runSpacing: AppDimensions.paddingXS,
                      children: pattern.connections.map((connection) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppDimensions.paddingS,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.white10,
                            border: Border.all(
                              color: AppColors.white20,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(AppDimensions.radiusS),
                          ),
                          child: Text(
                            connection,
                            style: AppTextStyles.captionWide.copyWith(
                              color: AppColors.white70,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ).animate()
        .fadeIn(
          duration: 600.ms,
          delay: (index * 200).ms,
        )
        .slideX(
          begin: -0.3,
          end: 0,
          duration: 500.ms,
          delay: (index * 200).ms,
          curve: Curves.easeOut,
        ),
    );
  }

  Widget _buildDetailSection(String label, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.captionWide.copyWith(
            color: AppColors.white50,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          content,
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.white80,
            height: 1.4,
          ),
        ),
      ],
    );
  }
}

class NetworkTopologyPainter extends CustomPainter {
  final double animation;

  NetworkTopologyPainter({required this.animation});

  @override
  void paint(Canvas canvas, Size size) {
    final connectionPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5;
    
    final nodePaint = Paint()..style = PaintingStyle.fill;

    // Draw connection web
    for (int i = 0; i < 60; i++) {
      final x1 = math.Random(i).nextDouble() * size.width;
      final y1 = math.Random(i + 100).nextDouble() * size.height;
      final x2 = math.Random(i + 200).nextDouble() * size.width;
      final y2 = math.Random(i + 300).nextDouble() * size.height;
      
      final phase = math.sin(animation * math.pi * 2 + i * 0.1);
      final opacity = 0.1 + 0.2 * (phase + 1) / 2;
      
      connectionPaint.color = AppColors.emerald400.withOpacity(opacity);
      
      canvas.drawLine(
        Offset(x1, y1),
        Offset(x2, y2),
        connectionPaint,
      );
    }

    // Draw node clusters
    for (int i = 0; i < 25; i++) {
      final x = 20 + math.Random(i + 500).nextDouble() * (size.width - 40);
      final y = 20 + math.Random(i + 600).nextDouble() * (size.height - 40);
      
      final phase = math.sin(animation * math.pi * 2 + i * 0.2);
      final radius = 2 + 3 * (phase + 1) / 2;
      final opacity = 0.3 + 0.3 * (phase + 1) / 2;
      
      nodePaint.color = AppColors.emerald400.withOpacity(opacity);
      
      canvas.drawCircle(Offset(x, y), radius, nodePaint);
    }
  }

  @override
  bool shouldRepaint(NetworkTopologyPainter oldDelegate) {
    return animation != oldDelegate.animation;
  }
}

class PatternBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = AppColors.white.withOpacity(0.05);

    const dotSize = 0.5;
    const spacing = 15.0;
    
    for (double x = 0; x <= size.width; x += spacing) {
      for (double y = 0; y <= size.height; y += spacing) {
        canvas.drawCircle(
          Offset(x, y),
          dotSize,
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(PatternBackgroundPainter oldDelegate) => false;
}
