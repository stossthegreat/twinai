import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../models/app_models.dart';
import '../widgets/neural_sphere_3d.dart';
import '../widgets/twin_bubble.dart';
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
    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth >= 768;
        
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // TOP SECTION: Neural Sphere + Sidebar (responsive)
              if (isDesktop) ...[
                // Desktop: side-by-side layout
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Neural Sphere (2/3 width)
                    Expanded(
                      flex: 2,
                      child: Container(
                        height: 340,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24), // rounded-3xl
                          border: Border.all(
                            color: AppColors.emerald400.withOpacity(0.4), // reduced from 0.6
                            width: 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.emerald400.withOpacity(0.4),
                              blurRadius: 80,
                              spreadRadius: 0,
                            ),
                          ],
                        ),
                        child: NeuralSphere3D(mode: widget.mode),
                      ),
                    ),
                    
                    const SizedBox(width: 24),
                    
                    // Sidebar (1/3 width)
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          _buildTwinGlyph(),
                          const SizedBox(height: 16),
                          _buildLiveMetrics(),
                        ],
                      ),
                    ),
                  ],
                ),
              ] else ...[
                // Mobile: stacked layout
                Container(
                  height: 340,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24), // rounded-3xl
                    border: Border.all(
                      color: AppColors.emerald400.withOpacity(0.4), // reduced from 0.6
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.emerald400.withOpacity(0.4),
                        blurRadius: 80,
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: NeuralSphere3D(mode: widget.mode),
                ),
                const SizedBox(height: 24),
                _buildTwinGlyph(),
                const SizedBox(height: 24),
                _buildLiveMetrics(),
              ],

              const SizedBox(height: 24),

              // STATS GRID (responsive: 4 columns on desktop, 2x2 on mobile)
              _buildStatsGrid(isDesktop),

              const SizedBox(height: 24),

              // MESSAGES DISPLAY AREA (CRITICAL - was missing!)
              Container(
                constraints: const BoxConstraints(maxHeight: 420),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ListView.builder(
                  controller: _scrollController,
                  padding: EdgeInsets.zero,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    return TwinBubble(message: messages[index]);
                  },
                ),
              ),

              const SizedBox(height: 24),

              // INPUT FIELD
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.black70,
                        border: Border.all(
                          color: AppColors.emerald400.withOpacity(0.4),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(12), // rounded-xl
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.emerald400.withOpacity(0.5),
                            blurRadius: 30,
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: _inputController,
                        style: const TextStyle(
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
                        gradient: const LinearGradient(
                          colors: [AppColors.emerald500, AppColors.cyan500, AppColors.emerald500],
                          stops: [0.0, 0.5, 1.0],
                        ),
                        borderRadius: BorderRadius.circular(12), // rounded-xl
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.emerald400.withOpacity(0.9),
                            blurRadius: 30,
                            spreadRadius: 0,
                          ),
                          BoxShadow(
                            color: AppColors.emerald400.withOpacity(0.5),
                            blurRadius: 50,
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: const Text(
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

              const SizedBox(height: 24),

              // FOOTER PROTOCOL MESSAGE
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.emerald500.withOpacity(0.1),
                      AppColors.cyan500.withOpacity(0.1),
                      AppColors.purple500.withOpacity(0.1),
                    ],
                  ),
                  border: Border.all(
                    color: AppColors.emerald400.withOpacity(0.3),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(12), // rounded-xl
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
      },
    );
  }

  Widget _buildBiometricRow(String label, String value, String unit, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: AppColors.white70,
          ),
        ),
        Row(
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(width: 4),
            Text(
              unit,
              style: TextStyle(
                fontSize: 12,
                color: color.withOpacity(0.7),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTwinGlyph() {
    final eyeColor = AppColors.getSystemModeColor(widget.mode);
    
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.black80,
        border: Border.all(color: AppColors.white20, width: 2),
        borderRadius: BorderRadius.circular(16), // rounded-2xl
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.9),
            blurRadius: 50,
          ),
        ],
      ),
      child: Column(
        children: [
          // Twin Eyes
          Container(
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
                // Background radial gradient
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        AppColors.emerald500.withOpacity(0.1),
                        Colors.transparent,
                      ],
                    ),
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
          ),
          const SizedBox(height: 16),
          Text(
            'T W I N',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: AppColors.white70,
              letterSpacing: 2.8,
            ),
          ),
          const SizedBox(height: 16),
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
            width: double.infinity,
            height: 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  AppColors.emerald400.withOpacity(0.5),
                  Colors.transparent,
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Column(
            children: [
              Text(
                'UPTIME: 847h 23m',
                style: TextStyle(
                  fontSize: 9,
                  color: AppColors.emerald400.withOpacity(0.7),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'PATTERN ACCURACY: 94.7%',
                style: TextStyle(
                  fontSize: 9,
                  color: AppColors.emerald400.withOpacity(0.7),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLiveMetrics() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.black80,
        border: Border.all(color: AppColors.white15, width: 1),
        borderRadius: BorderRadius.circular(16), // rounded-2xl
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'LIVE BIOMETRICS',
            style: TextStyle(
              fontSize: 10,
              color: AppColors.white50,
              letterSpacing: 2,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          _buildBiometricRow('Heart Rate', '72', 'BPM', AppColors.rose400),
          const SizedBox(height: 8),
          _buildBiometricRow('Stress Index', '45', '%', AppColors.amber400),
          const SizedBox(height: 8),
          _buildBiometricRow('Focus Level', '68', '%', AppColors.cyan400),
        ],
      ),
    );
  }

  Widget _buildStatsGrid(bool isDesktop) {
    final stats = [
      {'label': 'TRACKED PATTERNS', 'value': '12,847', 'color': AppColors.emerald400, 'icon': '◊'},
      {'label': 'LIVE PREDICTIONS', 'value': '2,143', 'color': AppColors.cyan400, 'icon': '◈'},
      {'label': 'ACCURACY RATE', 'value': '94.7%', 'color': AppColors.purple400, 'icon': '◉'},
      {'label': 'INTERVENTION SUCCESS', 'value': '87.3%', 'color': AppColors.rose400, 'icon': '✶'},
    ];

    if (isDesktop) {
      // Desktop: 4 columns in one row
      return Row(
        children: stats.map((stat) {
          return Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                right: stat == stats.last ? 0 : 12,
              ),
              child: _buildStatCard(
                stat['label'] as String,
                stat['value'] as String,
                stat['color'] as Color,
                stat['icon'] as String,
              ),
            ),
          );
        }).toList(),
      );
    } else {
      // Mobile: 2x2 grid
      return Column(
        children: [
          Row(
            children: [
              Expanded(child: _buildStatCard(stats[0]['label'] as String, stats[0]['value'] as String, stats[0]['color'] as Color, stats[0]['icon'] as String)),
              const SizedBox(width: 12),
              Expanded(child: _buildStatCard(stats[1]['label'] as String, stats[1]['value'] as String, stats[1]['color'] as Color, stats[1]['icon'] as String)),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _buildStatCard(stats[2]['label'] as String, stats[2]['value'] as String, stats[2]['color'] as Color, stats[2]['icon'] as String)),
              const SizedBox(width: 12),
              Expanded(child: _buildStatCard(stats[3]['label'] as String, stats[3]['value'] as String, stats[3]['color'] as Color, stats[3]['icon'] as String)),
            ],
          ),
        ],
      );
    }
  }

  Widget _buildStatCard(String title, String value, Color color, String icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.white05, // bg-white/5
        border: Border.all(color: AppColors.white20, width: 1), // border-white/20
        borderRadius: BorderRadius.circular(12), // rounded-xl
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.1),
            blurRadius: 8,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                icon,
                style: TextStyle(
                  fontSize: 16,
                  color: color,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 9,
                    color: AppColors.white50,
                    letterSpacing: 1,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}