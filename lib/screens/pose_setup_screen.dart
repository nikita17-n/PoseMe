import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../theme/app_theme.dart';
import '../utils/pose_page_route.dart';
import '../widgets/pose_buttons.dart';
import '../widgets/pose_brand.dart';
import '../widgets/pose_icons.dart';
import 'reference_pose_screen.dart';

/// Lets the user choose how to provide a reference pose:
/// upload from gallery or capture with the camera.
class PoseSetupScreen extends StatefulWidget {
  const PoseSetupScreen({super.key});

  @override
  State<PoseSetupScreen> createState() => _PoseSetupScreenState();
}

class _PoseSetupScreenState extends State<PoseSetupScreen> {
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
    if (image == null || !mounted) return;

    Navigator.of(context).push(
      PosePageRoute(
        builder: (_) => ReferencePoseScreen(imageFile: File(image.path)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: PoseIconButton(
          icon: PoseIconType.back,
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        title: const Text('Pose Setup'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimens.screenPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 8),
              Text(
                "Let's find your perfect pose",
                style: AppTextStyles.heading,
              ),
              const SizedBox(height: 10),
              const Text(
                'Give me a pose to work with.',
                style: AppTextStyles.body,
              ),
              const SizedBox(height: 30),
              _SetupCard(
                icon: PoseIconType.gallery,
                title: 'UPLOAD A POSE',
                subtitle: 'Choose a photo from your gallery',
                background: AppColors.softPeach,
                iconColor: AppColors.dustyRose,
                onTap: () => _pickImage(ImageSource.gallery),
              ),
              const SizedBox(height: 16),
              _SetupCard(
                icon: PoseIconType.camera,
                title: 'TAKE A PHOTO',
                subtitle: 'Capture your reference pose',
                background: AppColors.pastelLavender,
                iconColor: AppColors.mauve,
                onTap: () => _pickImage(ImageSource.camera),
              ),
              const SizedBox(height: 34),
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Sparkle(size: 15, color: AppColors.blushPink),
                    SizedBox(width: 10),
                    Text(
                      'Full-body photos work best',
                      style: AppTextStyles.caption,
                    ),
                    SizedBox(width: 10),
                    Sparkle(size: 15, color: AppColors.blushPink),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class _SetupCard extends StatefulWidget {
  final PoseIconType icon;
  final String title;
  final String subtitle;
  final Color background;
  final Color iconColor;
  final VoidCallback onTap;

  const _SetupCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.background,
    required this.iconColor,
    required this.onTap,
  });

  @override
  State<_SetupCard> createState() => _SetupCardState();
}

class _SetupCardState extends State<_SetupCard> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: _pressed ? 0.98 : 1.0,
        duration: const Duration(milliseconds: 150),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 24),
          decoration: BoxDecoration(
            color: widget.background,
            borderRadius: BorderRadius.circular(AppDimens.radiusCard),
            border: Border.all(color: AppColors.hairline),
            boxShadow: const [
              BoxShadow(
                color: AppColors.cardShadow,
                blurRadius: 16,
                offset: Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                  color: AppColors.softIvory,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.hairline),
                ),
                child: Center(
                  child: PoseIcon(
                    widget.icon,
                    size: 26,
                    color: widget.iconColor,
                  ),
                ),
              ),
              const SizedBox(width: 18),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.title, style: AppTextStyles.label),
                    const SizedBox(height: 6),
                    Text(widget.subtitle, style: AppTextStyles.bodyStrong),
                  ],
                ),
              ),
              const PoseIcon(
                PoseIconType.back,
                size: 18,
                color: AppColors.mutedRoseGray,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
