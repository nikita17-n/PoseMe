import 'package:flutter/material.dart';

/// Centralized PoseMe palette — soft pastel pinks matching the reference design.
///
/// Every screen pulls colors from here so the pastel design stays consistent.
class AppColors {
  AppColors._();

  // Primary pinks
  static const Color primaryPink = Color(0xFFF4A9C0);   // #F4A9C0
  static const Color brightRose = Color(0xFFEC75A0);    // #EC75A0
  static const Color lightBlush = Color(0xFFFCE8EF);    // #FCE8EF
  static const Color dustyRose = Color(0xFFD994AA);     // #D994AA

  // Backgrounds
  static const Color background = Color(0xFFFFF7F9);    // #FFF7F9
  static const Color white = Color(0xFFFFFFFF);         // #FFFFFF
  static const Color softLavender = Color(0xFFE9DFF2);  // #E9DFF2

  // Text
  static const Color text = Color(0xFF49343F);          // #49343F
  static const Color secondaryText = Color(0xFF9B8490); // #9B8490

  // Semantic
  static const Color hairline = Color(0xFFF3E4E4);
  static const Color cardShadow = Color(0x14EC75A0);
}

/// Shared spacing / sizing values.
class AppDimens {
  AppDimens._();

  static const double radiusCard = 20;
  static const double radiusImage = 24;
  static const double radiusButton = 16;
  static const double radiusChip = 999;

  static const double screenPadding = 20;
  static const double sectionGap = 24;
}

/// Centralized text styles.
class AppTextStyles {
  AppTextStyles._();

  static const String _serif = 'serif';

  static const TextStyle display = TextStyle(
    fontFamily: _serif,
    fontSize: 30,
    fontWeight: FontWeight.w600,
    color: AppColors.text,
    height: 1.2,
    letterSpacing: -0.4,
  );

  static const TextStyle heading = TextStyle(
    fontFamily: _serif,
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: AppColors.text,
    height: 1.25,
  );

  static const TextStyle title = TextStyle(
    fontFamily: _serif,
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.text,
    height: 1.3,
  );

  static const TextStyle body = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.secondaryText,
    height: 1.5,
  );

  static const TextStyle bodyStrong = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.text,
    height: 1.5,
  );

  static const TextStyle button = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
    letterSpacing: 0.2,
  );

  static const TextStyle label = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w600,
    color: AppColors.brightRose,
    letterSpacing: 0.8,
  );

  static const TextStyle caption = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.secondaryText,
    height: 1.4,
  );
}

/// Builds the global [ThemeData] for PoseMe.
class AppTheme {
  AppTheme._();

  static ThemeData get light {
    final base = ThemeData.light(useMaterial3: true);

    return base.copyWith(
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: base.colorScheme.copyWith(
        primary: AppColors.primaryPink,
        onPrimary: AppColors.white,
        secondary: AppColors.brightRose,
        onSecondary: AppColors.white,
        surface: AppColors.white,
        onSurface: AppColors.text,
        error: AppColors.dustyRose,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.background,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(color: AppColors.text),
        titleTextStyle: TextStyle(
          fontFamily: 'serif',
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: AppColors.text,
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.hairline,
        thickness: 1,
        space: 1,
      ),
      snackBarTheme: const SnackBarThemeData(
        backgroundColor: AppColors.text,
        contentTextStyle: TextStyle(color: AppColors.white),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
