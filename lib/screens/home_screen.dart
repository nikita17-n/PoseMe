import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../utils/pose_page_route.dart';
import '../widgets/pose_buttons.dart';
import '../widgets/pose_brand.dart';
import '../widgets/pose_icons.dart';
import 'pose_discovery_screen.dart';
import 'pose_setup_screen.dart';

/// PoseMe home screen — the first impression of the app.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _openSetup(BuildContext context) {
    Navigator.of(context)
        .push(PosePageRoute(builder: (_) => const PoseSetupScreen()));
  }

  void _openDiscovery(BuildContext context) {
    Navigator.of(context)
        .push(PosePageRoute(builder: (_) => const PoseDiscoveryScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimens.screenPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 10),
              _TopBar(onSettings: () {}),
              const SizedBox(height: 26),
              const _HeroSection(),
              const SizedBox(height: 34),
              PosePrimaryButton(
                label: 'Find My Pose',
                icon: PoseIconType.sparkle,
                onPressed: () => _openSetup(context),
              ),
              const SizedBox(height: 14),
              PoseSecondaryButton(
                label: 'Explore Poses',
                icon: PoseIconType.pose,
                onPressed: () => _openDiscovery(context),
              ),
              const SizedBox(height: 40),
              _QuickStartSection(
                onUpload: () => _openSetup(context),
                onExplore: () => _openDiscovery(context),
              ),
              const SizedBox(height: 28),
            ],
          ),
        ),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  final VoidCallback onSettings;

  const _TopBar({required this.onSettings});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const PoseLogo(size: 46),
        const SizedBox(width: 12),
        Text('PoseMe', style: AppTextStyles.title.copyWith(fontSize: 23)),
        const Spacer(),
        PoseIconButton(icon: PoseIconType.settings, onPressed: onSettings),
      ],
    );
  }
}

class _HeroSection extends StatelessWidget {
  const _HeroSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Pose like', style: AppTextStyles.display),
                Text('you mean it.', style: AppTextStyles.display),
                SizedBox(height: 14),
                Text(
                  'Your AI-powered pose assistant.',
                  style: AppTextStyles.body,
                ),
              ],
            ),
            const SizedBox(width: 8),
            Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Column(
                children: const [
                  Sparkle(size: 20),
                  SizedBox(height: 10),
                  Sparkle(size: 13, color: AppColors.blushPink),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 26),
        // Decorative illustration — a graceful figure on a soft peach blob.
        Center(
          child: SizedBox(
            height: 210,
            child: Stack(
              alignment: Alignment.center,
              children: [
                const PoseBlob(size: 190, color: AppColors.softPeach),
                const PoseBlob(size: 150, color: AppColors.blushPink),
                const PoseFigure(height: 200),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _QuickStartSection extends StatelessWidget {
  final VoidCallback onUpload;
  final VoidCallback onExplore;

  const _QuickStartSection({required this.onUpload, required this.onExplore});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('QUICK START', style: AppTextStyles.label),
        const SizedBox(height: 16),
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: _QuickCard(
                  icon: PoseIconType.gallery,
                  title: 'Upload a Pose',
                  subtitle: 'From gallery',
                  background: AppColors.softPeach,
                  onTap: onUpload,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _QuickCard(
                  icon: PoseIconType.camera,
                  title: 'Take a Photo',
                  subtitle: 'Use camera',
                  background: AppColors.pastelLavender,
                  onTap: onUpload,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _QuickCard(
                  icon: PoseIconType.sparkle,
                  title: 'AI Pose Ideas',
                  subtitle: 'Get inspired',
                  background: AppColors.blushPink,
                  onTap: onExplore,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _QuickCard extends StatefulWidget {
  final PoseIconType icon;
  final String title;
  final String subtitle;
  final Color background;
  final VoidCallback onTap;

  const _QuickCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.background,
    required this.onTap,
  });

  @override
  State<_QuickCard> createState() => _QuickCardState();
}

class _QuickCardState extends State<_QuickCard> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: _pressed ? 0.96 : 1.0,
        duration: const Duration(milliseconds: 140),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          decoration: BoxDecoration(
            color: widget.background,
            borderRadius: BorderRadius.circular(AppDimens.radiusCard),
            border: Border.all(color: AppColors.hairline),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PoseIcon(widget.icon, size: 24, color: AppColors.deepPlum),
              const SizedBox(height: 12),
              Text(
                widget.title,
                style: AppTextStyles.bodyStrong.copyWith(fontSize: 13.5),
              ),
              const SizedBox(height: 2),
              Text(
                widget.subtitle,
                style: AppTextStyles.caption.copyWith(fontSize: 11.5),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
