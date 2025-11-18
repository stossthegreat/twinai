import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'screens/onboarding/onboarding_screen.dart';
import 'constants/app_colors.dart';

void main() {
  runApp(const TwinOSApp());
}

class TwinOSApp extends StatelessWidget {
  const TwinOSApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812), // iPhone X design size
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'TWIN OS',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            brightness: Brightness.dark,
            scaffoldBackgroundColor: AppColors.black,
            primaryColor: AppColors.emerald400,
            colorScheme: ColorScheme.dark(
              primary: AppColors.emerald400,
              secondary: AppColors.cyan400,
              surface: AppColors.black,
              background: AppColors.black,
              onPrimary: AppColors.black,
              onSecondary: AppColors.black,
              onSurface: AppColors.white,
              onBackground: AppColors.white,
            ),
            useMaterial3: true,
          ),
          home: AnnotatedRegion<SystemUiOverlayStyle>(
            value: const SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.light,
              systemNavigationBarColor: Colors.transparent,
              systemNavigationBarIconBrightness: Brightness.light,
            ),
            child: const OnboardingScreen(),
          ),
        );
      },
    );
  }
}
