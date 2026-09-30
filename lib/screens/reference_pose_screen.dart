import 'dart:io';

import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../utils/pose_page_route.dart';
import '../widgets/pose_buttons.dart';
import '../widgets/pose_brand.dart';
import '../widgets/pose_icons.dart';
import 'pose_analysis_screen.dart';

/// Shows the chosen reference image and asks the user to confirm
/// before running pose analysis.
class ReferencePoseScreen extends StatelessWidget {
  final File imageFile;

  const ReferencePoseScreen({super.key, required this.imageFile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: PoseIconButton(
          icon: PoseIconType.back,
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        title: const Text('Reference Pose'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimens.screenPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 4),
              Text('Your Reference Pose', style: AppTextStyles.heading),
              const SizedBox(height: 22),
              ClipRRect(
                borderRadius: BorderRadius.circular(AppDimens.radiusImage),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.hairline),
                    borderRadius: BorderRadius.circular(AppDimens.radiusImage),
                    boxShadow: const [
                      BoxShadow(
                        color: AppColors.cardShadow,
                        blurRadius: 22,
                        offset: Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Image.file(
                    imageFile,
                    height: 380,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 26),
              Row(
                children: const [
                  Sparkle(size: 16),
                  SizedBox(width: 10),
                  Text('Looks good?', style: AppTextStyles.bodyStrong),
                ],
              ),
              const SizedBox(height: 20),
              PosePrimaryButton(
                label: 'Analyze Pose',
                icon: PoseIconType.sparkle,
                onPressed: () {
                  Navigator.of(context).push(
                    PosePageRoute(
                      builder: (_) => PoseAnalysisScreen(imageFile: imageFile),
                    ),
                  );
                },
              ),
              const SizedBox(height: 14),
              PoseSecondaryButton(
                label: 'Choose Another',
                icon: PoseIconType.gallery,
                onPressed: () => Navigator.of(context).maybePop(),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
