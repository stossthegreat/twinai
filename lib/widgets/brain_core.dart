import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';

class BrainCore extends StatefulWidget {
  final double size;

  const BrainCore({
    Key? key,
    this.size = 300,
  }) : super(key: key);

  @override
  State<BrainCore> createState() => _BrainCoreState();
}

class _BrainCoreState extends State<BrainCore>
    with TickerProviderStateMixin {
  late AnimationController _ringController;
  late AnimationController _neuralController;
  late AnimationController _coreController;
  
  int frame = 0;

  @override
  void initState() {
    super.initState();
    
    _ringController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat();
    
    _neuralController = AnimationController(
      duration: const Duration(seconds: 6),
      vsync: this,
    )..repeat();
    
    _coreController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();

    // Frame counter for complex animations
    _ringController.addListener(() {
      setState(() {
        frame++;
      });
    });
  }

  @override
  void dispose() {
    _ringController.dispose();
    _neuralController.dispose();
    _coreController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.size,
      height: widget.size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Main neural network visualization
          AnimatedBuilder(
            animation: Listenable.merge([
              _ringController,
              _neuralController,
              _coreController,
            ]),
            builder: (context, child) {
              return CustomPaint(
                size: Size(widget.size, widget.size),
                painter: NeuralNetworkPainter(
                  ringAnimation: _ringController.value,
                  neuralAnimation: _neuralController.value,
                  coreAnimation: _coreController.value,
                  frame: frame,
                ),
              );
            },
          ),
          
          // Radial gradient overlay for depth
          Container(
            width: widget.size,
            height: widget.size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  Colors.transparent,
                  Colors.transparent,
                  AppColors.black.withOpacity(0.5),
                ],
                stops: const [0.0, 0.7, 1.0],
              ),
            ),
          ),
          
          // Floating data streams
          const Positioned(
            right: -30,
            top: 50,
            child: FloatingDataStream(),
          ),
        ],
      ),
    );
  }
}

class NeuralNetworkPainter extends CustomPainter {
  final double ringAnimation;
  final double neuralAnimation;
  final double coreAnimation;
  final int frame;

  NeuralNetworkPainter({
    required this.ringAnimation,
    required this.neuralAnimation,
    required this.coreAnimation,
    required this.frame,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final baseRadius = size.width / 8;
    
    // Draw pulsing rings
    _drawPulsingRings(canvas, center, baseRadius);
    
    // Draw neural connections
    _drawNeuralConnections(canvas, center, baseRadius);
    
    // Draw central core
    _drawCentralCore(canvas, center, baseRadius);
  }

  void _drawPulsingRings(Canvas canvas, Offset center, double baseRadius) {
    final ringPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    for (int i = 0; i < 12; i++) {
      final radiusOffset = math.sin(frame * 0.02 + i * 0.3) * 5;
      final radius = baseRadius + i * 12 + radiusOffset;
      final alpha = (0.4 - i * 0.03).clamp(0.0, 1.0);
      
      ringPaint.color = AppColors.emerald500.withOpacity(alpha);
      
      canvas.drawCircle(center, radius, ringPaint);
    }
  }

  void _drawNeuralConnections(Canvas canvas, Offset center, double baseRadius) {
    final nodePaint = Paint()..style = PaintingStyle.fill;
    final connectionPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5;

    const nodeCount = 20;
    final connectionRadius = baseRadius * 2.5;
    
    for (int i = 0; i < nodeCount; i++) {
      final angle = (math.pi * 2 * i) / nodeCount + frame * 0.01;
      final x = center.dx + math.cos(angle) * connectionRadius;
      final y = center.dy + math.sin(angle) * connectionRadius;
      final nodePos = Offset(x, y);
      
      final pulsePhase = math.sin(frame * 0.05 + i);
      final nodeAlpha = 0.6 + pulsePhase * 0.3;
      final nodeSize = 2.0 + pulsePhase * 1.0;
      
      // Draw connection line to center
      final connectionAlpha = 0.1 + math.sin(frame * 0.03 + i) * 0.1;
      connectionPaint.color = AppColors.emerald500.withOpacity(connectionAlpha);
      canvas.drawLine(center, nodePos, connectionPaint);
      
      // Draw node
      nodePaint.color = AppColors.emerald400.withOpacity(nodeAlpha);
      canvas.drawCircle(nodePos, nodeSize, nodePaint);
      
      // Draw connections between nearby nodes
      for (int j = i + 1; j < i + 4 && j < nodeCount; j++) {
        final nextAngle = (math.pi * 2 * j) / nodeCount + frame * 0.01;
        final nextX = center.dx + math.cos(nextAngle) * connectionRadius;
        final nextY = center.dy + math.sin(nextAngle) * connectionRadius;
        final nextNodePos = Offset(nextX, nextY);
        
        final connectionAlpha2 = 0.05 + math.sin(frame * 0.02 + i + j) * 0.05;
        connectionPaint.color = AppColors.cyan400.withOpacity(connectionAlpha2);
        canvas.drawLine(nodePos, nextNodePos, connectionPaint);
      }
    }
  }

  void _drawCentralCore(Canvas canvas, Offset center, double baseRadius) {
    final corePaint = Paint()..style = PaintingStyle.fill;
    
    // Pulsing core size
    final coreSize = baseRadius * 0.6 + math.sin(frame * 0.05) * 3;
    
    // Draw outer core glow
    for (int i = 0; i < 3; i++) {
      final glowRadius = coreSize + (i * 4);
      final glowAlpha = 0.3 - (i * 0.1);
      corePaint.color = AppColors.emerald400.withOpacity(glowAlpha);
      canvas.drawCircle(center, glowRadius, corePaint);
    }
    
    // Draw main core
    corePaint.color = AppColors.emerald400.withOpacity(0.8);
    canvas.drawCircle(center, coreSize, corePaint);
    
    // Draw core highlight
    final highlightPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = AppColors.white.withOpacity(0.3);
    canvas.drawCircle(
      Offset(center.dx - coreSize * 0.3, center.dy - coreSize * 0.3),
      coreSize * 0.3,
      highlightPaint,
    );
  }

  @override
  bool shouldRepaint(NeuralNetworkPainter oldDelegate) {
    return ringAnimation != oldDelegate.ringAnimation ||
        neuralAnimation != oldDelegate.neuralAnimation ||
        coreAnimation != oldDelegate.coreAnimation ||
        frame != oldDelegate.frame;
  }
}

class FloatingDataStream extends StatefulWidget {
  const FloatingDataStream({Key? key}) : super(key: key);

  @override
  State<FloatingDataStream> createState() => _FloatingDataStreamState();
}

class _FloatingDataStreamState extends State<FloatingDataStream>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  List<String> dataPoints = ['λ 0.847293', 'Ψ 94.7%', 'Δt 2.3ms'];

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
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: dataPoints.asMap().entries.map((entry) {
            final index = entry.key;
            final data = entry.value;
            final phase = (_controller.value + index * 0.3) % 1.0;
            final opacity = 0.3 + 0.3 * math.sin(phase * math.pi * 2);
            
            return Padding(
              padding: const EdgeInsets.only(bottom: 2),
              child: Text(
                data,
                style: AppTextStyles.mono.copyWith(
                  fontSize: 9,
                  color: AppColors.emerald400.withOpacity(opacity),
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
