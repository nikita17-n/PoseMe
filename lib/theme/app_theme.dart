import 'package:flutter/material.dart';

/// Centralized PoseMe palette — soft pastel pinks, warm creams, deep plum.
///
/// Every screen should pull colors from here so the pastel design stays
/// consistent across the whole app.
class AppColors {
  AppColors._();

  // Primary pinks
  static const Color blushPink = Color(0xFFF4B6C2);
  static const Color softRose = Color(0xFFEFA3B5);

  // Backgrounds
  static const Color warmCream = Color(0xFFFFF9F7);
  static const Color softIvory = Color(0xFFFFFDFB);

  // Secondary
  static const Color dustyRose = Color(0xFFD98FA3);
  static const Color mauve = Color(0xFFB98295);

  // Accents
  static const Color softPeach = Color(0xFFF8D8CF);
  static const Color pastelLavender = Color(0xFFDDD2EA);

  // Text
  static const Color deepPlum = Color(0xFF3B2733);
  static const Color mutedRoseGray = Color(0xFF806875);

  // Semantic
  static const Color softSage = Color(0xFFB8D8C0);

  // Lines & surfaces
  static const Color hairline = Color(0xFFF3E4E4);
  static const Color cardShadow = Color(0x14B98295);
}

/// Shared spacing / sizing values so layouts stay balanced on small screens.
class AppDimens {
  AppDimens._();

  static const double radiusCard = 22;
  static const double radiusImage = 26;
  static const double radiusButton = 16;
  static const double radiusChip = 999;

  static const double screenPadding = 22;
  static const double sectionGap = 30;
}

/// Centralized text styles.
///
/// Headings use a serif family for an editorial, fashion-magazine feel;
/// body text stays in the clean default sans-serif for readability.
class AppTextStyles {
  AppTextStyles._();

  static const String _serif = 'serif';

  static const TextStyle display = TextStyle(
    fontFamily: _serif,
    fontSize: 36,
    fontWeight: FontWeight.w600,
    color: AppColors.deepPlum,
    height: 1.15,
    letterSpacing: -0.5,
  );

  static const TextStyle heading = TextStyle(
    fontFamily: _serif,
    fontSize: 27,
    fontWeight: FontWeight.w600,
    color: AppColors.deepPlum,
    height: 1.2,
    letterSpacing: -0.3,
  );

  static const TextStyle title = TextStyle(
    fontFamily: _serif,
    fontSize: 21,
    fontWeight: FontWeight.w600,
    color: AppColors.deepPlum,
    height: 1.25,
  );

  static const TextStyle body = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: AppColors.mutedRoseGray,
    height: 1.55,
  );

  static const TextStyle bodyStrong = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w500,
    color: AppColors.deepPlum,
    height: 1.5,
  );

  static const TextStyle button = TextStyle(
    fontSize: 15.5,
    fontWeight: FontWeight.w500,
    color: AppColors.deepPlum,
    letterSpacing: 0.2,
  );

  static const TextStyle label = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: AppColors.dustyRose,
    letterSpacing: 1.4,
  );

  static const TextStyle caption = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: AppColors.mutedRoseGray,
    height: 1.45,
  );
}

/// Builds the global [ThemeData] for PoseMe.
class AppTheme {
  AppTheme._();

  static ThemeData get light {
    final base = ThemeData.light(useMaterial3: true);

    return base.copyWith(
      scaffoldBackgroundColor: AppColors.warmCream,
      colorScheme: base.colorScheme.copyWith(
        primary: AppColors.softRose,
        onPrimary: AppColors.deepPlum,
        secondary: AppColors.dustyRose,
        onSecondary: AppColors.softIvory,
        surface: AppColors.softIvory,
        onSurface: AppColors.deepPlum,
        error: AppColors.mauve,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.warmCream,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(color: AppColors.deepPlum),
        titleTextStyle: TextStyle(
          fontFamily: 'serif',
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: AppColors.deepPlum,
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.hairline,
        thickness: 1,
        space: 1,
      ),
      snackBarTheme: const SnackBarThemeData(
        backgroundColor: AppColors.deepPlum,
        contentTextStyle: TextStyle(color: AppColors.softIvory),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
