import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'dart:math' as math;
import '../models/app_models.dart';
import '../constants/app_colors.dart';
import '../constants/app_dimensions.dart';
import '../constants/app_text_styles.dart';

class MemoryMode extends StatefulWidget {
  const MemoryMode({Key? key}) : super(key: key);

  @override
  State<MemoryMode> createState() => _MemoryModeState();
}

class _MemoryModeState extends State<MemoryMode>
    with SingleTickerProviderStateMixin {
  late AnimationController _timelineController;

  final List<MemoryEvent> memories = [
    MemoryEvent(
      date: "Nov 17, 2025 - 14:23",
      type: RiskLevel.critical,
      score: "+8",
      summary: "Breakthrough realization about relationship patterns. Dopamine spike detected. Neural encoding strength: 94%.",
      details: "Cross-referenced with 47 historical moments. Pattern match with Jan 2024 insight. Consolidating into long-term predictive model.",
    ),
    MemoryEvent(
      date: "Nov 16, 2025 - 22:47",
      type: RiskLevel.high,
      score: "-4",
      summary: "Late-night spiral initiated. Catastrophic thinking loop detected. Cortisol elevation confirmed.",
      details: "Triggered by social media exposure. Identical signature to 12 previous episodes. Intervention protocol: activated.",
    ),
    MemoryEvent(
      date: "Nov 15, 2025 - 09:15",
      type: RiskLevel.positive,
      score: "+6",
      summary: "Morning clarity surge. Problem-solving capacity at 127% baseline. Creative synthesis active.",
      details: "Sleep quality: 89%. Correlated with exercise +18hrs prior. Predictive boost for next 48hrs.",
    ),
    MemoryEvent(
      date: "Nov 14, 2025 - 18:30",
      type: RiskLevel.medium,
      score: "+2",
      summary: "Standard cognitive baseline. Social interaction: positive. Energy stable.",
      details: "No significant deviations. Background pattern reinforcement ongoing.",
    ),
    MemoryEvent(
      date: "Nov 13, 2025 - 03:12",
      type: RiskLevel.critical,
      score: "-7",
      summary: "Insomnia-driven existential cascade. Identity questioning at crisis levels.",
      details: "Duration: 2hr 47min. Recovery time: 14hrs. Adding to vulnerability index.",
    ),
  ];

  @override
  void initState() {
    super.initState();
    _timelineController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _timelineController.dispose();
    super.dispose();
  }

  Color _getTypeColor(RiskLevel type) {
    switch (type) {
      case RiskLevel.critical:
        return AppColors.rose400;
      case RiskLevel.high:
        return AppColors.amber400;
      case RiskLevel.positive:
        return AppColors.emerald400;
      case RiskLevel.medium:
        return AppColors.cyan400;
      default:
        return AppColors.white50;
    }
  }

  String _getTypeLabel(RiskLevel type) {
    switch (type) {
      case RiskLevel.critical:
        return "CRITICAL";
      case RiskLevel.high:
        return "WARNING";
      case RiskLevel.positive:
        return "POSITIVE";
      case RiskLevel.medium:
        return "NEUTRAL";
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
                'DEEP MEMORY ARCHIVE',
                style: AppTextStyles.header2.copyWith(
                  color: AppColors.emerald400,
                  letterSpacing: 1.0,
                ),
              ),
              RichText(
                text: TextSpan(
                  style: AppTextStyles.caption,
                  children: [
                    TextSpan(
                      text: '2,847',
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.emerald400,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const TextSpan(
                      text: ' EVENTS INDEXED',
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: AppDimensions.paddingL),

          // Neural timeline visualization
          _buildTimelineVisualization(),

          const SizedBox(height: AppDimensions.paddingL),

          // Memory cards
          ...memories.asMap().entries.map((entry) {
            final index = entry.key;
            final memory = entry.value;
            return _buildMemoryCard(memory, index);
          }),
        ],
      ),
    );
  }

  Widget _buildTimelineVisualization() {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        color: AppColors.black.withOpacity(0.4),
        border: Border.all(
          color: AppColors.white10,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(AppDimensions.radiusXL),
      ),
      child: AnimatedBuilder(
        animation: _timelineController,
        builder: (context, child) {
          return CustomPaint(
            painter: TimelinePainter(
              animation: _timelineController.value,
              memories: memories,
            ),
          );
        },
      ),
    );
  }

  Widget _buildMemoryCard(MemoryEvent memory, int index) {
    final typeColor = _getTypeColor(memory.type);
    final typeLabel = _getTypeLabel(memory.type);
    
    return Padding(
      padding: const EdgeInsets.only(bottom: AppDimensions.paddingM),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white.withOpacity(0.05),
          border: Border.all(
            color: AppColors.white10,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(AppDimensions.radiusXL),
        ),
        child: Stack(
          children: [
            // Background texture
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppDimensions.radiusXL),
                ),
                child: CustomPaint(
                  painter: CardTexturePainter(),
                ),
              ),
            ),

            // Content
            Padding(
              padding: const EdgeInsets.all(AppDimensions.paddingM),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              memory.date,
                              style: AppTextStyles.caption.copyWith(
                                color: AppColors.white50,
                                letterSpacing: 1.0,
                              ),
                            ),
                            const SizedBox(height: AppDimensions.paddingXS),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: AppDimensions.paddingS,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: typeColor.withOpacity(0.1),
                                border: Border.all(
                                  color: typeColor.withOpacity(0.3),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(AppDimensions.radiusS),
                              ),
                              child: Text(
                                typeLabel,
                                style: AppTextStyles.captionWide.copyWith(
                                  color: typeColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      Text(
                        memory.score,
                        style: AppTextStyles.header1.copyWith(
                          color: memory.score.startsWith('+')
                              ? AppColors.emerald400
                              : AppColors.rose400,
                          fontSize: 28,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: AppDimensions.paddingS),

                  // Summary
                  Text(
                    memory.summary,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.white90,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  const SizedBox(height: AppDimensions.paddingS),

                  // Details
                  Text(
                    memory.details,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.white60,
                      height: 1.4,
                    ),
                  ),

                  const SizedBox(height: AppDimensions.paddingM),

                  // Neural encoding bar
                  _buildEncodingBar(),
                ],
              ),
            ),
          ],
        ),
      ).animate()
        .fadeIn(
          duration: 600.ms,
          delay: (index * 150).ms,
        )
        .slideX(
          begin: -0.2,
          end: 0,
          duration: 400.ms,
          delay: (index * 150).ms,
          curve: Curves.easeOut,
        ),
    );
  }

  Widget _buildEncodingBar() {
    final encodingStrength = 60 + math.Random().nextDouble() * 40;
    
    return Row(
      children: [
        Text(
          'ENCODING',
          style: AppTextStyles.captionWide.copyWith(
            color: AppColors.white40,
          ),
        ),
        const SizedBox(width: AppDimensions.paddingS),
        Expanded(
          child: Container(
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.white10,
              borderRadius: BorderRadius.circular(2),
            ),
            child: FractionallySizedBox(
              widthFactor: encodingStrength / 100,
              alignment: Alignment.centerLeft,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.emerald400,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class TimelinePainter extends CustomPainter {
  final double animation;
  final List<MemoryEvent> memories;

  TimelinePainter({
    required this.animation,
    required this.memories,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    // Draw animated timeline curve
    final path = Path();
    path.moveTo(20, size.height * 0.5);
    
    for (int i = 0; i <= 100; i++) {
      final x = (size.width - 40) * (i / 100) + 20;
      final baseY = size.height * 0.5;
      final waveOffset = math.sin((i / 100) * math.pi * 4 + animation * math.pi * 2) * 20;
      final y = baseY + waveOffset;
      
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    // Create gradient effect
    final gradient = LinearGradient(
      colors: [
        AppColors.emerald500.withOpacity(0.2),
        AppColors.emerald500.withOpacity(0.6),
        AppColors.emerald500.withOpacity(0.2),
      ],
    );

    paint.shader = gradient.createShader(Rect.fromLTWH(0, 0, size.width, size.height));
    canvas.drawPath(path, paint);

    // Draw event markers
    final nodePaint = Paint()..style = PaintingStyle.fill;
    
    for (int i = 0; i < memories.length && i < 5; i++) {
      final x = 50 + i * ((size.width - 100) / 4);
      final baseY = size.height * 0.5;
      final waveOffset = math.sin((i / 4) * math.pi * 4 + animation * math.pi * 2) * 20;
      final y = baseY + waveOffset;
      
      final pulsePhase = math.sin(animation * math.pi * 2 + i * 0.5);
      final opacity = 0.6 + 0.3 * pulsePhase;
      final radius = 4 + 2 * pulsePhase;
      
      nodePaint.color = AppColors.emerald400.withOpacity(opacity);
      canvas.drawCircle(Offset(x, y), radius, nodePaint);
    }
  }

  @override
  bool shouldRepaint(TimelinePainter oldDelegate) {
    return animation != oldDelegate.animation;
  }
}

class CardTexturePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = AppColors.emerald500.withOpacity(0.03);

    const dotSize = 1.0;
    const spacing = 20.0;
    
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
  bool shouldRepaint(CardTexturePainter oldDelegate) => false;
}
