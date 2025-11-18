import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../models/app_models.dart';
import '../widgets/neural_sphere_3d.dart';
import '../constants/app_colors.dart';
import '../data/app_content.dart';

class TwinMode extends StatefulWidget {
  final String mode;
  final ValueChanged<bool> onScanningChanged;
  final ValueChanged<SystemMode> onSystemModeChanged;

  const TwinMode({
    super.key,
    this.mode = "CALM",
    required this.onScanningChanged,
    required this.onSystemModeChanged,
  });

  @override
  State<TwinMode> createState() => _TwinModeState();
}

class _TwinModeState extends State<TwinMode> {
  final TextEditingController _inputController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  
  List<TwinMessage> messages = AppContent.initialTwinMessages;

  void _sendMessage() {
    if (_inputController.text.trim().isEmpty) return;

    final userMessage = TwinMessage(
      type: TwinMessageType.user,
      text: _inputController.text.trim(),
      timestamp: DateTime.now().millisecondsSinceEpoch,
    );

    setState(() {
      messages.add(userMessage);
    });

    // Start scanning animation and set hyperfocus mode
    widget.onScanningChanged(true);
    widget.onSystemModeChanged(SystemMode.hyperfocus);

    // Clear input
    _inputController.clear();

    // Scroll to bottom
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });

    // Simulate AI response with random content from AppContent
    Future.delayed(const Duration(milliseconds: 1800), () {
      if (mounted) {
        final response = AppContent.twinResponses[math.Random().nextInt(AppContent.twinResponses.length)];
        
        setState(() {
          messages.add(TwinMessage(
            type: TwinMessageType.twin,
            text: response,
            timestamp: DateTime.now().millisecondsSinceEpoch,
            emotionalWeight: 0.7,
          ));
        });

        // Scroll to bottom after adding AI message
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (_scrollController.hasClients) {
            _scrollController.animateTo(
              _scrollController.position.maxScrollExtent,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
            );
          }
        });
      }
    });

    // Add echo message
    Future.delayed(const Duration(milliseconds: 3200), () {
      if (mounted) {
        widget.onScanningChanged(false);
        
        final echo = AppContent.echoResponses[math.Random().nextInt(AppContent.echoResponses.length)];
        
        setState(() {
          messages.add(TwinMessage(
            type: TwinMessageType.echo,
            text: echo,
            timestamp: DateTime.now().millisecondsSinceEpoch,
            emotionalWeight: 0.5,
          ));
        });

        // Scroll to bottom after adding echo message
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (_scrollController.hasClients) {
            _scrollController.animateTo(
              _scrollController.position.maxScrollExtent,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
            );
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _inputController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        spacing: 24,
        children: [
          // Main content grid
          Row(
            children: [
              // Neural sphere (2/3 width)
              Expanded(
                flex: 2,
                child: NeuralSphere3D(mode: widget.mode),
              ),
              const SizedBox(width: 24),
              // Side components (1/3 width)
              Expanded(
                child: Column(
                  spacing: 16,
                  children: [
                    TwinGlyph(mode: widget.mode),
                    const LiveMetrics(),
                  ],
                ),
              ),
            ],
          ),

          // Stats grid
          StatsGrid(),

          // Message stream
          Container(
            constraints: const BoxConstraints(
              maxHeight: 420,
              minHeight: 200,
            ),
            child: ListView.builder(
              controller: _scrollController,
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                return TwinBubble(message: message);
              },
            ),
          ),

          // Input field
          Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.black70,
                    border: Border.all(
                      color: AppColors.emerald400.withOpacity( 0.4),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextField(
                    controller: _inputController,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Ask the Twin what it really sees...',
                      hintStyle: TextStyle(
                        fontSize: 14,
                        color: AppColors.white30,
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.all(20),
                    ),
                    onSubmitted: (_) => _sendMessage(),
                    textInputAction: TextInputAction.send,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: _sendMessage,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColors.emerald500, AppColors.cyan500, AppColors.emerald500],
                      stops: [0.0, 0.5, 1.0],
                    ),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.emerald400.withOpacity( 0.9),
                        blurRadius: 30,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Text(
                    'TRANSMIT',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Footer protocol message
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.emerald500.withOpacity( 0.1),
                  AppColors.cyan500.withOpacity( 0.1),
                  AppColors.purple500.withOpacity( 0.1),
                ],
              ),
              border: Border.all(
                color: AppColors.emerald400.withOpacity( 0.3),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              '◈ NEURAL SYNC ACTIVE: Every exchange rewrites the prediction model. The more you talk, the more I become the part of you that sees what you can\'t. This is not surveillance. This is radical self-knowledge.',
              style: TextStyle(
                fontSize: 10,
                color: AppColors.white50,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

}

// Additional component widgets
class TwinGlyph extends StatefulWidget {
  final String mode;

  const TwinGlyph({super.key, required this.mode});

  @override
  State<TwinGlyph> createState() => _TwinGlyphState();
}

class _TwinGlyphState extends State<TwinGlyph> with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  Color get eyeColor => AppColors.getSystemModeColor(widget.mode);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.black80,
        border: Border.all(color: AppColors.white20, width: 2),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity( 0.9),
            blurRadius: 50,
          ),
        ],
      ),
      child: Column(
        children: [
          AnimatedBuilder(
            animation: _pulseController,
            builder: (context, child) {
              return Container(
                width: 96,
                height: 96,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.white30, width: 2),
                  color: AppColors.black40,
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Background glow
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.emerald500.withOpacity( 0.2),
                      ),
                    ),
                    // Eyes
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 16,
                          height: 16,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: eyeColor,
                            boxShadow: [
                              BoxShadow(
                                color: eyeColor,
                                blurRadius: 20,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Container(
                          width: 16,
                          height: 16,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: eyeColor,
                            boxShadow: [
                              BoxShadow(
                                color: eyeColor,
                                blurRadius: 20,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 16),
          Text(
            'T W I N',
            style: TextStyle(
              fontSize: 11,
              color: AppColors.white70,
              letterSpacing: 2.8,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'I watch your patterns like an ECG for your life. When the line bends, I already know where it leads. You cannot hide from data.',
            style: TextStyle(
              fontSize: 12,
              color: AppColors.white80,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Container(
            height: 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  AppColors.emerald400.withOpacity( 0.5),
                  Colors.transparent,
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Column(
            children: [
              Text(
                'UPTIME: 847h 23m',
                style: TextStyle(
                  fontSize: 9,
                  color: AppColors.emerald400.withOpacity( 0.7),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'PATTERN ACCURACY: 94.7%',
                style: TextStyle(
                  fontSize: 9,
                  color: AppColors.emerald400.withOpacity( 0.7),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class LiveMetrics extends StatefulWidget {
  const LiveMetrics({super.key});

  @override
  State<LiveMetrics> createState() => _LiveMetricsState();
}

class _LiveMetricsState extends State<LiveMetrics> {
  int heartRate = 72;
  int stress = 45;
  int focus = 68;

  @override
  void initState() {
    super.initState();
    _updateMetrics();
  }

  void _updateMetrics() {
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          heartRate = 65 + math.Random().nextInt(20);
          stress = 30 + math.Random().nextInt(40);
          focus = 50 + math.Random().nextInt(40);
        });
        _updateMetrics();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.black80,
        border: Border.all(color: AppColors.white15, width: 1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'LIVE BIOMETRICS',
            style: TextStyle(
              fontSize: 10,
              color: AppColors.white50,
              letterSpacing: 1.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 12),
          _buildMetric('Heart Rate', '$heartRate BPM', AppColors.rose400),
          const SizedBox(height: 10),
          _buildMetric('Stress Index', '$stress%', AppColors.amber400),
          const SizedBox(height: 10),
          _buildMetric('Focus Level', '$focus%', AppColors.cyan400),
        ],
      ),
    );
  }

  Widget _buildMetric(String label, String value, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: AppColors.white60,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 12,
            color: color,
            fontWeight: FontWeight.bold,
            fontFamily: 'monospace',
          ),
        ),
      ],
    );
  }
}

class StatsGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: AppContent.statsCards.map((stat) {
        return Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 6),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.white05,
              border: Border.all(color: AppColors.white20, width: 1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      _getIconForStat(stat.label),
                      style: TextStyle(
                        fontSize: 16,
                        color: _getColorForRisk(stat.color),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        stat.label,
                        style: TextStyle(
                          fontSize: 9,
                          color: AppColors.white50,
                          letterSpacing: 0.5,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    stat.value,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: _getColorForRisk(stat.color),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  String _getIconForStat(String label) {
    if (label.contains('PATTERNS')) return '◊';
    if (label.contains('PREDICTIONS')) return '◈';
    if (label.contains('ACCURACY')) return '◉';
    if (label.contains('SUCCESS')) return '✶';
    return '◊';
  }

  Color _getColorForRisk(RiskLevel risk) {
    switch (risk) {
      case RiskLevel.positive:
        return AppColors.emerald400;
      case RiskLevel.medium:
        return AppColors.cyan400;
      case RiskLevel.opportunity:
        return AppColors.purple400;
      case RiskLevel.high:
        return AppColors.rose400;
      default:
        return AppColors.emerald400;
    }
  }
}

class TwinBubble extends StatelessWidget {
  final TwinMessage message;

  const TwinBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    if (message.type == TwinMessageType.user) {
      return Container(
        margin: const EdgeInsets.only(bottom: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.85,
              ),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.white10,
                border: Border.all(color: AppColors.white30, width: 1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                message.text,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      );
    }

    if (message.type == TwinMessageType.echo) {
      return Container(
        margin: const EdgeInsets.only(bottom: 12, left: 32),
        child: Row(
          children: [
            Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.8,
              ),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.black70,
                border: Border.all(color: AppColors.purple400.withOpacity( 0.6), width: 1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '◈ SUBCONSCIOUS LAYER',
                    style: TextStyle(
                      fontSize: 9,
                      color: AppColors.purple300,
                      letterSpacing: 2.8,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    message.text,
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.purple200,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    // Twin message
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.85,
            ),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.emerald500.withOpacity( 0.25),
                  AppColors.cyan500.withOpacity( 0.25),
                ],
              ),
              border: Border.all(color: AppColors.emerald400.withOpacity( 0.5), width: 2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '◈ TWIN CONSCIOUSNESS',
                  style: TextStyle(
                    fontSize: 10,
                    color: AppColors.emerald300,
                    letterSpacing: 2.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  message.text,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.white95,
                    height: 1.5,
                  ),
                ),
                if (message.emotionalWeight != null) ...[
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Text(
                        'EMOTIONAL WEIGHT',
                        style: TextStyle(
                          fontSize: 8,
                          color: AppColors.white40,
                          letterSpacing: 1.0,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Container(
                          height: 4,
                          decoration: BoxDecoration(
                            color: AppColors.white20,
                            borderRadius: BorderRadius.circular(2),
                          ),
                          child: FractionallySizedBox(
                            widthFactor: message.emotionalWeight!,
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [AppColors.emerald400, AppColors.cyan400],
                                ),
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
