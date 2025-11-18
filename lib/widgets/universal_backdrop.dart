import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../constants/app_colors.dart';

class UniversalBackdrop extends StatefulWidget {
  final String mode;
  
  const UniversalBackdrop({Key? key, this.mode = "CALM"}) : super(key: key);

  @override
  State<UniversalBackdrop> createState() => _UniversalBackdropState();
}

class _UniversalBackdropState extends State<UniversalBackdrop>
    with TickerProviderStateMixin {
  late AnimationController _primaryController;
  late AnimationController _secondaryController;
  late AnimationController _tertiaryController;

  @override
  void initState() {
    super.initState();
    _primaryController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat(reverse: true);

    _secondaryController = AnimationController(
      duration: const Duration(seconds: 6),
      vsync: this,
    )..repeat(reverse: true);

    _tertiaryController = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _primaryController.dispose();
    _secondaryController.dispose();
    _tertiaryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final palette = AppColors.modePalettes[widget.mode] ?? AppColors.modePalettes['CALM']!;
    
    return Positioned.fill(
      child: Stack(
        children: [
          // Primary consciousness field
          AnimatedBuilder(
            animation: _primaryController,
            builder: (context, child) {
              return Positioned(
                top: MediaQuery.of(context).size.height * 0.5 - 600,
                left: MediaQuery.of(context).size.width * 0.5 - 600,
                child: Transform.scale(
                  scale: 0.94 + (_primaryController.value * 0.12),
                  child: Container(
                    width: 1200,
                    height: 1200,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          palette['main']!,
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),

          // Secondary neural flares
          AnimatedBuilder(
            animation: _secondaryController,
            builder: (context, child) {
              return Positioned(
                right: MediaQuery.of(context).size.width * 0.25,
                top: MediaQuery.of(context).size.height * 0.1,
                child: Transform.scale(
                  scale: 0.94 + (_secondaryController.value * 0.12),
                  child: Container(
                    width: 600,
                    height: 600,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          palette['secondary']!,
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),

          // Third orb
          AnimatedBuilder(
            animation: _tertiaryController,
            builder: (context, child) {
              return Positioned(
                left: -MediaQuery.of(context).size.width * 0.125,
                bottom: -MediaQuery.of(context).size.height * 0.125,
                child: Transform.scale(
                  scale: 0.94 + (_tertiaryController.value * 0.12),
                  child: Container(
                    width: 500,
                    height: 500,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          palette['tertiary']!,
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),

          // Fourth orb for more complexity
          AnimatedBuilder(
            animation: _primaryController,
            builder: (context, child) {
              return Positioned(
                top: MediaQuery.of(context).size.height * 0.33,
                right: MediaQuery.of(context).size.width * 0.33,
                child: Transform.scale(
                  scale: 0.94 + (math.sin(_primaryController.value * 2 * math.pi * 16) * 0.12),
                  child: Container(
                    width: 400,
                    height: 400,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          palette['main']!,
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),

          // Quantum particle field
          const QuantumParticleField(),

          // Data stream lines
          const DataStreamLines(),

          // Neural grid overlay
          const NeuralGridOverlay(),
        ],
      ),
    );
  }
}

class QuantumParticleField extends StatefulWidget {
  const QuantumParticleField({Key? key}) : super(key: key);

  @override
  State<QuantumParticleField> createState() => _QuantumParticleFieldState();
}

class _QuantumParticleFieldState extends State<QuantumParticleField>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  List<QuantumParticle> particles = [];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();

    // Generate 200 particles (matching React version)
    for (int i = 0; i < 200; i++) {
      particles.add(QuantumParticle.random());
    }
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
            painter: QuantumParticlePainter(
              particles: particles,
              animation: _controller.value,
            ),
          );
        },
      ),
    );
  }
}

class QuantumParticle {
  final double x;
  final double y;
  final double animationOffset;
  final double duration;

  QuantumParticle({
    required this.x,
    required this.y,
    required this.animationOffset,
    required this.duration,
  });

  factory QuantumParticle.random() {
    return QuantumParticle(
      x: math.Random().nextDouble(),
      y: math.Random().nextDouble(),
      animationOffset: math.Random().nextDouble() * 5,
      duration: 2 + math.Random().nextDouble() * 4,
    );
  }
}

class QuantumParticlePainter extends CustomPainter {
  final List<QuantumParticle> particles;
  final double animation;

  QuantumParticlePainter({
    required this.particles,
    required this.animation,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.emerald400.withOpacity(0.03)
      ..style = PaintingStyle.fill;

    for (final particle in particles) {
      final phase = (animation + particle.animationOffset) % 1.0;
      final opacity = (math.sin(phase * math.pi * 2) + 1) * 0.5;
      
      paint.color = AppColors.emerald400.withOpacity(0.03 * opacity);
      
      final x = particle.x * size.width;
      final y = particle.y * size.height;
      
      canvas.drawCircle(
        Offset(x, y),
        1.0 + (opacity * 2),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(QuantumParticlePainter oldDelegate) {
    return animation != oldDelegate.animation;
  }
}

class NeuralGridOverlay extends StatelessWidget {
  const NeuralGridOverlay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: CustomPaint(
        painter: NeuralGridPainter(),
      ),
    );
  }
}

class NeuralGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.emerald400.withOpacity(0.04)
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    const gridSize = 40.0;
    
    // Draw vertical lines
    for (double x = 0; x <= size.width; x += gridSize) {
      canvas.drawLine(
        Offset(x, 0),
        Offset(x, size.height),
        paint,
      );
    }
    
    // Draw horizontal lines
    for (double y = 0; y <= size.height; y += gridSize) {
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(NeuralGridPainter oldDelegate) => false;
}

class DataStreamLines extends StatefulWidget {
  const DataStreamLines({Key? key}) : super(key: key);

  @override
  State<DataStreamLines> createState() => _DataStreamLinesState();
}

class _DataStreamLinesState extends State<DataStreamLines>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<DataStream> streams = [];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat();

    // Generate 30 data streams
    for (int i = 0; i < 30; i++) {
      streams.add(DataStream.random());
    }
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
            painter: DataStreamPainter(
              streams: streams,
              animation: _controller.value,
            ),
          );
        },
      ),
    );
  }
}

class DataStream {
  final double position;
  final double animationOffset;

  DataStream({
    required this.position,
    required this.animationOffset,
  });

  factory DataStream.random() {
    return DataStream(
      position: math.Random().nextDouble(),
      animationOffset: math.Random().nextDouble() * 5,
    );
  }
}

class DataStreamPainter extends CustomPainter {
  final List<DataStream> streams;
  final double animation;

  DataStreamPainter({
    required this.streams,
    required this.animation,
  });

  @override
  void paint(Canvas canvas, Size size) {
    for (final stream in streams) {
      final phase = (animation + stream.animationOffset) % 1.0;
      final opacity = 0.3 + (math.sin(phase * math.pi * 2) * 0.7);
      
      final paint = Paint()
        ..color = AppColors.emerald400.withValues(alpha: 0.2 * opacity)
        ..strokeWidth = 1.0
        ..style = PaintingStyle.stroke;

      final gradient = LinearGradient(
        colors: [
          Colors.transparent,
          AppColors.emerald400.withValues(alpha: 0.2 * opacity),
          Colors.transparent,
        ],
        stops: const [0.0, 0.5, 1.0],
      );

      final rect = Rect.fromLTWH(0, stream.position * size.height, size.width, 1);
      paint.shader = gradient.createShader(rect);

      final yPos = stream.position * size.height;
      final xOffset = 4 * math.sin(phase * math.pi * 2);
      
      canvas.drawLine(
        Offset(xOffset, yPos),
        Offset(size.width + xOffset, yPos),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(DataStreamPainter oldDelegate) {
    return animation != oldDelegate.animation;
  }
}
