import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../constants/app_colors.dart';

class NeuralSphere3D extends StatefulWidget {
  final String mode;
  
  const NeuralSphere3D({
    super.key,
    this.mode = "CALM",
  });

  @override
  State<NeuralSphere3D> createState() => _NeuralSphere3DState();
}

class _NeuralSphere3DState extends State<NeuralSphere3D>
    with TickerProviderStateMixin {
  late AnimationController _rotationController;
  late AnimationController _pulseController;
  late AnimationController _innerRotationController;
  
  final List<NeuralPoint> _outerPoints = [];
  final List<NeuralPoint> _innerPoints = [];

  @override
  void initState() {
    super.initState();
    
    _rotationController = AnimationController(
      duration: const Duration(seconds: 100),
      vsync: this,
    )..repeat();

    _pulseController = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    )..repeat();

    _innerRotationController = AnimationController(
      duration: const Duration(seconds: 80),
      vsync: this,
    )..repeat(reverse: true);

    _generatePoints();
  }

  void _generatePoints() {
    // Generate outer sphere points (icosahedron-like distribution)
    _outerPoints.clear();
    for (int i = 0; i < 200; i++) {
      _outerPoints.add(NeuralPoint.random(1.6, i));
    }

    // Generate inner sphere points
    _innerPoints.clear();
    for (int i = 0; i < 100; i++) {
      _innerPoints.add(NeuralPoint.random(0.8, i));
    }
  }

  @override
  void dispose() {
    _rotationController.dispose();
    _pulseController.dispose();
    _innerRotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 340,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: AppColors.emerald400.withOpacity( 0.4),
          width: 2,
        ),
        color: AppColors.black80,
        boxShadow: [
          BoxShadow(
            color: AppColors.emerald400.withOpacity( 0.4),
            blurRadius: 80,
            spreadRadius: 4,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(22),
        child: AnimatedBuilder(
          animation: Listenable.merge([
            _rotationController,
            _pulseController,
            _innerRotationController,
          ]),
          builder: (context, child) {
            return CustomPaint(
              painter: NeuralSpherePainter(
                rotationAnimation: _rotationController.value,
                pulseAnimation: _pulseController.value,
                innerRotationAnimation: _innerRotationController.value,
                outerPoints: _outerPoints,
                innerPoints: _innerPoints,
                mode: widget.mode,
              ),
            );
          },
        ),
      ),
    );
  }
}

class NeuralPoint {
  final double x;
  final double y;
  final double z;
  final double animationOffset;
  final int index;

  NeuralPoint({
    required this.x,
    required this.y,
    required this.z,
    required this.animationOffset,
    required this.index,
  });

  factory NeuralPoint.random(double radius, int index) {
    // Generate points on sphere surface using spherical coordinates
    final theta = math.Random().nextDouble() * 2 * math.pi;
    final phi = math.acos(2 * math.Random().nextDouble() - 1);
    
    return NeuralPoint(
      x: radius * math.sin(phi) * math.cos(theta),
      y: radius * math.sin(phi) * math.sin(theta),
      z: radius * math.cos(phi),
      animationOffset: math.Random().nextDouble() * 5,
      index: index,
    );
  }

  NeuralPoint transform({
    required double rotationX,
    required double rotationY,
    required double rotationZ,
    required double noise,
  }) {
    // Apply rotations and noise distortion
    final cosX = math.cos(rotationX);
    final sinX = math.sin(rotationX);
    final cosY = math.cos(rotationY);
    final sinY = math.sin(rotationY);
    final cosZ = math.cos(rotationZ);
    final sinZ = math.sin(rotationZ);

    // Rotate around X axis
    final y1 = y * cosX - z * sinX;
    final z1 = y * sinX + z * cosX;

    // Rotate around Y axis
    final x2 = x * cosY + z1 * sinY;
    final z2 = -x * sinY + z1 * cosY;

    // Rotate around Z axis
    final x3 = x2 * cosZ - y1 * sinZ;
    final y3 = x2 * sinZ + y1 * cosZ;

    // Apply noise distortion
    final distortion = 1 + noise * 0.15;
    
    return NeuralPoint(
      x: x3 * distortion,
      y: y3 * distortion,
      z: z2 * distortion,
      animationOffset: animationOffset,
      index: index,
    );
  }
}

class NeuralSpherePainter extends CustomPainter {
  final double rotationAnimation;
  final double pulseAnimation;
  final double innerRotationAnimation;
  final List<NeuralPoint> outerPoints;
  final List<NeuralPoint> innerPoints;
  final String mode;

