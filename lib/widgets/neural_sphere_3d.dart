import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../constants/app_colors.dart';

class NeuralSphere3D extends StatefulWidget {
  final String mode;

  const NeuralSphere3D({super.key, required this.mode});

  @override
  State<NeuralSphere3D> createState() => _NeuralSphere3DState();
}

class _NeuralSphere3DState extends State<NeuralSphere3D>
    with TickerProviderStateMixin {
  late AnimationController _rotationController;
  late AnimationController _pulseController;
  late AnimationController _particleController;
  late List<NeuralNode> _nodes;
  late List<NeuralConnection> _connections;
  late List<Particle> _particles;

  @override
  void initState() {
    super.initState();
    
    _rotationController = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat();

    _pulseController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);

    _particleController = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    )..repeat();

    _generateNeuralNetwork();
    _generateParticles();
  }

  void _generateNeuralNetwork() {
    _nodes = [];
    _connections = [];
    final random = math.Random();
    const sphereRadius = 200.0; // Increased radius for larger sphere
    const nodeCount = 200; // More nodes for denser network

    // Generate nodes in 3D sphere
    for (int i = 0; i < nodeCount; i++) {
      final phi = math.acos(1 - 2 * (i / nodeCount));
      final theta = math.pi * (1 + math.sqrt(5)) * i;
      
      final x = sphereRadius * math.cos(theta) * math.sin(phi);
      final y = sphereRadius * math.sin(theta) * math.sin(phi);
      final z = sphereRadius * math.cos(phi);
      
      _nodes.add(NeuralNode(
        x: x,
        y: y, 
        z: z,
        intensity: random.nextDouble(),
        pulsePhase: random.nextDouble() * 2 * math.pi,
      ));
    }

    // Generate connections between nearby nodes
    for (int i = 0; i < _nodes.length; i++) {
      for (int j = i + 1; j < _nodes.length; j++) {
        final node1 = _nodes[i];
        final node2 = _nodes[j];
        
        final distance = math.sqrt(
          math.pow(node1.x - node2.x, 2) +
          math.pow(node1.y - node2.y, 2) +
          math.pow(node1.z - node2.z, 2)
        );
        
        if (distance < 120 && random.nextDouble() > 0.6) { // More connections
          _connections.add(NeuralConnection(
            node1: i,
            node2: j,
            strength: random.nextDouble(),
            pulseSpeed: 0.5 + random.nextDouble() * 2,
          ));
        }
      }
    }
  }

  void _generateParticles() {
    _particles = [];
    final random = math.Random();
    
    for (int i = 0; i < 150; i++) { // More particles for better effect
      _particles.add(Particle(
        x: (random.nextDouble() - 0.5) * 400,
        y: (random.nextDouble() - 0.5) * 400,
        z: (random.nextDouble() - 0.5) * 400,
        velocity: Offset(
          (random.nextDouble() - 0.5) * 0.5,
          (random.nextDouble() - 0.5) * 0.5,
        ),
        life: random.nextDouble(),
      ));
    }
  }

  @override
  void dispose() {
    _rotationController.dispose();
    _pulseController.dispose();
    _particleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: Colors.black,
        border: Border.all(
        color: AppColors.getSystemModeColor(widget.mode).withOpacity(0.4),
        width: 2,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.getSystemModeColor(widget.mode).withOpacity(0.4),
            blurRadius: 80,
            spreadRadius: 20,
          ),
          BoxShadow(
            color: AppColors.getSystemModeColor(widget.mode).withOpacity(0.2),
            blurRadius: 120,
            spreadRadius: 40,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(22),
        child: Stack(
          children: [
            // Background grid
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: _createGridPattern(),
                  fit: BoxFit.cover,
                  opacity: 0.1,
                ),
              ),
            ),
            
            // Neural sphere
            AnimatedBuilder(
              animation: Listenable.merge([
                _rotationController,
                _pulseController,
                _particleController,
              ]),
              builder: (context, child) {
                return CustomPaint(
                  painter: NeuralSpherePainter(
                    nodes: _nodes,
                    connections: _connections,
                    particles: _particles,
                    rotation: _rotationController.value * 2 * math.pi,
                    pulse: _pulseController.value,
                    particleTime: _particleController.value,
                    modeColor: AppColors.getSystemModeColor(widget.mode),
                  ),
                  size: Size.infinite,
                );
              },
            ),
            
            // Central glow effect - ENHANCED
            Center(
              child: AnimatedBuilder(
                animation: _pulseController,
                builder: (context, child) {
                  return Container(
                    width: 120 + (80 * _pulseController.value), // Larger central glow
                    height: 120 + (80 * _pulseController.value),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          AppColors.getSystemModeColor(widget.mode).withOpacity(0.6),
                          AppColors.getSystemModeColor(widget.mode).withOpacity(0.3),
                          AppColors.getSystemModeColor(widget.mode).withOpacity(0.1),
                          Colors.transparent,
                        ],
                        stops: [0.0, 0.3, 0.7, 1.0],
                      ),
                    ),
                  );
                },
              ),
            ),
            
            // Scanning lines overlay
            AnimatedBuilder(
              animation: _rotationController,
              builder: (context, child) {
                return CustomPaint(
                  painter: ScanningLinesPainter(
                    animation: _rotationController.value,
                    color: AppColors.getSystemModeColor(widget.mode),
                  ),
                  size: Size.infinite,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  ImageProvider _createGridPattern() {
    // Create a simple grid pattern for background
    return const AssetImage('assets/grid_pattern.png'); // You'd need to add this asset
  }
}

class NeuralNode {
  final double x, y, z;
  final double intensity;
  final double pulsePhase;

  NeuralNode({
    required this.x,
    required this.y,
    required this.z,
    required this.intensity,
    required this.pulsePhase,
  });
}

class NeuralConnection {
  final int node1, node2;
  final double strength;
  final double pulseSpeed;

  NeuralConnection({
    required this.node1,
    required this.node2,
    required this.strength,
    required this.pulseSpeed,
  });
}

class Particle {
  final double x, y, z;
  final Offset velocity;
  final double life;

  Particle({
    required this.x,
    required this.y,
    required this.z,
    required this.velocity,
    required this.life,
  });
}

class NeuralSpherePainter extends CustomPainter {
  final List<NeuralNode> nodes;
  final List<NeuralConnection> connections;
  final List<Particle> particles;
  final double rotation;
  final double pulse;
  final double particleTime;
  final Color modeColor;

  NeuralSpherePainter({
    required this.nodes,
    required this.connections,
    required this.particles,
    required this.rotation,
    required this.pulse,
    required this.particleTime,
    required this.modeColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    
    // Transform 3D to 2D with rotation
    List<Offset> projectedNodes = [];
    for (final node in nodes) {
      final rotatedX = node.x * math.cos(rotation) - node.z * math.sin(rotation);
      final rotatedZ = node.x * math.sin(rotation) + node.z * math.cos(rotation);
      
      // Simple perspective projection
      final perspective = 300.0;
      final scale = perspective / (perspective + rotatedZ);
      final screenX = rotatedX * scale + center.dx;
      final screenY = node.y * scale + center.dy;
      
      projectedNodes.add(Offset(screenX, screenY));
    }
    
    // Draw connections with animated pulses
    final connectionPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;
    
    for (final connection in connections) {
      final start = projectedNodes[connection.node1];
      final end = projectedNodes[connection.node2];
      
      // Animated connection strength
      final animatedStrength = connection.strength * 
        (0.3 + 0.7 * math.sin(rotation * connection.pulseSpeed + connection.node1));
      
      connectionPaint.color = modeColor.withOpacity(animatedStrength * 0.6); // Increased from 0.4
      
      // Draw connection line
      canvas.drawLine(start, end, connectionPaint);
      
      // Draw pulse along connection
      if (animatedStrength > 0.7) {
        final pulsePosition = (rotation * connection.pulseSpeed) % 1.0;
        final pulsePoint = Offset.lerp(start, end, pulsePosition)!;
        
        final pulsePaint = Paint()
          ..color = modeColor.withOpacity(0.8)
          ..style = PaintingStyle.fill;
        
        canvas.drawCircle(pulsePoint, 2.0, pulsePaint);
      }
    }
    
    // Draw nodes with dynamic sizing
    final nodePaint = Paint()..style = PaintingStyle.fill;
    
    for (int i = 0; i < nodes.length; i++) {
      final node = nodes[i];
      final screenPos = projectedNodes[i];
      
      // Check if node is in front
      final rotatedZ = node.x * math.sin(rotation) + node.z * math.cos(rotation);
      if (rotatedZ > -150) {
        final nodeIntensity = node.intensity * 
          (0.5 + 0.5 * math.sin(rotation * 2 + node.pulsePhase + pulse * math.pi * 2));
        
        nodePaint.color = modeColor.withOpacity(nodeIntensity * 0.95);
        
        final nodeSize = 1.0 + (nodeIntensity * 1.0); // Reduced from 1.5 + (nodeIntensity * 3)
        canvas.drawCircle(screenPos, nodeSize, nodePaint);
        
        // Draw node glow for highly active nodes
        if (nodeIntensity > 0.8) {
          final glowPaint = Paint()
            ..color = modeColor.withOpacity(0.3)
            ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);
          canvas.drawCircle(screenPos, nodeSize * 2, glowPaint);
        }
      }
    }
    
    // Draw floating particles
    final particlePaint = Paint()..style = PaintingStyle.fill;
    
    for (final particle in particles) {
      final animatedLife = (particle.life + particleTime) % 1.0;
      final opacity = math.sin(animatedLife * math.pi);
      
      if (opacity > 0) {
        particlePaint.color = modeColor.withOpacity(opacity * 0.6);
        
        final particleX = particle.x + particle.velocity.dx * particleTime * 100;
        final particleY = particle.y + particle.velocity.dy * particleTime * 100;
        
        canvas.drawCircle(
          Offset(particleX + center.dx, particleY + center.dy),
          1.0 + opacity,
          particlePaint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(NeuralSpherePainter oldDelegate) {
    return rotation != oldDelegate.rotation ||
           pulse != oldDelegate.pulse ||
           particleTime != oldDelegate.particleTime ||
           modeColor != oldDelegate.modeColor;
  }
}

class ScanningLinesPainter extends CustomPainter {
  final double animation;
  final Color color;

  ScanningLinesPainter({required this.animation, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withOpacity(0.3)
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    // Horizontal scanning lines
    for (int i = 0; i < 8; i++) {
      final y = (animation * size.height + i * size.height / 8) % size.height;
      final opacity = math.sin((animation + i * 0.125) * math.pi * 2) * 0.5 + 0.5;
      
      paint.color = color.withOpacity(opacity * 0.2);
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        paint,
      );
    }

    // Vertical scanning lines
    for (int i = 0; i < 6; i++) {
      final x = (animation * size.width + i * size.width / 6) % size.width;
      final opacity = math.sin((animation + i * 0.167) * math.pi * 2) * 0.5 + 0.5;
      
      paint.color = color.withOpacity(opacity * 0.15);
      canvas.drawLine(
        Offset(x, 0),
        Offset(x, size.height),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(ScanningLinesPainter oldDelegate) {
    return animation != oldDelegate.animation || color != oldDelegate.color;
  }
}