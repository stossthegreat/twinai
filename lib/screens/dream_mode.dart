import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../constants/app_colors.dart';
import '../data/app_content.dart';
import '../models/app_models.dart';

class DreamMode extends StatefulWidget {
  final String mode;

  const DreamMode({
    super.key,
    this.mode = "CALM",
  });

  @override
  State<DreamMode> createState() => _DreamModeState();
}

class _DreamModeState extends State<DreamMode>
    with SingleTickerProviderStateMixin {
  late AnimationController _floatController;

  @override
  void initState() {
    super.initState();
    _floatController = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _floatController.dispose();
    super.dispose();
  }

  Color get headlineColor {
    switch (widget.mode) {
      case 'TRANSCENDENT':
        return AppColors.purple400;
      case 'DANGER':
        return AppColors.rose400;
      default:
        return AppColors.indigo500;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        spacing: 24,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Subconscious Archive',
                    style: TextStyle(
                      fontSize: 10,
                      color: AppColors.white40,
                      letterSpacing: 2.8,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'DREAM INTERPRETATION ENGINE',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: headlineColor,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Text(
                        '847',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: AppColors.purple300,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'DREAMS',
                        style: TextStyle(
                          fontSize: 10,
                          color: AppColors.white50,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'DECODED & MAPPED',
                    style: TextStyle(
                      fontSize: 9,
                      color: AppColors.white40,
                      letterSpacing: 1.0,
                    ),
                  ),
                ],
              ),
            ],
          ),

          // Dream frequency visualization
          DreamFrequencyMap(floatController: _floatController),

          // Dream decoding protocol info
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.purple500.withValues(alpha: 0.15),
                  AppColors.indigo500.withValues(alpha: 0.15),
                  AppColors.pink500.withValues(alpha: 0.15),
                ],
              ),
              border: Border.all(
                color: AppColors.purple400.withValues(alpha: 0.4),
                width: 2,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Text(
                  '🌙',
                  style: TextStyle(fontSize: 24),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'DREAM DECODING PROTOCOL',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColors.purple200,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Your dreams are not random. They\'re your subconscious processing unresolved patterns, rehearsing futures, and integrating shadow material. Every symbol is data. Every emotion is signal. This archive tracks recurring themes and predicts consciousness shifts before your waking mind registers them.',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.white80,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Dreams list
          ...AppContent.dreams.map((dream) => DreamCard(dream: dream)),

          // Lucid dreaming protocol
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.indigo500.withValues(alpha: 0.2),
                  AppColors.purple500.withValues(alpha: 0.2),
                  AppColors.pink500.withValues(alpha: 0.2),
                ],
              ),
              border: Border.all(
                color: AppColors.indigo500.withValues(alpha: 0.5),
                width: 2,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Text(
                  '✨',
                  style: TextStyle(fontSize: 24),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'LUCID DREAMING PROTOCOL',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColors.indigo200,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Your lucid dream frequency is 2.3x above baseline. This indicates high meta-cognitive awareness and reality-testing skills. Consider: your waking life might also benefit from "lucidity checks." Are you making conscious choices or running autopilot? The line between dream and reality is thinner than you think.',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.white80,
                          height: 1.5,
                        ),
                      ),
                    ],
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

class DreamFrequencyMap extends StatelessWidget {
  final AnimationController floatController;

