import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../constants/app_colors.dart';
import '../constants/app_dimensions.dart';
import '../constants/app_text_styles.dart';
import 'main_app.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen>
    with TickerProviderStateMixin {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  
  late AnimationController _pulseController;
  late AnimationController _scanController;
  
  bool _isScanning = false;
  bool _showPassword = false;

  @override
  void initState() {
    super.initState();
    
    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _scanController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _pulseController.dispose();
    _scanController.dispose();
    super.dispose();
  }

  void _skipToApp() {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => const MainApp(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(CurvedAnimation(
              parent: animation,
              curve: Curves.easeInOut,
            )),
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 800),
      ),
    );
  }

  void _performNeuralScan() {
    setState(() {
      _isScanning = true;
    });
    
    _scanController.forward();
    
    // Simulate neural scan
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isScanning = false;
        });
        _scanController.reset();
        _skipToApp(); // For now, always succeed
      }
    });
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
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppDimensions.paddingL),
              child: Column(
                children: [
                  const SizedBox(height: 60),
                  
                  // Header
                  _buildHeader(),
                  
                  const SizedBox(height: 60),
                  
                  // Neural scan or form
                  _isScanning 
                      ? _buildNeuralScan() 
                      : _buildSignInForm(),
                  
                  const SizedBox(height: AppDimensions.paddingXL),
                  
                  // Skip option
                  _buildSkipOption(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedBackground() {
    return Positioned.fill(
      child: AnimatedBuilder(
        animation: _pulseController,
        builder: (context, child) {
          return CustomPaint(
            painter: SignInBackgroundPainter(
              animation: _pulseController.value,
              isScanning: _isScanning,
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        // Neural core icon
        AnimatedBuilder(
          animation: _pulseController,
          builder: (context, child) {
            final pulse = 0.8 + 0.2 * _pulseController.value;
            
            return Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.emerald500.withOpacity(0.4),
                    AppColors.emerald500.withOpacity(0.1),
                    Colors.transparent,
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.emerald400.withOpacity(0.5 * pulse),
                    blurRadius: 40,
                    spreadRadius: 10,
                  ),
                ],
              ),
              child: const Icon(
                Icons.fingerprint,
                size: 60,
                color: AppColors.emerald400,
              ),
            );
          },
        ),
        
        const SizedBox(height: AppDimensions.paddingL),
        
        Text(
          'NEURAL AUTHENTICATION',
          style: AppTextStyles.header1.copyWith(
            color: AppColors.emerald400,
            fontSize: 24,
          ),
        ).animate()
          .fadeIn(duration: 800.ms, delay: 200.ms)
          .slideY(begin: 0.3, end: 0),
        
        const SizedBox(height: AppDimensions.paddingS),
        
        Text(
          'Synchronize with your neural twin',
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.white60,
          ),
        ).animate()
          .fadeIn(duration: 800.ms, delay: 400.ms),
      ],
    );
  }

  Widget _buildSignInForm() {
    return Column(
      children: [
        // Email field
        _buildInputField(
          controller: _emailController,
          label: 'Neural ID',
          hint: 'Enter your consciousness identifier',
          icon: Icons.psychology,
        ),
        
        const SizedBox(height: AppDimensions.paddingL),
        
        // Password field
        _buildInputField(
          controller: _passwordController,
          label: 'Neural Key',
          hint: 'Enter your pattern signature',
          icon: Icons.key,
          isPassword: true,
        ),
        
        const SizedBox(height: AppDimensions.paddingXL),
        
        // Sign in button
        _buildSignInButton(),
        
        const SizedBox(height: AppDimensions.paddingL),
        
        // Biometric signin
        _buildBiometricSignIn(),
      ],
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    bool isPassword = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.emerald400,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppDimensions.paddingS),
        
        Container(
          decoration: BoxDecoration(
            color: AppColors.white.withOpacity(0.05),
            border: Border.all(
              color: AppColors.emerald400.withOpacity(0.3),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(AppDimensions.radiusL),
          ),
          child: TextField(
            controller: controller,
            obscureText: isPassword && !_showPassword,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.white90,
            ),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.white40,
              ),
              prefixIcon: Icon(
                icon,
                color: AppColors.emerald400,
              ),
              suffixIcon: isPassword 
                  ? IconButton(
                      icon: Icon(
                        _showPassword ? Icons.visibility_off : Icons.visibility,
                        color: AppColors.white40,
                      ),
                      onPressed: () {
                        setState(() {
                          _showPassword = !_showPassword;
                        });
                      },
                    )
                  : null,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.all(AppDimensions.paddingM),
            ),
          ),
        ),
      ],
    ).animate()
      .fadeIn(duration: 600.ms, delay: 600.ms)
      .slideX(begin: -0.3, end: 0);
  }

  Widget _buildSignInButton() {
    return GestureDetector(
      onTap: _performNeuralScan,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(AppDimensions.paddingM),
        decoration: BoxDecoration(
          gradient: AppColors.emeraldGradient,
          borderRadius: BorderRadius.circular(AppDimensions.radiusL),
          boxShadow: [
            BoxShadow(
              color: AppColors.emerald500.withOpacity(0.5),
              blurRadius: 20,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Text(
          'INITIATE NEURAL SYNC',
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.black,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.0,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    ).animate()
      .fadeIn(duration: 600.ms, delay: 800.ms)
      .slideY(begin: 0.3, end: 0);
  }

  Widget _buildBiometricSignIn() {
    return GestureDetector(
      onTap: _performNeuralScan,
      child: Container(
        padding: const EdgeInsets.all(AppDimensions.paddingM),
        decoration: BoxDecoration(
          color: AppColors.white.withOpacity(0.05),
          border: Border.all(
            color: AppColors.cyan400.withOpacity(0.3),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(AppDimensions.radiusL),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.fingerprint,
              color: AppColors.cyan400,
              size: 20,
            ),
            const SizedBox(width: AppDimensions.paddingS),
            Text(
              'BIOMETRIC NEURAL SCAN',
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.cyan400,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    ).animate()
      .fadeIn(duration: 600.ms, delay: 1000.ms)
      .slideY(begin: 0.3, end: 0);
  }

  Widget _buildNeuralScan() {
    return Container(
      height: 300,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Scanning animation
          AnimatedBuilder(
            animation: _scanController,
            builder: (context, child) {
              return Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppColors.emerald500.withOpacity(0.5),
                      AppColors.emerald500.withOpacity(0.1),
                      Colors.transparent,
                    ],
                  ),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Scanning rings
                    for (int i = 0; i < 3; i++)
                      Container(
                        width: 60 + (i * 40) + (_scanController.value * 20),
                        height: 60 + (i * 40) + (_scanController.value * 20),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.emerald400.withOpacity(
                              (1 - i * 0.3) * (1 - _scanController.value)
                            ),
                            width: 2,
                          ),
                        ),
                      ),
                    
                    // Center icon
                    const Icon(
                      Icons.psychology,
                      size: 40,
                      color: AppColors.emerald400,
                    ),
                  ],
                ),
              );
            },
          ),
          
          const SizedBox(height: AppDimensions.paddingL),
          
          Text(
            'NEURAL SCAN IN PROGRESS',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.emerald400,
              fontWeight: FontWeight.bold,
            ),
          ).animate(onPlay: (controller) => controller.repeat())
            .fadeIn(duration: 1000.ms)
            .fadeOut(duration: 1000.ms),
          
          const SizedBox(height: AppDimensions.paddingS),
          
          Text(
            'Analyzing neural patterns...',
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.white60,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSkipOption() {
    return Column(
      children: [
        const Divider(color: AppColors.white10),
        const SizedBox(height: AppDimensions.paddingM),
        
        TextButton(
          onPressed: _skipToApp,
          child: Text(
            'SKIP AUTHENTICATION & ENTER TWIN OS',
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.white40,
              letterSpacing: 1.0,
            ),
          ),
        ),
        
        const SizedBox(height: AppDimensions.paddingS),
        
        Text(
          'Authentication logic will be implemented later',
          style: AppTextStyles.caption.copyWith(
            color: AppColors.white30,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }
}

class SignInBackgroundPainter extends CustomPainter {
  final double animation;
  final bool isScanning;

  SignInBackgroundPainter({
    required this.animation,
    required this.isScanning,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Background gradient
    final backgroundPaint = Paint()
      ..shader = RadialGradient(
        center: Alignment.center,
        radius: 1.2,
        colors: [
          AppColors.emerald500.withOpacity(0.2),
          AppColors.black,
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));
    
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      backgroundPaint,
    );

    // Neural grid
    final gridPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5
      ..color = AppColors.emerald400.withOpacity(0.1);

    const spacing = 40.0;
    for (double x = 0; x <= size.width; x += spacing) {
      canvas.drawLine(
        Offset(x, 0),
        Offset(x, size.height),
        gridPaint,
      );
    }
    
    for (double y = 0; y <= size.height; y += spacing) {
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        gridPaint,
      );
    }

    // Scanning effect
    if (isScanning) {
      final scanPaint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2
        ..color = AppColors.emerald400.withOpacity(0.7);

      final progress = animation;
      final scanY = size.height * progress;
      
      canvas.drawLine(
        Offset(0, scanY),
        Offset(size.width, scanY),
        scanPaint,
      );
    }
  }

  @override
  bool shouldRepaint(SignInBackgroundPainter oldDelegate) {
    return animation != oldDelegate.animation || 
           isScanning != oldDelegate.isScanning;
  }
}
