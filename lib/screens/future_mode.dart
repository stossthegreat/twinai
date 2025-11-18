import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'dart:math' as math;
import '../models/app_models.dart';
import '../constants/app_colors.dart';
import '../constants/app_dimensions.dart';
import '../constants/app_text_styles.dart';

class FutureMode extends StatefulWidget {
  const FutureMode({Key? key}) : super(key: key);

  @override
  State<FutureMode> createState() => _FutureModeState();
}

class _FutureModeState extends State<FutureMode>
    with SingleTickerProviderStateMixin {
  late AnimationController _timelineController;

  final List<Prediction> predictions = [
    Prediction(
      timeframe: "NEXT 48 HOURS",
      risk: RiskLevel.critical,
      probability: "87%",
      event: "Emotional Impulse Window",
      description: "Your behavioral vector is identical to the signature preceding your last 4 major impulsive decisions. Neural stress markers elevated. Sleep debt accumulating.",
      triggers: [
        "Social media exposure after 21:00",
        "Perceived rejection or comparison",
        "Isolation + rumination time"
      ],
      outcomes: [
        "LIKELY: Regrettable text message or purchase (73%)",
        "POSSIBLE: Social withdrawal initiation (41%)",
        "SEVERE: Relationship-damaging action (12%)"
      ],
      intervention: "IMMEDIATE: Limit phone access 20:00-08:00. Schedule social connection. Physical activity within 6 hours.",
      confidence: 0.87,
    ),
    Prediction(
      timeframe: "5-7 DAYS",
      risk: RiskLevel.high,
      probability: "79%",
      event: "Burnout Collapse Trajectory",
      description: "Current productivity spike (+240% baseline) is unsustainable. Pattern recognition shows 89% historical accuracy for subsequent crash.",
      triggers: [
        "Continued hyperfocus without breaks",
        "Perfectionist override active",
        "Sleep quality degradation"
      ],
      outcomes: [
        "LIKELY: 2-3 day productivity collapse (79%)",
        "POSSIBLE: Guilt spiral → depression episode (44%)",
        "SEVERE: Project abandonment (18%)"
      ],
      intervention: "RECOMMENDED: Force rest days on Day 3 and Day 5. Cap work at 6hrs/day. Social buffer activities.",
      confidence: 0.79,
    ),
    Prediction(
      timeframe: "10-14 DAYS",
      risk: RiskLevel.medium,
      probability: "62%",
      event: "Relationship Tension Escalation",
      description: "Micro-withdrawal patterns detected. Communication frequency down 31%. Emotional availability decreasing. Classic precursor to conflict.",
      triggers: [
        "Unspoken expectations accumulating",
        "Internal narrative diverging from reality",
        "Avoidance of vulnerability"
      ],
      outcomes: [
        "LIKELY: Uncomfortable but necessary conversation (62%)",
        "POSSIBLE: Resentment crystallization (28%)",
        "POSITIVE: Breakthrough intimacy if addressed early (45%)"
      ],
      intervention: "PROACTIVE: Schedule dedicated connection time. Express needs directly. Reality-test assumptions.",
      confidence: 0.62,
    ),
    Prediction(
      timeframe: "30 DAYS",
      risk: RiskLevel.opportunity,
      probability: "71%",
      event: "Creative Breakthrough Window",
      description: "Convergence of multiple positive factors. Your cognitive cycles, project maturation, and environmental conditions align for major insight.",
      triggers: [
        "Post-burnout clarity phase",
        "Accumulated subconscious processing",
        "Reduced external pressure"
      ],
      outcomes: [
        "LIKELY: Novel solution to persistent problem (71%)",
        "POSSIBLE: Career-shifting realization (34%)",
        "TRANSFORMATIVE: Identity evolution catalyst (19%)"
      ],
      intervention: "MAXIMIZE: Protect unstructured thinking time. Journal daily. Expose yourself to novel inputs.",
      confidence: 0.71,
    ),
    Prediction(
      timeframe: "90 DAYS",
      risk: RiskLevel.criticalDecision,
      probability: "94%",
      event: "Major Life Crossroads",
      description: "Multiple trajectory lines converge. Historical pattern analysis shows 94% probability of significant life decision point. Your subconscious is already preparing.",
      triggers: [
        "Accumulated dissatisfaction reaching threshold",
        "External opportunity emergence",
        "Internal values-reality misalignment"
      ],
      outcomes: [
        "TRANSFORMATIVE: Career or relationship pivot (58%)",
        "EVOLUTION: Major identity shift (72%)",
        "REGRESSION: Fear-based decision → regret (23%)"
      ],
      intervention: "PREPARE NOW: Clarify values. Build financial buffer. Strengthen support network. Document decision criteria.",
      confidence: 0.94,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _timelineController = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _timelineController.dispose();
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
      case RiskLevel.opportunity:
        return AppColors.emerald500;
      case RiskLevel.criticalDecision:
        return AppColors.purple500;
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
      case RiskLevel.opportunity:
        return "OPPORTUNITY";
      case RiskLevel.criticalDecision:
        return "CRITICAL DECISION";
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
                'TEMPORAL PREDICTION ENGINE',
                style: AppTextStyles.header2.copyWith(
                  color: AppColors.rose400,
                  letterSpacing: 1.0,
                ),
              ),
              RichText(
                text: TextSpan(
                  style: AppTextStyles.caption,
                  children: [
                    TextSpan(
                      text: '94.7%',
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.rose400,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const TextSpan(
                      text: ' ACCURACY',
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: AppDimensions.paddingL),

          // Future timeline visualization
          _buildTimelineVisualization(),

          const SizedBox(height: AppDimensions.paddingL),

          // Prediction cards
          ...predictions.asMap().entries.map((entry) {
            final index = entry.key;
            final prediction = entry.value;
            return _buildPredictionCard(prediction, index);
          }),

          const SizedBox(height: AppDimensions.paddingL),

          // Final warning
          _buildFinalWarning(),
        ],
      ),
    );
  }

  Widget _buildTimelineVisualization() {
    return Container(
      height: 220,
      decoration: BoxDecoration(
        color: AppColors.black.withOpacity(0.4),
        border: Border.all(
          color: AppColors.rose400.withOpacity(0.2),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(AppDimensions.radiusXL),
      ),
      padding: const EdgeInsets.all(AppDimensions.paddingM),
      child: Stack(
        children: [
          // Branching timeline visualization
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _timelineController,
              builder: (context, child) {
                return CustomPaint(
                  painter: BranchingTimelinePainter(
                    animation: _timelineController.value,
                    predictions: predictions,
                  ),
                );
              },
            ),
          ),
          
          // Timeline info
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'PROBABILITY MANIFOLD',
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.rose400,
                  letterSpacing: 1.0,
                ),
              ),
              const SizedBox(height: AppDimensions.paddingS),
              Text(
                'Analyzing 2.1M data points across temporal dimensions.\nFive critical nexus points detected in your timeline.\nIntervention windows identified.',
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.white50,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPredictionCard(Prediction prediction, int index) {
    final riskColor = _getRiskColor(prediction.risk);
    final riskLabel = _getRiskLabel(prediction.risk);
    
    return Padding(
      padding: const EdgeInsets.only(bottom: AppDimensions.paddingM),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              riskColor.withOpacity(0.3),
              riskColor.withOpacity(0.1),
            ],
          ),
          border: Border.all(
            color: riskColor,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(AppDimensions.radiusXL),
        ),
        child: Stack(
          children: [
            // Animated background
            Positioned.fill(
              child: AnimatedBuilder(
                animation: _timelineController,
                builder: (context, child) {
                  return CustomPaint(
                    painter: PredictionCardPainter(
                      animation: _timelineController.value + index * 0.2,
                    ),
                  );
                },
              ),
            ),

            // Content
            Padding(
              padding: const EdgeInsets.all(AppDimensions.paddingL),
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
                              prediction.timeframe,
                              style: AppTextStyles.captionWide.copyWith(
                                color: AppColors.white50,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              prediction.event,
                              style: AppTextStyles.header2.copyWith(
                                color: AppColors.white90,
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            prediction.probability,
                            style: AppTextStyles.header1.copyWith(
                              color: AppColors.rose400,
                              fontSize: 36,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppDimensions.paddingS,
                              vertical: 2,
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
                    ],
                  ),

                  const SizedBox(height: AppDimensions.paddingM),

                  // Description
                  Text(
                    prediction.description,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.white80,
                      height: 1.4,
                    ),
                  ),

                  const SizedBox(height: AppDimensions.paddingM),

                  // Triggers
                  _buildPredictionSection('⚡ TRIGGER VECTORS', prediction.triggers),

                  const SizedBox(height: AppDimensions.paddingM),

                  // Outcomes
                  _buildPredictionSection('📊 PROJECTED OUTCOMES', prediction.outcomes),

                  const SizedBox(height: AppDimensions.paddingM),

                  // Intervention
                  const Divider(color: AppColors.white20),
                  const SizedBox(height: AppDimensions.paddingM),
                  
                  Text(
                    '🎯 INTERVENTION PROTOCOL',
                    style: AppTextStyles.captionWide.copyWith(
                      color: AppColors.emerald400,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: AppDimensions.paddingS),
                  
                  Container(
                    padding: const EdgeInsets.all(AppDimensions.paddingM),
                    decoration: BoxDecoration(
                      color: AppColors.emerald500.withOpacity(0.1),
                      border: Border.all(
                        color: AppColors.emerald500.withOpacity(0.3),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                    ),
                    child: Text(
                      prediction.intervention,
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.white90,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ).animate()
        .fadeIn(
          duration: 800.ms,
          delay: (index * 300).ms,
        )
        .slideY(
          begin: 0.3,
          end: 0,
          duration: 600.ms,
          delay: (index * 300).ms,
          curve: Curves.easeOut,
        ),
    );
  }

  Widget _buildPredictionSection(String title, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.captionWide.copyWith(
            color: AppColors.white50,
          ),
        ),
        const SizedBox(height: AppDimensions.paddingS),
        
        ...items.map((item) {
          return Padding(
            padding: const EdgeInsets.only(bottom: AppDimensions.paddingXS),
            child: title.contains('OUTCOMES')
                ? Container(
                    padding: const EdgeInsets.all(AppDimensions.paddingS),
                    decoration: BoxDecoration(
                      color: AppColors.black.withOpacity(0.3),
                      border: Border.all(
                        color: AppColors.white10,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(AppDimensions.radiusS),
                    ),
                    child: Text(
                      item,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.white80,
                        height: 1.3,
                      ),
                    ),
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '◆',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.rose400,
                        ),
                      ),
                      const SizedBox(width: AppDimensions.paddingS),
                      Expanded(
                        child: Text(
                          item,
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.white70,
                            height: 1.3,
                          ),
                        ),
                      ),
                    ],
                  ),
          );
        }),
      ],
    );
  }

  Widget _buildFinalWarning() {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.paddingM),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.rose500.withOpacity(0.2),
            AppColors.purple500.withOpacity(0.2),
            AppColors.rose500.withOpacity(0.2),
          ],
        ),
        border: Border.all(
          color: AppColors.rose500.withOpacity(0.5),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(AppDimensions.radiusXL),
      ),
      child: Stack(
        children: [
          // Animated background
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _timelineController,
              builder: (context, child) {
                return Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Colors.transparent,
                        AppColors.white.withOpacity(
                          0.05 * (0.5 + 0.5 * math.sin(_timelineController.value * math.pi * 2))
                        ),
                        Colors.transparent,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(AppDimensions.radiusXL),
                  ),
                );
              },
            ),
          ),
          
          // Content
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.white90,
                height: 1.4,
              ),
              children: [
                TextSpan(
                  text: '⚠ TEMPORAL CERTAINTY: ',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.rose400,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const TextSpan(
                  text: 'The future is not fixed, but your patterns are predictable. These projections have ',
                ),
                TextSpan(
                  text: '94.7% historical accuracy',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.emerald400,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const TextSpan(
                  text: '. Early intervention dramatically alters outcomes. ',
                ),
                TextSpan(
                  text: 'You are not your patterns—but ignoring them is.',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.purple400,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BranchingTimelinePainter extends CustomPainter {
  final double animation;
  final List<Prediction> predictions;

  BranchingTimelinePainter({
    required this.animation,
    required this.predictions,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    // Draw branching timeline paths
    final paths = [
      _createPath(size, 0.3, AppColors.rose500),
      _createPath(size, 0.5, AppColors.amber500),
      _createPath(size, 0.7, AppColors.emerald500),
    ];

    for (int i = 0; i < paths.length; i++) {
      final pathData = paths[i];
      final phase = animation + i * 0.3;
      final opacity = 0.4 + 0.3 * math.sin(phase * math.pi * 2);
      
      paint.color = pathData['color'].withOpacity(opacity);
      canvas.drawPath(pathData['path'], paint);
    }

    // Draw prediction nodes
    final nodePaint = Paint()..style = PaintingStyle.fill;
    
    for (int i = 0; i < 5 && i < predictions.length; i++) {
      final x = 50 + i * ((size.width - 100) / 4);
      final y = size.height * 0.5 + math.sin(i * 0.8 + animation * math.pi) * 40;
      
      final pulsePhase = math.sin(animation * math.pi * 2 + i * 0.5);
      final radius = 4 + 2 * (pulsePhase + 1) / 2;
      final opacity = 0.6 + 0.2 * (pulsePhase + 1) / 2;
      
      nodePaint.color = AppColors.rose400.withOpacity(opacity);
      canvas.drawCircle(Offset(x, y), radius, nodePaint);
    }
  }

  Map<String, dynamic> _createPath(Size size, double verticalOffset, Color color) {
    final path = Path();
    path.moveTo(50, size.height * verticalOffset);
    
    // Create branching curve
    for (int i = 0; i <= 100; i++) {
      final progress = i / 100;
      final x = 50 + progress * (size.width - 100);
      final baseY = size.height * verticalOffset;
      final waveOffset = math.sin(progress * math.pi * 2) * 30 * progress;
      final y = baseY + waveOffset;
      
      path.lineTo(x, y);
    }
    
    return {
      'path': path,
      'color': color,
    };
  }

  @override
  bool shouldRepaint(BranchingTimelinePainter oldDelegate) {
    return animation != oldDelegate.animation;
  }
}

class PredictionCardPainter extends CustomPainter {
  final double animation;

  PredictionCardPainter({required this.animation});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = AppColors.white.withOpacity(0.03);

    const spacing = 20.0;
    
    for (double x = 0; x <= size.width; x += spacing) {
      for (double y = 0; y <= size.height; y += spacing) {
        final phase = animation + (x + y) / 100;
        final opacity = 0.02 + 0.03 * math.sin(phase * math.pi);
        
        paint.color = AppColors.white.withOpacity(opacity);
        canvas.drawCircle(Offset(x, y), 0.5, paint);
      }
    }
  }

  @override
  bool shouldRepaint(PredictionCardPainter oldDelegate) {
    return animation != oldDelegate.animation;
  }
}
