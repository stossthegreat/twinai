import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../constants/app_colors.dart';
import '../constants/app_dimensions.dart';
import '../constants/app_text_styles.dart';

class ScannerOverlay extends StatefulWidget {
  final bool isScanning;

  const ScannerOverlay({
    super.key,
    required this.isScanning,
  });

  @override
  State<ScannerOverlay> createState() => _ScannerOverlayState();
}

class _ScannerOverlayState extends State<ScannerOverlay>
    with TickerProviderStateMixin {
  late AnimationController _scanLineController;
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _scanLineController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    if (widget.isScanning) {
      _startScanning();
    }
  }

  @override
  void didUpdateWidget(ScannerOverlay oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isScanning != oldWidget.isScanning) {
      if (widget.isScanning) {
        _startScanning();
      } else {
        _stopScanning();
      }
    }
  }

  void _startScanning() {
    _scanLineController.repeat();
    _pulseController.repeat();
  }

  void _stopScanning() {
    _scanLineController.stop();
    _pulseController.stop();
  }

  @override
  void dispose() {
    _scanLineController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isScanning) {
      return const SizedBox.shrink();
    }

    return Positioned.fill(
      child: Stack(
        children: [
          // Background overlay
          AnimatedBuilder(
            animation: _pulseController,
            builder: (context, child) {
              return Container(
                decoration: BoxDecoration(
                  color: AppColors.emerald500.withOpacity(
                    0.05 * (0.5 + 0.5 * _pulseController.value)
                  ),
                ),
              );
            },
          ),

          // Top scan line
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AnimatedBuilder(
              animation: _pulseController,
              builder: (context, child) {
                return Container(
                  height: 1,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        AppColors.emerald400.withOpacity(
                          0.8 * (0.3 + 0.7 * _pulseController.value)
                        ),
                        Colors.transparent,
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // Moving scan line
          AnimatedBuilder(
            animation: _scanLineController,
            builder: (context, child) {
              return Positioned(
                top: MediaQuery.of(context).size.height * 0.5,
                left: 0,
                right: 0,
                child: Transform.translate(
                  offset: Offset(
                    0,
                    (MediaQuery.of(context).size.height * 0.4) * 
                    (2 * _scanLineController.value - 1),
                  ),
                  child: Container(
                    height: 2,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          AppColors.emerald400.withOpacity( 0.8),
                          AppColors.cyan400.withOpacity( 0.6),
                          AppColors.emerald400.withOpacity( 0.8),
                          Colors.transparent,
                        ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.emerald400.withOpacity( 0.3),
                          blurRadius: 10,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),

          // Status indicator
          Positioned(
            top: AppDimensions.paddingM,
            right: AppDimensions.paddingM,
            child: AnimatedBuilder(
              animation: _pulseController,
              builder: (context, child) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimensions.paddingM,
                    vertical: AppDimensions.paddingS,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.black80,
                    border: Border.all(
                      color: AppColors.emerald400.withOpacity( 0.5),
                    ),
                    borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.emerald400,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.emerald400.withOpacity(
                                0.6 * (0.3 + 0.7 * _pulseController.value)
                              ),
                              blurRadius: 8,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: AppDimensions.paddingS),
                      Text(
                        '⚡ DEEP SCAN ACTIVE',
                        style: AppTextStyles.captionWide.copyWith(
                          color: AppColors.emerald400,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          // Scan grid overlay
          const ScanGridOverlay(),
        ],
      ),
    );
  }
}

class ScanGridOverlay extends StatefulWidget {
  const ScanGridOverlay({super.key});

  @override
  State<ScanGridOverlay> createState() => _ScanGridOverlayState();
}

class _ScanGridOverlayState extends State<ScanGridOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return CustomPaint(
            painter: ScanGridPainter(animation: _controller.value),
          );
        },
      ),
    );
  }
}

class ScanGridPainter extends CustomPainter {
  final double animation;

  ScanGridPainter({required this.animation});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5;

    const gridSize = 60.0;
    final phase = animation * 2 * 3.14159;
    
    // Animated grid lines
    for (double x = 0; x <= size.width; x += gridSize) {
      for (double y = 0; y <= size.height; y += gridSize) {
        final distance = (x + y) / (size.width + size.height);
        final opacity = 0.1 + 0.05 * (1 + math.sin(phase + distance * 10)) / 2;
        
        paint.color = AppColors.emerald400.withOpacity( opacity);
        
        if (x < size.width) {
          canvas.drawLine(
            Offset(x, y),
            Offset(x + gridSize, y),
            paint,
          );
        }
        
        if (y < size.height) {
          canvas.drawLine(
            Offset(x, y),
            Offset(x, y + gridSize),
            paint,
          );
        }
      }
    }
  }

  @override
  bool shouldRepaint(ScanGridPainter oldDelegate) {
    return animation != oldDelegate.animation;
  }
}