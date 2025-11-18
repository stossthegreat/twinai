import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextStyles {
  // Font family - using a modern sans-serif similar to the React app
  static String get fontFamily => GoogleFonts.inter().fontFamily!;
  
  // Headers
  static TextStyle get header1 => GoogleFonts.inter(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    letterSpacing: 1.2,
    color: AppColors.white90,
  );
  
  static TextStyle get header2 => GoogleFonts.inter(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    letterSpacing: 1.0,
    color: AppColors.white90,
  );
  
  // Neural branding text
  static TextStyle get neuralSubtitle => GoogleFonts.inter(
    fontSize: 10,
    fontWeight: FontWeight.w600,
    letterSpacing: 2.0,
    color: AppColors.emerald400,
  );
  
  // Body text
  static TextStyle get bodyMedium => GoogleFonts.inter(
    fontSize: 14,
    color: AppColors.white90,
    height: 1.4,
  );
  
  static TextStyle get bodySmall => GoogleFonts.inter(
    fontSize: 12,
    color: AppColors.white80,
    height: 1.4,
  );
  
  // Caption text
  static TextStyle get caption => GoogleFonts.inter(
    fontSize: 10,
    color: AppColors.white50,
    letterSpacing: 0.5,
  );
  
  static TextStyle get captionWide => GoogleFonts.inter(
    fontSize: 10,
    color: AppColors.white50,
    letterSpacing: 1.5,
  );
  
  // Monospace for data displays
  static TextStyle get mono => GoogleFonts.firaCode(
    fontSize: 12,
    color: AppColors.emerald400,
    fontWeight: FontWeight.w600,
  );
  
  // Button text
  static TextStyle get buttonText => GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.bold,
    letterSpacing: 0.5,
    color: AppColors.black,
  );
  
  // Tab labels
  static TextStyle get tabLabel => GoogleFonts.inter(
    fontSize: 10,
    fontWeight: FontWeight.w600,
    letterSpacing: 1.5,
    color: AppColors.white40,
  );
  
  static TextStyle get tabLabelActive => GoogleFonts.inter(
    fontSize: 10,
    fontWeight: FontWeight.w600,
    letterSpacing: 1.5,
    color: AppColors.emerald400,
  );
}
