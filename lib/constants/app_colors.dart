import 'package:flutter/material.dart';

class AppColors {
  // Neural theme colors matching React app
  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);
  
  // Emerald palette 
  static const Color emerald400 = Color(0xFF34D399);
  static const Color emerald500 = Color(0xFF10B981);
  static const Color emerald600 = Color(0xFF059669);
  
  // Cyan palette
  static const Color cyan400 = Color(0xFF22D3EE);
  static const Color cyan500 = Color(0xFF06B6D4);
  
  // Purple palette
  static const Color purple400 = Color(0xFFA855F7);
  static const Color purple500 = Color(0xFF8B5CF6);
  
  // Rose palette
  static const Color rose400 = Color(0xFFF87171);
  static const Color rose500 = Color(0xFFF43F5E);
  static const Color rose600 = Color(0xFFE11D48);
  
  // Amber palette
  static const Color amber400 = Color(0xFFFBBF24);
  static const Color amber500 = Color(0xFFF59E0B);
  static const Color amber600 = Color(0xFFD97706);
  
  // Yellow palette
  static const Color yellow400 = Color(0xFFFDE047);
  static const Color yellow500 = Color(0xFFEAB308);
  
  // Slate palette
  static const Color slate300 = Color(0xFFCBD5E1);
  static const Color slate400 = Color(0xFF94A3B8);
  static const Color slate500 = Color(0xFF64748B);
  
  // Blue palette
  static const Color blue500 = Color(0xFF3B82F6);
  
  // Pink palette
  static const Color pink400 = Color(0xFFF472B6);
  static const Color pink500 = Color(0xFFEC4899);
  
  // Indigo palette
  static const Color indigo500 = Color(0xFF6366F1);
  
  // Orange palette
  static const Color orange500 = Color(0xFFF97316);
  
  // Red palette
  static const Color red500 = Color(0xFFEF4444);
  static const Color red600 = Color(0xFFDC2626);
  
  // Green palette
  static const Color green500 = Color(0xFF22C55E);
  
  // Missing color definitions
  static const Color red400 = Color(0xFFF87171);
  static const Color purple200 = Color(0xFFDDD6FE);
  static const Color purple300 = Color(0xFFC4B5FD);
  static const Color indigo200 = Color(0xFFC7D2FE);
  static const Color indigo300 = Color(0xFFA5B4FC);
  static const Color emerald300 = Color(0xFF6EE7B7);
  static const Color cyan300 = Color(0xFF67E8F9);
  static const Color rose200 = Color(0xFFFECDD3);
  static const Color pink200 = Color(0xFFFBCFE8);
  static const Color red200 = Color(0xFFFECACA);
  static const Color red300 = Color(0xFFF87171);
  static const Color amber200 = Color(0xFFFDE68A);
  static const Color amber300 = Color(0xFFFCD34D);
  static const Color slate200 = Color(0xFFE2E8F0);
  
  // Additional color variants
  static const Color black40 = Color(0x66000000);
  static const Color black50 = Color(0x80000000);
  static const Color black70 = Color(0xB3000000);
  static const Color white05 = Color(0x0DFFFFFF);
  static const Color white15 = Color(0x26FFFFFF);
  static const Color white35 = Color(0x59FFFFFF);
  static const Color white45 = Color(0x73FFFFFF);
  static const Color white85 = Color(0xD9FFFFFF);
  static const Color white95 = Color(0xF2FFFFFF);
  
  // White with opacity
  static const Color white10 = Color(0x1AFFFFFF);
  static const Color white20 = Color(0x33FFFFFF);
  static const Color white30 = Color(0x4DFFFFFF);
  static const Color white40 = Color(0x66FFFFFF);
  static const Color white50 = Color(0x80FFFFFF);
  static const Color white60 = Color(0x99FFFFFF);
  static const Color white70 = Color(0xB3FFFFFF);
  static const Color white80 = Color(0xCCFFFFFF);
  static const Color white90 = Color(0xE6FFFFFF);
  
  // Black with opacity  
  static const Color black60 = Color(0x99000000);
  static const Color black80 = Color(0xCC000000);
  static const Color black90 = Color(0xE6000000);
  
  // Emerald with opacity
  static const Color emerald400_50 = Color(0x8034D399);
  static const Color emerald400_30 = Color(0x4D34D399);
  static const Color emerald500_10 = Color(0x1A10B981);
  static const Color emerald500_20 = Color(0x3310B981);
  
  // Gradients
  static const LinearGradient emeraldGradient = LinearGradient(
    colors: [emerald500, cyan500],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
  
  static const LinearGradient neuralGradient = LinearGradient(
    colors: [emerald400, cyan400, purple400],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
  
  // Mode-specific backdrop palettes
  static const Map<String, Map<String, Color>> modePalettes = {
    'CALM': {
      'main': Color(0x3810B981),
      'secondary': Color(0x2922D3EE), 
      'tertiary': Color(0x238B5CF6),
    },
    'HYPERFOCUS': {
      'main': Color(0x4722D3EE),
      'secondary': Color(0x3334D399),
      'tertiary': Color(0x2D3B82F6),
    },
    'DANGER': {
      'main': Color(0x4DEF4444),
      'secondary': Color(0x38FBBF24),
      'tertiary': Color(0x338B5CF6),
    },
    'WITHDRAWAL': {
      'main': Color(0x4264748B),
      'secondary': Color(0x2422D3EE),
      'tertiary': Color(0x296366F1),
    },
    'TRANSCENDENT': {
      'main': Color(0x528B5CF6),
      'secondary': Color(0x3DF472B6),
      'tertiary': Color(0x3322D3EE),
    },
    'COLLAPSE': {
      'main': Color(0x66DC2626),
      'secondary': Color(0x4DF97316),
      'tertiary': Color(0x40E11D48),
    },
  };
  
  // System mode colors
  static Color getSystemModeColor(String mode) {
    switch (mode) {
      case 'COLLAPSE':
        return red500;
      case 'DANGER':
        return rose400;
      case 'HYPERFOCUS':
        return cyan400;
      case 'TRANSCENDENT':
        return purple400;
      case 'WITHDRAWAL':
        return slate300;
      default:
        return emerald400;
    }
  }
}
