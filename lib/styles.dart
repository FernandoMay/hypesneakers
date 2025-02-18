import 'package:flutter/cupertino.dart';

class AppColors {
  // Primary colors
  static const Color primary = Color(0xFF000000);
  static const Color secondary = Color(0xFF1E1E1E);
  static const Color accent = Color(0xFFFF4D4D);
  
  // Background colors
  static const Color background = Color(0xFFFAFAFA);
  static const Color cardBackground = Color(0xFFFFFFFF);
  static const Color darkBackground = Color(0xFF121212);
  
  // Text colors
  static const Color textPrimary = Color(0xFF1E1E1E);
  static const Color textSecondary = Color(0xFF666666);
  static const Color textLight = Color(0xFF999999);
  
  // Status colors
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFFF4D4D);
  static const Color warning = Color(0xFFFFB74D);
  
  // Gradient colors
  static const Color gradientStart = Color(0xFF000000);
  static const Color gradientEnd = Color(0xFF1E1E1E);
  
  // UI Element colors
  static const Color divider = Color(0xFFE0E0E0);
  static const Color shadow = Color(0x1A000000);
  static const Color shimmerBase = Color(0xFFE0E0E0);
  static const Color shimmerHighlight = Color(0xFFF5F5F5);
}

class AppTextStyles {
  static const TextStyle displayLarge = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    letterSpacing: -0.5,
  );

  static const TextStyle displayMedium = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    letterSpacing: -0.5,
  );

  static const TextStyle titleLarge = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  static const TextStyle titleMedium = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static const TextStyle titleSmall = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    color: AppColors.textSecondary,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    color: AppColors.textSecondary,
  );

  static const TextStyle bodySmall = TextStyle(
    fontSize: 12,
    color: AppColors.textLight,
  );

  static const TextStyle price = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: AppColors.accent,
  );

  static const TextStyle button = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.cardBackground,
  );
}

class AppTheme {
  static CupertinoThemeData theme = const CupertinoThemeData(
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.background,
    barBackgroundColor: AppColors.cardBackground,
    textTheme: CupertinoTextThemeData(
      primaryColor: AppColors.textPrimary,
      textStyle: TextStyle(
        color: AppColors.textPrimary,
        fontSize: 16,
      ),
    ),
  );

  static BoxDecoration cardDecoration = BoxDecoration(
    color: AppColors.cardBackground,
    borderRadius: BorderRadius.circular(16),
    boxShadow: [
      BoxShadow(
        color: AppColors.shadow,
        blurRadius: 20,
        offset: const Offset(0, 4),
      ),
    ],
  );

  static BoxDecoration gradientBackground = const BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        AppColors.gradientStart,
        AppColors.gradientEnd,
      ],
    ),
  );

  static EdgeInsets padding = const EdgeInsets.all(16);
  static EdgeInsets paddingHorizontal = const EdgeInsets.symmetric(horizontal: 16);
  static EdgeInsets paddingVertical = const EdgeInsets.symmetric(vertical: 16);

  static BorderRadius borderRadius = BorderRadius.circular(16);
  static BorderRadius borderRadiusSmall = BorderRadius.circular(8);
  static BorderRadius borderRadiusLarge = BorderRadius.circular(24);

  static Duration animationDuration = const Duration(milliseconds: 300);
  static Curve animationCurve = Curves.easeInOut;
}

class AppGradients {
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      AppColors.gradientStart,
      AppColors.gradientEnd,
    ],
  );

  static const LinearGradient accentGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      AppColors.accent,
      Color(0xFFFF8080),
    ],
  );
}

class AppAnimations {
  static const Duration fast = Duration(milliseconds: 300);
  static const Duration medium = Duration(milliseconds: 500);
  static const Duration slow = Duration(milliseconds: 700);

  static const Curve defaultCurve = Curves.easeInOut;
  static const Curve bouncy = Curves.elasticOut;
  static const Curve smooth = Curves.easeOutCubic;
}
