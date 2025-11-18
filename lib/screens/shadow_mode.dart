import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../constants/app_colors.dart';
import '../data/app_content.dart';
import '../models/app_models.dart';

class ShadowMode extends StatefulWidget {
  final String mode;

  const ShadowMode({
    super.key,
    this.mode = "CALM",
  });

  @override
  State<ShadowMode> createState() => _ShadowModeState();
}

class _ShadowModeState extends State<ShadowMode>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(seconds: 6),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  Color get headlineColor {
    switch (widget.mode) {
      case 'DANGER':
        return AppColors.red400;
      case 'WITHDRAWAL':
        return AppColors.slate400;
      default:
        return AppColors.slate300;
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
                    'Shadow Integration System',
                    style: TextStyle(
                      fontSize: 10,
                      color: AppColors.white40,
                      letterSpacing: 2.8,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'DISOWNED SELF ARCHIVE',
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
                        '6',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: AppColors.red300,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'ACTIVE SHADOWS',
                        style: TextStyle(
                          fontSize: 10,
                          color: AppColors.white50,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'MAPPED & TRACKING',
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

          // What is shadow work explanation
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.red500.withOpacity(alpha: 0.2),
                  AppColors.slate500.withOpacity(alpha: 0.2),
                  AppColors.amber500.withOpacity(alpha: 0.2),
                ],
              ),
              border: Border.all(
                color: AppColors.red400.withOpacity(alpha: 0.5),
                width: 2,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Text(
                  '⚫',
                  style: TextStyle(fontSize: 24),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'WHAT IS SHADOW WORK?',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColors.red200,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Your shadow is not your enemy. It\'s the collection of disowned parts of yourself—beliefs, behaviors, and voices you\'ve rejected because they didn\'t fit who you wanted to be. But they\'re still running in the background, sabotaging your plans. Integration means acknowledging them, understanding their protective function, and consciously choosing new patterns. You can\'t transcend what you refuse to see.',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.white80,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '⚠️ WARNING: These voices are loud right now. Awareness is the first step toward freedom.',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.red300,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Shadow activity map
          ShadowActivityMap(pulseController: _pulseController),

          // Shadows list
          ...AppContent.shadows.map((shadow) => ShadowCard(shadow: shadow)),

          // Integration practice
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.slate500.withOpacity(alpha: 0.2),
                  AppColors.purple500.withOpacity(alpha: 0.2),
                  AppColors.indigo500.withOpacity(alpha: 0.2),
                ],
              ),
              border: Border.all(
                color: AppColors.slate500.withOpacity(alpha: 0.5),
                width: 2,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      '🔮',
                      style: TextStyle(fontSize: 24),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'INTEGRATION PRACTICE',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: AppColors.slate200,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Shadow work isn\'t about eliminating these voices. It\'s about recognizing them as outdated protection mechanisms and choosing conscious responses instead. Each time you notice a shadow voice, you create space between stimulus and reaction. That space is where freedom lives.',
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
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.black40,
                          border: Border.all(
                            color: AppColors.emerald400.withOpacity(alpha: 0.4),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          children: [
                            Text(
                              'STEP 1: NOTICE',
                              style: TextStyle(
                                fontSize: 10,
                                color: AppColors.emerald300,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Catch the voice when it speaks',
                              style: TextStyle(
                                fontSize: 11,
                                color: AppColors.white80,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.black40,
                          border: Border.all(
                            color: AppColors.cyan400.withOpacity(alpha: 0.4),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          children: [
                            Text(
                              'STEP 2: NAME',
                              style: TextStyle(
                                fontSize: 10,
                                color: AppColors.cyan300,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Identify which shadow is active',
                              style: TextStyle(
                                fontSize: 11,
                                color: AppColors.white80,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.black40,
                          border: Border.all(
                            color: AppColors.purple400.withOpacity(alpha: 0.4),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          children: [
                            Text(
                              'STEP 3: CHOOSE',
                              style: TextStyle(
                                fontSize: 10,
                                color: AppColors.purple300,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Consciously select a new response',
                              style: TextStyle(
                                fontSize: 11,
                                color: AppColors.white80,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Critical shadow alert
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.red500.withOpacity(alpha: 0.25),
                  AppColors.amber500.withOpacity(alpha: 0.2),
                  AppColors.rose500.withOpacity(alpha: 0.25),
                ],
              ),
              border: Border.all(
                color: AppColors.red500.withOpacity(alpha: 0.6),
                width: 2,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Text(
                  '⚠️',
                  style: TextStyle(fontSize: 24),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'CRITICAL SHADOW ALERT',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColors.rose200,
                        ),
                      ),
                      const SizedBox(height: 8),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.white90,
                            height: 1.5,
                          ),
                          children: [
                            TextSpan(
                              text: 'The Perfectionist',
                              style: TextStyle(
                                color: AppColors.red300,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(text: ' and '),
                            TextSpan(
                              text: 'The Comparison Engine',
                              style: TextStyle(
                                color: AppColors.red300,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(text: ' are currently running at critical levels. These two shadows feed each other in a destructive loop: comparison triggers perfectionism, perfectionism prevents completion, incompletion fuels comparison. Break the cycle by shipping something imperfect in the next 24 hours. Small act, big signal to your nervous system.'),
                          ],
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

class ShadowActivityMap extends StatelessWidget {
  final AnimationController pulseController;

  const ShadowActivityMap({
    super.key,
    required this.pulseController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 208,
      decoration: BoxDecoration(
        color: AppColors.black70,
        border: Border.all(
          color: AppColors.slate400.withOpacity(0.3),
          width: 2,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: Stack(
          children: [
            // Animated shadow orbs
            AnimatedBuilder(
              animation: pulseController,
              builder: (context, child) {
                return Stack(
                  children: List.generate(40, (i) {
                    final x = (i * 23.7) % 100;
                    final y = (i * 31.3) % 100;
                    final phase = (pulseController.value + i * 0.03) % 1.0;
                    final pulse = 1.0 + math.sin(phase * math.pi * 2) * 0.05;
                    final opacity = 0.3 + math.sin(phase * math.pi * 2) * 0.5;
                    
                    return Positioned(
                      left: (MediaQuery.of(context).size.width - 32) * x / 100,
                      top: 20 + (208 - 80) * y / 100,
                      child: Transform.scale(
                        scale: pulse,
                        child: Container(
                          width: 40 + (math.Random().nextDouble() * 40),
                          height: 40 + (math.Random().nextDouble() * 40),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: RadialGradient(
                              colors: [
                                AppColors.slate500.withOpacity(alpha: 0.6 * opacity),
                                AppColors.red500.withOpacity(alpha: 0.6 * opacity),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                );
              },
            ),
            
            // Center text and stats
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Shadow Activity Map',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.slate200.withOpacity(alpha: 0.9),
                      letterSpacing: 3.0,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Real-time unconscious pattern detection',
                    style: TextStyle(
                      fontSize: 10,
                      color: AppColors.white50,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.red500,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'CRITICAL: 3',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.white60,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 16),
                      Row(
                        children: [
                          Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.amber500,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'ACTIVE: 3',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.white60,
                            ),
                          ),
                        ],
                      ),
                    ],
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

class ShadowCard extends StatelessWidget {
  final Shadow shadow;

  const ShadowCard({
    super.key,
    required this.shadow,
  });

  Color get typeColor {
    switch (shadow.type) {
      case "DESTRUCTIVE":
        return AppColors.red300;
      case "DEFENSIVE":
        return AppColors.amber300;
      case "ADAPTIVE":
        return AppColors.slate300;
      default:
        return AppColors.emerald300;
    }
  }

  LinearGradient get typeGradient {
    switch (shadow.type) {
      case "DESTRUCTIVE":
        return LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.red500.withOpacity(alpha: 0.25),
            AppColors.rose600.withOpacity(alpha: 0.15),
          ],
        );
      case "DEFENSIVE":
        return LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.amber500.withOpacity(alpha: 0.25),
            AppColors.orange500.withOpacity(alpha: 0.15),
          ],
        );
      case "ADAPTIVE":
        return LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.slate500.withOpacity(alpha: 0.25),
            AppColors.slate400.withOpacity(alpha: 0.15),
          ],
        );
      default:
        return LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.emerald500.withOpacity(alpha: 0.25),
            AppColors.green500.withOpacity(alpha: 0.15),
          ],
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: typeGradient,
        border: Border.all(
          color: typeColor.withOpacity(alpha: 0.7),
          width: 2,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                      shadow.name,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.white95,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
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
                            shadow.type,
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: typeColor,
                              letterSpacing: 1.0,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        // Intensity meter
                        Row(
                          children: [
                            Text(
                              'INTENSITY',
                              style: TextStyle(
                                fontSize: 9,
                                color: AppColors.white50,
                                letterSpacing: 1.0,
                              ),
                            ),
                            const SizedBox(width: 8),
                            ...List.generate(10, (i) {
                              return Container(
                                margin: const EdgeInsets.only(right: 2),
                                width: 6,
                                height: 12,
                                decoration: BoxDecoration(
                                  color: i < shadow.intensity.floor()
                                      ? AppColors.red400
                                      : AppColors.white20,
                                  borderRadius: BorderRadius.circular(1),
                                ),
                              );
                            }),
                            const SizedBox(width: 8),
                            Text(
                              '${shadow.intensity}/10',
                              style: TextStyle(
                                fontSize: 10,
                                color: AppColors.red300,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'monospace',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.red500.withOpacity(alpha: 0.2),
                        border: Border.all(
                          color: AppColors.red400.withOpacity(alpha: 0.4),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        shadow.activity,
                        style: TextStyle(
                          fontSize: 10,
                          color: AppColors.red200,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // The voice
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.black50,
              border: Border.all(
                color: AppColors.red400.withOpacity(alpha: 0.4),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '🗣️ THE VOICE',
                  style: TextStyle(
                    fontSize: 10,
                    color: AppColors.red300,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '"${shadow.voice}"',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.white90,
                    height: 1.5,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          // Details sections
          _buildSection("📍 ORIGIN STORY", shadow.origin, Colors.orange),
          _buildSection("⚙️ PROTECTIVE FUNCTION", shadow.function, Colors.blue),
          _buildSection("🌱 INTEGRATION PATH", shadow.integration, AppColors.emerald300),

          // Triggers
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '⚡ ACTIVATION TRIGGERS',
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
                children: shadow.triggers.map((trigger) => Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.amber500.withOpacity(alpha: 0.2),
                    border: Border.all(
                      color: AppColors.amber400.withOpacity(alpha: 0.4),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    trigger,
                    style: TextStyle(
                      fontSize: 10,
                      color: AppColors.amber200,
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

  Widget _buildSection(String title, String content, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 10,
            color: AppColors.white60,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.0,
          ),
        ),
        const SizedBox(height: 8),
        if (title.contains("INTEGRATION"))
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.emerald500.withOpacity(alpha: 0.1),
              border: Border.all(
                color: AppColors.emerald400.withOpacity(alpha: 0.3),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              content,
              style: TextStyle(
                fontSize: 14,
                color: AppColors.white90,
                height: 1.5,
              ),
            ),
          )
        else
          Text(
            content,
            style: TextStyle(
              fontSize: 14,
              color: AppColors.white85,
              height: 1.5,
            ),
          ),
      ],
    );
  }
}
