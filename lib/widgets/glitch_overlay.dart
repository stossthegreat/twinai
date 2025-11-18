import 'package:flutter/material.dart';

class GlitchOverlay extends StatefulWidget {
  final bool showGlitch;
  
  const GlitchOverlay({
    super.key,
    required this.showGlitch,
  });

  @override
  State<GlitchOverlay> createState() => _GlitchOverlayState();
}

class _GlitchOverlayState extends State<GlitchOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_controller);
  }

  @override
  void didUpdateWidget(GlitchOverlay oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.showGlitch && !oldWidget.showGlitch) {
      _controller.forward().then((_) {
        if (mounted) {
          _controller.reverse();
        }
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.showGlitch) return const SizedBox.shrink();
    
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Positioned.fill(
          child: IgnorePointer(
            child: Stack(
              children: [
                // Red channel
                Container(
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity( 0.2 * _animation.value),
                  ),
                ),
                
                // Cyan channel with offset
                Transform.translate(
                  offset: Offset(2.0 * _animation.value, 0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.cyan.withOpacity( 0.2 * _animation.value),
                    ),
                  ),
                ),
                
                // Green channel with negative offset
                Transform.translate(
                  offset: Offset(-2.0 * _animation.value, 0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity( 0.2 * _animation.value),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
