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
        children: [
          // 1. TOP: Neural Sphere Animation (Full Width)
          NeuralSphere3D(mode: widget.mode),
          
          const SizedBox(height: 24),
          
          // 2. TWIN Explanation Box
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.black80,
              border: Border.all(color: AppColors.white20, width: 2),
              borderRadius: BorderRadius.circular(16),
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
                      // Background glow
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.emerald500.withOpacity(0.2),
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
                              color: AppColors.getSystemModeColor(widget.mode),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.getSystemModeColor(widget.mode),
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
                              color: AppColors.getSystemModeColor(widget.mode),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.getSystemModeColor(widget.mode),
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
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 4,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'I watch your patterns like an ECG for your life. When the line bends, I already know where it leads. You cannot hide from data.',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.white80,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Text(
                          'UPTIME: 847h 23m',
                          style: TextStyle(
                            fontSize: 10,
                            color: AppColors.emerald400,
                            letterSpacing: 1,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          'PATTERN ACCURACY: 94.7%',
                          style: TextStyle(
                            fontSize: 10,
                            color: AppColors.emerald400,
                            letterSpacing: 1,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ]
            ),
          ),

          const SizedBox(height: 24),

          // 3. LIVE BIOMETRICS Box
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.black80,
              border: Border.all(color: AppColors.white20, width: 2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'LIVE BIOMETRICS',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.white50,
                    letterSpacing: 2,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                _buildBiometricRow('Heart Rate', '77', 'BPM', AppColors.rose400),
                const SizedBox(height: 12),
                _buildBiometricRow('Stress Index', '44', '%', AppColors.amber400),
                const SizedBox(height: 12),
                _buildBiometricRow('Focus Level', '60', '%', AppColors.cyan400),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // 4. STATS GRID (2x2)
          Column(
            children: [
              Row(
                children: [
                  Expanded(child: _buildStatCard('TRACKED PATTERNS', '12,847', AppColors.emerald400)),
                  const SizedBox(width: 16),
                  Expanded(child: _buildStatCard('LIVE PREDICTIONS', '2,143', AppColors.cyan400)),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(child: _buildStatCard('ACCURACY RATE', '94.7%', AppColors.purple400)),
                  const SizedBox(width: 16),
                  Expanded(child: _buildStatCard('INTERVENTION SUCCESS', '87.3%', AppColors.rose400)),
                ],
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Input field
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
                      stops: const [0.0, 0.5, 1.0],
                    ),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.emerald400.withOpacity(0.9),
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

          const SizedBox(height: 24),

          // Footer protocol message
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

  Widget _buildStatCard(String title, String value, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.black80,
        border: Border.all(color: color.withOpacity(0.3), width: 2),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.1),
            blurRadius: 20,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: 10,
                  color: AppColors.white50,
                  letterSpacing: 1,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}