  NeuralSpherePainter({
    required this.rotationAnimation,
    required this.pulseAnimation,
    required this.innerRotationAnimation,
    required this.outerPoints,
    required this.innerPoints,
    required this.mode,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final scale = size.width * 0.2;

    // Mode-based parameters
    final twist = _getTwistForMode();
    final coreColor = _getCoreColorForMode();

    // Transform outer points
    final transformedOuter = outerPoints.map((point) {
      final phase = (rotationAnimation * 2.5 + point.animationOffset) % 1.0;
      final noise = math.sin(phase * math.pi * 2 + point.x * 5 + point.y * 5 + point.z * 5) * twist;
      final pulse = math.sin(rotationAnimation * 3 + point.index * 0.1) * 0.02;
      
      return point.transform(
        rotationX: rotationAnimation * 0.003,
        rotationY: rotationAnimation * 0.0015,
        rotationZ: 0,
        noise: noise + pulse,
      );
    }).toList();

    // Transform inner points
    final transformedInner = innerPoints.map((point) {
      return point.transform(
        rotationX: -innerRotationAnimation * 0.004,
        rotationY: innerRotationAnimation * 0.002,
        rotationZ: 0,
        noise: 0,
      );
    }).toList();

    // Draw connections between outer points
    _drawConnections(canvas, center, scale, transformedOuter, coreColor);

    // Draw outer points
    _drawPoints(canvas, center, scale, transformedOuter, coreColor, 1.5);

    // Draw inner wireframe sphere
    _drawInnerSphere(canvas, center, scale, transformedInner, coreColor);
  }

  void _drawConnections(Canvas canvas, Offset center, double scale, List<NeuralPoint> points, Color color) {
    final paint = Paint()
      ..color = color.withOpacity( 0.25)
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    for (int i = 0; i < points.length; i++) {
      final point1 = points[i];
      final point2 = points[(i + 1) % points.length];

      // Only draw connections for points that are reasonably close and visible
      final distance = math.sqrt(
        math.pow(point1.x - point2.x, 2) +
        math.pow(point1.y - point2.y, 2) +
        math.pow(point1.z - point2.z, 2)
      );

      if (distance < 0.8 && point1.z > -1 && point2.z > -1) {
        final offset1 = Offset(
          center.dx + point1.x * scale,
          center.dy + point1.y * scale,
        );
        final offset2 = Offset(
          center.dx + point2.x * scale,
          center.dy + point2.y * scale,
        );

        canvas.drawLine(offset1, offset2, paint);
      }
    }
  }

  void _drawPoints(Canvas canvas, Offset center, double scale, List<NeuralPoint> points, Color color, double size) {
    final paint = Paint()
      ..color = color.withOpacity( 0.95)
      ..style = PaintingStyle.fill;

    for (final point in points) {
      // Only draw points that are in front
      if (point.z > -1.5) {
        final opacity = (point.z + 1.5) / 3.0;
        paint.color = color.withOpacity( 0.95 * opacity);

        final offset = Offset(
          center.dx + point.x * scale,
          center.dy + point.y * scale,
        );

        canvas.drawCircle(offset, size, paint);
      }
    }
  }

  void _drawInnerSphere(Canvas canvas, Offset center, double scale, List<NeuralPoint> points, Color color) {
    final paint = Paint()
      ..color = color.withOpacity( 0.1)
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    // Draw wireframe connections
    for (int i = 0; i < points.length; i += 4) {
      for (int j = i + 1; j < math.min(i + 4, points.length); j++) {
        final point1 = points[i];
        final point2 = points[j];

        final offset1 = Offset(
          center.dx + point1.x * scale,
          center.dy + point1.y * scale,
        );
        final offset2 = Offset(
          center.dx + point2.x * scale,
          center.dy + point2.y * scale,
        );

        canvas.drawLine(offset1, offset2, paint);
      }
    }
  }

  double _getTwistForMode() {
    switch (mode) {
      case 'COLLAPSE':
        return 0.7;
      case 'DANGER':
        return 0.5;
      case 'HYPERFOCUS':
        return 0.35;
      case 'TRANSCENDENT':
        return 0.25;
      default:
        return 0.2;
    }
  }

  Color _getCoreColorForMode() {
    switch (mode) {
      case 'COLLAPSE':
        return AppColors.red500;
      case 'DANGER':
        return AppColors.rose400;
      case 'HYPERFOCUS':
        return AppColors.cyan400;
      case 'TRANSCENDENT':
        return AppColors.purple400;
      default:
        return AppColors.emerald400;
    }
  }

  @override
  bool shouldRepaint(NeuralSpherePainter oldDelegate) {
    return rotationAnimation != oldDelegate.rotationAnimation ||
           pulseAnimation != oldDelegate.pulseAnimation ||
           innerRotationAnimation != oldDelegate.innerRotationAnimation ||
           mode != oldDelegate.mode;
  }
}
