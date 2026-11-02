import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../utils/pose_page_route.dart';
import '../widgets/pose_buttons.dart';
import '../widgets/pose_brand.dart';
import '../widgets/pose_icons.dart';
import 'home_screen.dart';

/// Welcome / Splash screen — centered branding with a "Get Started" CTA.
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimens.screenPadding,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 20),
                // Logo + decorative sparkles.
                Column(
                  children: [
                    const PoseLogo(size: 72),
                    const SizedBox(height: 16),
                    const Sparkle(size: 18),
                  ],
                ),
                const SizedBox(height: 40),
                Text(
                  'Your Perfect Pose,',
                  style: AppTextStyles.display.copyWith(fontSize: 28),
                  textAlign: TextAlign.center,
                ),
                Text(
                  'Every Time',
                  style: AppTextStyles.display.copyWith(fontSize: 28),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 14),
                Text(
                  'Find your pose. Capture your moment.',
                  style: AppTextStyles.body,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                PosePrimaryButton(
                  label: 'Get Started',
                  icon: PoseIconType.sparkle,
                  onPressed: () {
                    Navigator.of(context).push(
                      PosePageRoute(builder: (_) => const HomeScreen()),
                    );
                  },
                ),
                const SizedBox(height: 16),
                PoseSecondaryButton(
                  label: 'I already have an account',
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Sign in is coming soon.'),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 28),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
