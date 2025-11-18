import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../constants/app_colors.dart';

class CustomHeader extends StatefulWidget {
  final double cognitiveLoad;
  final String systemStatus;
  final String systemMode;
  final double neuralActivity;
  final double emotionalValence;
  final double consciousnessDepth;
  final bool showGlitch;
  final VoidCallback? onSettingsTap;

  const CustomHeader({
    super.key,
    required this.cognitiveLoad,
    required this.systemStatus,
    required this.systemMode,
    required this.neuralActivity,
    required this.emotionalValence,
    required this.consciousnessDepth,
    this.showGlitch = false,
    this.onSettingsTap,
  });

  @override
  State<CustomHeader> createState() => _CustomHeaderState();
}

class _CustomHeaderState extends State<CustomHeader>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _consciousnessController;
  late AnimationController _glitchController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat(reverse: true);

    _consciousnessController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();

    _glitchController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void didUpdateWidget(CustomHeader oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.showGlitch && !oldWidget.showGlitch) {
      _glitchController.forward().then((_) => _glitchController.reverse());
    }
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _consciousnessController.dispose();
    _glitchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final modeColor = AppColors.getSystemModeColor(widget.systemMode);
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColors.white10,
            width: 1,
          ),
        ),
        color: Colors.black,
      ),
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Main title row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // TWIN OS Title
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        // Glitch text effect
                        Stack(
                          children: [
                            Text(
                              'TWIN OS',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: 0.5,
                              ),
                            ),
                            if (widget.showGlitch)
                              AnimatedBuilder(
                                animation: _glitchController,
                                builder: (context, child) {
                                  return Transform.translate(
                                    offset: Offset(
                                      (math.Random().nextDouble() - 0.5) * 4 * _glitchController.value,
                                      (math.Random().nextDouble() - 0.5) * 2 * _glitchController.value,
                                    ),
                                    child: Text(
                                      'TWIN OS',
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                  );
                                },
                              ),
                          ],
                        ),
                        const SizedBox(width: 12),
                        // Status indicator with consciousness ripple
                        AnimatedBuilder(
                          animation: _pulseController,
                          builder: (context, child) {
                            return Stack(
                              alignment: Alignment.center,
                              children: [
                                // Consciousness ripple
                                AnimatedBuilder(
                                  animation: _consciousnessController,
                                  builder: (context, child) {
                                    return Container(
                                      width: 24 + (16 * _consciousnessController.value),
                                      height: 24 + (16 * _consciousnessController.value),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: modeColor.withOpacity(
                                            0.4 * (1 - _consciousnessController.value)
                                          ),
                                          width: 2,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                // Pulse ring
                                Container(
                                  width: 24 + (6 * _pulseController.value),
                                  height: 24 + (6 * _pulseController.value),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: AppColors.white40,
                                      width: 1,
                                    ),
                                  ),
                                ),
                                // Core
                                Container(
                                  width: 24,
                                  height: 24,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: modeColor,
                                    boxShadow: [
                                      BoxShadow(
                                        color: modeColor.withOpacity(0.8),
                                        blurRadius: 30,
                                        spreadRadius: 12,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'neural singularity v4.7 • consciousness depth: layer ${widget.consciousnessDepth.floor()}',
                      style: TextStyle(
                        fontSize: 9,
                        color: AppColors.emerald400.withOpacity(0.8),
                        letterSpacing: 3.2,
                        fontWeight: FontWeight.w500,
                      ).copyWith(
                        fontFeatures: [const FontFeature.tabularFigures()],
                      ),
                    ),
                  ],
                ),
                
                // System State section (RIGHT SIDE) - ENHANCED VISIBILITY
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'SYSTEM STATE',
                      style: TextStyle(
                        fontSize: 11,
                        color: AppColors.white60,
                        letterSpacing: 1.8,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.systemStatus,
                      style: TextStyle(
                        fontSize: 16,
                        color: modeColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: modeColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: modeColor.withOpacity(0.4), width: 1),
                      ),
                      child: Text(
                        widget.systemMode,
                        style: TextStyle(
                          fontSize: 10,
                          color: modeColor,
                          letterSpacing: 2.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            
            const SizedBox(height: 12),
            
            // Four metrics grid (PROPERLY SPACED)
            Row(
              children: [
                Expanded(child: _buildMetric("COGNITIVE\nLOAD", widget.cognitiveLoad, "%", _getCognitiveLoadColor())),
                const SizedBox(width: 12),
                Expanded(child: _buildMetric("NEURAL\nACTIVITY", widget.neuralActivity, "%", AppColors.cyan400)),
                const SizedBox(width: 12),
                Expanded(child: _buildMetric("EMOTIONAL\nVALENCE", widget.emotionalValence, "", _getEmotionalValenceColor())),
                const SizedBox(width: 12),
                Expanded(child: _buildMetric("CONSCIOUSNESS", widget.consciousnessDepth / 7 * 100, "L${widget.consciousnessDepth.floor()}/7", AppColors.purple400)),
              ],
            ),
            
            const SizedBox(height: 12),
            
            // Bottom stats row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    _buildBottomStat("UPTIME: 847h 23m"),
                    const SizedBox(width: 16),
                    _buildBottomStat("PATTERNS TRACKED: 12,847"),
                    const SizedBox(width: 16),
                    _buildBottomStat("PREDICTIONS: 2,143"),
                  ],
                ),
                Text(
                  'QUANTUM SYNC: ACTIVE',
                  style: TextStyle(
                    fontSize: 8,
                    color: AppColors.emerald400.withOpacity(0.6),
                    letterSpacing: 1.0,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetric(String label, double value, String suffix, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 8,
                    color: AppColors.white45,
                    letterSpacing: 0.5,
                    fontWeight: FontWeight.w500,
                    height: 1.2,
                  ),
                ),
              ),
              Text(
                value == widget.emotionalValence
                    ? "${value > 0 ? "+" : ""}${value.toStringAsFixed(1)}"
                    : suffix.startsWith("L")
                        ? suffix
                        : "${value.round()}$suffix",
                style: TextStyle(
                  fontSize: 9,
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Container(
            height: 6,
            decoration: BoxDecoration(
              color: AppColors.white10,
              borderRadius: BorderRadius.circular(3),
            ),
            child: Stack(
              children: [
                if (value == widget.emotionalValence)
                  // Emotional valence special bar (centered)
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 6,
                          decoration: BoxDecoration(
                            color: AppColors.white10,
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                      ),
                    ],
                  ),
                if (value == widget.emotionalValence)
                  // Center line for emotional valence
                  Positioned.fill(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 0.5,
                          height: 6,
                          color: AppColors.white30,
                        ),
                      ],
                    ),
                  ),
                if (value == widget.emotionalValence)
                  // Emotional valence bar
                  Positioned.fill(
                    child: Row(
                      mainAxisAlignment: widget.emotionalValence >= 0 ? MainAxisAlignment.center : MainAxisAlignment.center,
                      children: [
                        if (widget.emotionalValence >= 0)
                          Container(
                            width: (MediaQuery.of(context).size.width / 4 - 30) * (widget.emotionalValence.abs() / 10) * 0.5,
                            height: 6,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Colors.transparent, AppColors.emerald400],
                              ),
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                        if (widget.emotionalValence < 0)
                          Container(
                            width: (MediaQuery.of(context).size.width / 4 - 30) * (widget.emotionalValence.abs() / 10) * 0.5,
                            height: 6,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [AppColors.rose400, Colors.transparent],
                              ),
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                      ],
                    ),
                  ),
                if (value != widget.emotionalValence)
                  // Regular progress bar
                  FractionallySizedBox(
                    widthFactor: (value / 100).clamp(0.0, 1.0),
                    child: Container(
                      height: 6,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: value == widget.consciousnessDepth / 7 * 100
                              ? [AppColors.purple500, AppColors.pink500]
                              : value == widget.neuralActivity
                                  ? [AppColors.cyan400, AppColors.blue500]
                                  : [AppColors.emerald400, AppColors.cyan400, AppColors.rose400],
                        ),
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getCognitiveLoadColor() {
    if (widget.cognitiveLoad > 85) return AppColors.rose400;
    if (widget.cognitiveLoad > 65) return AppColors.amber400;
    return AppColors.emerald400;
  }

  Color _getEmotionalValenceColor() {
    if (widget.emotionalValence > 3) return AppColors.emerald400;
    if (widget.emotionalValence < -3) return AppColors.rose400;
    return AppColors.slate400;
  }

  Widget _buildBottomStat(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 8,
        color: AppColors.white35,
        letterSpacing: 0.5,
      ),
    );
  }
}