  const DreamFrequencyMap({
    super.key,
    required this.floatController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 192,
      decoration: BoxDecoration(
        color: AppColors.black70,
        border: Border.all(
          color: AppColors.purple400.withValues(alpha: 0.3),
          width: 2,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: Stack(
          children: [
            // Floating dream orbs
            AnimatedBuilder(
              animation: floatController,
              builder: (context, child) {
                return Stack(
                  children: List.generate(50, (i) {
                    final x = (i * 31.7) % 100;
                    final phase = (floatController.value + i * 0.02) % 1.0;
                    final float = math.sin(phase * math.pi * 2) * 20;
                    final opacity = 0.2 + (math.sin(phase * math.pi * 2) * 0.2);
                    
                    return Positioned(
                      left: (MediaQuery.of(context).size.width - 32) * x / 100,
                      top: 96 + float + (i % 3) * 30,
                      child: Container(
                        width: 64,
                        height: 64,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: RadialGradient(
                            colors: [
                              AppColors.purple500.withValues(alpha: 0.4 * opacity),
                              AppColors.pink500.withValues(alpha: 0.4 * opacity),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                );
              },
            ),
            
            // Center text
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Dream Frequency Map',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.purple200.withValues(alpha: 0.9),
                      letterSpacing: 3.0,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Subconscious pattern visualization active',
                    style: TextStyle(
                      fontSize: 10,
                      color: AppColors.white50,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DreamCard extends StatelessWidget {
  final Dream dream;

  const DreamCard({
    super.key,
    required this.dream,
  });

  Color get typeColor {
    switch (dream.type) {
      case "RECURRING":
        return AppColors.amber400;
      case "PROPHETIC":
        return AppColors.purple400;
      case "SHADOW":
        return AppColors.slate400;
      case "LUCID":
        return AppColors.cyan400;
      default:
        return AppColors.emerald400;
    }
  }

  String get typeGradient {
    switch (dream.type) {
      case "RECURRING":
        return "amber-orange";
      case "PROPHETIC":
        return "purple-pink";
      case "SHADOW":
        return "slate-gray";
      case "LUCID":
        return "cyan-blue";
      default:
        return "emerald-green";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: _getTypeGradient(),
        border: Border.all(
          color: typeColor.withValues(alpha: 0.7),
          width: 2,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      dream.date,
                      style: TextStyle(
                        fontSize: 10,
                        color: AppColors.white60,
                        letterSpacing: 1.0,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      dream.title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.white95,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.white50,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                        color: AppColors.black40,
                      ),
                      child: Text(
                        dream.type,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Intensity meter
              Column(
                children: [
                  Text(
                    'INTENSITY',
                    style: TextStyle(
                      fontSize: 9,
                      color: AppColors.white50,
                      letterSpacing: 1.0,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: List.generate(10, (i) {
                      return Container(
                        margin: const EdgeInsets.only(right: 2),
                        width: 6,
                        height: 12,
                        decoration: BoxDecoration(
                          color: i < dream.intensity.floor()
                              ? typeColor
                              : AppColors.white20,
                          borderRadius: BorderRadius.circular(1),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${dream.intensity}/10',
                    style: TextStyle(
                      fontSize: 10,
                      color: typeColor,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'monospace',
                    ),
                  ),
                ],
              ),
            ],
          ),

          // Dream narrative
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.black40,
              border: Border.all(
                color: AppColors.white20,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '◈ DREAM NARRATIVE',
                  style: TextStyle(
                    fontSize: 10,
                    color: AppColors.indigo300,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  dream.narrative,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.white90,
                    height: 1.5,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),

          // Symbols and emotional signature
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '🔮 SYMBOL DECODE',
                      style: TextStyle(
                        fontSize: 10,
                        color: AppColors.white60,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ...dream.symbols.map((symbol) => Container(
                      margin: const EdgeInsets.only(bottom: 6),
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.purple500.withValues(alpha: 0.1),
                        border: Border.all(
                          color: AppColors.purple400.withValues(alpha: 0.3),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        symbol,
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.purple200.withValues(alpha: 0.9),
                        ),
                      ),
                    )),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '💫 EMOTIONAL SIGNATURE',
                      style: TextStyle(
                        fontSize: 10,
                        color: AppColors.white60,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.pink500.withValues(alpha: 0.1),
                        border: Border.all(
                          color: AppColors.pink400.withValues(alpha: 0.3),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        dream.emotionalSignature,
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.pink200.withValues(alpha: 0.9),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Interpretation
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '🧠 INTERPRETATION',
                style: TextStyle(
                  fontSize: 10,
                  color: AppColors.cyan300,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                dream.interpretation,
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.white85,
                  height: 1.5,
                ),
              ),
            ],
          ),

          // Connected patterns
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '🔗 CONNECTED PATTERNS',
                style: TextStyle(
                  fontSize: 10,
                  color: AppColors.white60,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: dream.connections.map((connection) => Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.black40,
                    border: Border.all(
                      color: AppColors.white30,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    connection,
                    style: TextStyle(
                      fontSize: 10,
                      color: AppColors.white90,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )).toList(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  LinearGradient _getTypeGradient() {
    switch (dream.type) {
      case "RECURRING":
        return LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.amber500.withValues(alpha: 0.25),
            AppColors.orange500.withValues(alpha: 0.15),
          ],
        );
      case "PROPHETIC":
        return LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.purple500.withValues(alpha: 0.25),
            AppColors.pink500.withValues(alpha: 0.15),
          ],
        );
      case "SHADOW":
        return LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.slate500.withValues(alpha: 0.25),
            AppColors.slate400.withValues(alpha: 0.15),
          ],
        );
      case "LUCID":
        return LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.cyan500.withValues(alpha: 0.25),
            AppColors.blue500.withValues(alpha: 0.15),
          ],
        );
      default:
        return LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.emerald500.withValues(alpha: 0.25),
            AppColors.green500.withValues(alpha: 0.15),
          ],
        );
    }
  }
}
