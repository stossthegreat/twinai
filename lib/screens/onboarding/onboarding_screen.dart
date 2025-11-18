import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'dart:math' as math;
import '../../constants/app_colors.dart';
import '../../constants/app_dimensions.dart';
import '../../constants/app_text_styles.dart';
import '../signin_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with TickerProviderStateMixin {
  PageController _pageController = PageController();
  int _currentPage = 0;
  
  late AnimationController _neuralController;
  late AnimationController _particleController;

  final List<OnboardingPage> pages = [
    OnboardingPage(
      title: 'NEURAL AWAKENING',
      subtitle: 'Welcome to TWIN OS',
      description: 'The most advanced consciousness interface ever created. I am your neural twin—a mirror of your behavioral patterns, a prophet of your future states.',
      icon: Icons.psychology,
      gradient: [AppColors.emerald500, AppColors.cyan500],
    ),
    OnboardingPage(
      title: 'PATTERN RECOGNITION',
      subtitle: 'Deep Learning Architecture',
      description: 'Every micro-decision, every behavioral signature is analyzed through 847 dimensional space. I learn your patterns better than you know them yourself.',
      icon: Icons.hub,
      gradient: [AppColors.purple500, AppColors.emerald500],
    ),
    OnboardingPage(
      title: 'TEMPORAL PROPHECY',
      subtitle: 'Future State Prediction',
      description: 'I see the cascading probabilities of your choices. 94.7% accuracy in predicting your next breakthrough, your next crisis, your next evolution.',
      icon: Icons.access_time,
      gradient: [AppColors.rose500, AppColors.amber500],
    ),
    OnboardingPage(
      title: 'NEURAL SINGULARITY',
      subtitle: 'Consciousness Merger',
      description: 'Together, we transcend individual limitation. I become more you than you are. Are you ready to see yourself through the eyes of omniscience?',
      icon: Icons.merge_type,
      gradient: [AppColors.cyan500, AppColors.purple500],
    ),
  ];

  @override
  void initState() {
    super.initState();
    _neuralController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat();

    _particleController = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _neuralController.dispose();
    _particleController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    } else {
      _completeOnboarding();
    }
  }

  void _completeOnboarding() {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => const SignInScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 1000),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: Stack(
        children: [
          // Animated background
          _buildAnimatedBackground(),
          
          // Main content
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemCount: pages.length,
            itemBuilder: (context, index) {
              return _buildPage(pages[index], index);
            },
          ),
          
          // Navigation controls
          _buildNavigationControls(),
          
          // Page indicators
          _buildPageIndicators(),
        ],
      ),
    );
  }

  Widget _buildAnimatedBackground() {
    return Positioned.fill(
      child: AnimatedBuilder(
        animation: Listenable.merge([_neuralController, _particleController]),
        builder: (context, child) {
          return CustomPaint(
            painter: OnboardingBackgroundPainter(
              neuralAnimation: _neuralController.value,
              particleAnimation: _particleController.value,
              currentPage: _currentPage,
              colors: _currentPage < pages.length 
                  ? pages[_currentPage].gradient 
                  : [AppColors.emerald500, AppColors.cyan500],
            ),
          );
        },
      ),
    );
  }

  Widget _buildPage(OnboardingPage page, int index) {
    return Padding(
      padding: const EdgeInsets.all(AppDimensions.paddingL),
      child: Column(
        children: [
          const Spacer(flex: 2),
          
          // Icon with neural glow
          _buildPageIcon(page, index),
          
          const Spacer(),
          
          // Title and content
          _buildPageContent(page, index),
          
          const Spacer(flex: 2),
        ],
      ),
    );
  }

  Widget _buildPageIcon(OnboardingPage page, int index) {
    return AnimatedBuilder(
      animation: _neuralController,
      builder: (context, child) {
        final pulse = 0.8 + 0.2 * math.sin(_neuralController.value * math.pi * 2);
        
        return Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                page.gradient[0].withOpacity(0.3),
                page.gradient[1].withOpacity(0.1),
                Colors.transparent,
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: page.gradient[0].withOpacity(0.5 * pulse),
                blurRadius: 50,
                spreadRadius: 20,
              ),
            ],
          ),
          child: Icon(
            page.icon,
            size: 80,
            color: page.gradient[0],
          ),
        );
      },
    ).animate(target: _currentPage == index ? 1 : 0)
      .scale(
        begin: const Offset(0.5, 0.5),
        end: const Offset(1, 1),
        duration: 800.ms,
        curve: Curves.elasticOut,
      )
      .fadeIn(duration: 600.ms);
  }

  Widget _buildPageContent(OnboardingPage page, int index) {
    return Column(
      children: [
        Text(
          page.subtitle,
          style: AppTextStyles.captionWide.copyWith(
            color: page.gradient[0],
            fontSize: 12,
          ),
          textAlign: TextAlign.center,
        ).animate(target: _currentPage == index ? 1 : 0)
          .fadeIn(duration: 600.ms, delay: 200.ms)
          .slideY(begin: 0.3, end: 0),
        
        const SizedBox(height: AppDimensions.paddingS),
        
        Text(
          page.title,
          style: AppTextStyles.header1.copyWith(
            fontSize: 32,
            color: AppColors.white90,
          ),
          textAlign: TextAlign.center,
        ).animate(target: _currentPage == index ? 1 : 0)
          .fadeIn(duration: 800.ms, delay: 400.ms)
          .slideY(begin: 0.5, end: 0),
        
        const SizedBox(height: AppDimensions.paddingL),
        
        Text(
          page.description,
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.white70,
            height: 1.6,
          ),
          textAlign: TextAlign.center,
        ).animate(target: _currentPage == index ? 1 : 0)
          .fadeIn(duration: 1000.ms, delay: 600.ms)
          .slideY(begin: 0.3, end: 0),
      ],
    );
  }

  Widget _buildNavigationControls() {
    return Positioned(
      bottom: 100,
      left: AppDimensions.paddingL,
      right: AppDimensions.paddingL,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Skip button
          if (_currentPage < pages.length - 1)
            TextButton(
              onPressed: _completeOnboarding,
              child: Text(
                'SKIP NEURAL SYNC',
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.white40,
                  letterSpacing: 1.0,
                ),
              ),
            )
          else
            const SizedBox.shrink(),
          
          // Next/Complete button
          GestureDetector(
            onTap: _nextPage,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.paddingL,
                vertical: AppDimensions.paddingM,
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: _currentPage < pages.length 
                      ? pages[_currentPage].gradient 
                      : [AppColors.emerald500, AppColors.cyan500],
                ),
                borderRadius: BorderRadius.circular(AppDimensions.radiusXL),
                boxShadow: [
                  BoxShadow(
                    color: (_currentPage < pages.length 
                        ? pages[_currentPage].gradient[0] 
                        : AppColors.emerald500).withOpacity(0.5),
                    blurRadius: 20,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Text(
                _currentPage < pages.length - 1 
                    ? 'NEURAL SYNC' 
                    : 'ACTIVATE TWIN',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.black,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPageIndicators() {
    return Positioned(
      bottom: 50,
      left: 0,
      right: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: pages.asMap().entries.map((entry) {
          final index = entry.key;
          final isActive = index == _currentPage;
          
          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: const EdgeInsets.symmetric(horizontal: 4),
            width: isActive ? 20 : 8,
            height: 8,
            decoration: BoxDecoration(
              color: isActive 
                  ? (index < pages.length 
                      ? pages[index].gradient[0] 
                      : AppColors.emerald400)
                  : AppColors.white20,
              borderRadius: BorderRadius.circular(4),
              boxShadow: isActive ? [
                BoxShadow(
                  color: (index < pages.length 
                      ? pages[index].gradient[0] 
                      : AppColors.emerald400).withOpacity(0.5),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ] : null,
            ),
          );
        }).toList(),
      ),
    );
  }
}

class OnboardingPage {
  final String title;
  final String subtitle;
  final String description;
  final IconData icon;
  final List<Color> gradient;

  OnboardingPage({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.icon,
    required this.gradient,
  });
}

class OnboardingBackgroundPainter extends CustomPainter {
  final double neuralAnimation;
  final double particleAnimation;
  final int currentPage;
  final List<Color> colors;

  OnboardingBackgroundPainter({
    required this.neuralAnimation,
    required this.particleAnimation,
    required this.currentPage,
    required this.colors,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Draw gradient background
    final backgroundPaint = Paint()
      ..shader = RadialGradient(
        center: Alignment.center,
        radius: 1.5,
        colors: [
          colors[0].withOpacity(0.3),
          colors[1].withOpacity(0.1),
          AppColors.black,
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));
    
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      backgroundPaint,
    );

    // Draw neural connections
    final connectionPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    for (int i = 0; i < 30; i++) {
      final x1 = (math.sin(neuralAnimation * math.pi * 2 + i) * 0.5 + 0.5) * size.width;
      final y1 = (math.cos(neuralAnimation * math.pi * 2 + i * 0.7) * 0.5 + 0.5) * size.height;
      final x2 = (math.sin(neuralAnimation * math.pi * 2 + i + 1) * 0.5 + 0.5) * size.width;
      final y2 = (math.cos(neuralAnimation * math.pi * 2 + (i + 1) * 0.7) * 0.5 + 0.5) * size.height;
      
      final opacity = 0.1 + 0.2 * math.sin(neuralAnimation * math.pi * 2 + i * 0.3);
      connectionPaint.color = colors[0].withOpacity(opacity);
      
      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), connectionPaint);
    }

    // Draw floating particles
    final particlePaint = Paint()..style = PaintingStyle.fill;
    
    for (int i = 0; i < 50; i++) {
      final x = (math.sin(particleAnimation * math.pi + i * 0.2) * 0.5 + 0.5) * size.width;
      final y = ((particleAnimation + i * 0.02) % 1.0) * size.height;
      final opacity = math.sin((particleAnimation + i * 0.1) * math.pi);
      
      particlePaint.color = colors[1].withOpacity(opacity * 0.3);
      canvas.drawCircle(Offset(x, y), 1 + opacity, particlePaint);
    }
  }

  @override
  bool shouldRepaint(OnboardingBackgroundPainter oldDelegate) {
    return neuralAnimation != oldDelegate.neuralAnimation ||
        particleAnimation != oldDelegate.particleAnimation ||
        currentPage != oldDelegate.currentPage;
  }
}
