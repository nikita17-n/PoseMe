import 'package:flutter/material.dart';

import '../models/favorites_store.dart';
import '../models/pose_item.dart';
import '../theme/app_theme.dart';
import '../utils/pose_page_route.dart';
import '../widgets/pose_buttons.dart';
import '../widgets/pose_brand.dart';
import '../widgets/pose_icons.dart';
import 'live_camera_screen.dart';

/// Pose Details / Reference screen — large image with organized info below.
class PoseDetailsScreen extends StatefulWidget {
  final PoseItem pose;

  const PoseDetailsScreen({super.key, required this.pose});

  @override
  State<PoseDetailsScreen> createState() => _PoseDetailsScreenState();
}

class _PoseDetailsScreenState extends State<PoseDetailsScreen> {
  bool _saved = false;

  @override
  void initState() {
    super.initState();
    _saved = FavoritesStore.instance.isFavorite(widget.pose.id);
  }

  void _toggleSave() {
    setState(() {
      _saved = !_saved;
    });
    FavoritesStore.instance.toggle(widget.pose.id);
  }

  void _tryPose() {
    // Camera is the entry point to trying the pose; real detection is a
    // placeholder until a camera plugin is integrated.
    Navigator.of(context).push(
      PosePageRoute(builder: (_) => const LiveCameraScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: PoseIconButton(
          icon: PoseIconType.back,
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        actions: [
          PoseIconButton(
            icon: PoseIconType.favorite,
            color: _saved ? AppColors.brightRose : AppColors.secondaryText,
            background: _saved
                ? AppColors.lightBlush.withValues(alpha: 0.5)
                : null,
            onPressed: _toggleSave,
            size: 40,
            iconSize: 20,
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            AppDimens.screenPadding,
            0,
            AppDimens.screenPadding,
            24,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Large pose reference image.
              ClipRRect(
                borderRadius: BorderRadius.circular(AppDimens.radiusImage),
                child: Container(
                  height: 320,
                  decoration: BoxDecoration(
                    color: widget.pose.tint1,
                    border: Border.all(color: AppColors.hairline),
                    borderRadius: BorderRadius.circular(AppDimens.radiusImage),
                    boxShadow: const [
                      BoxShadow(
                        color: AppColors.cardShadow,
                        blurRadius: 18,
                        offset: Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      Center(
                        child: PoseFigure(
                          height: 200,
                          color: AppColors.text.withValues(alpha: 0.16),
                          sparkleColor: AppColors.text.withValues(alpha: 0.22),
                        ),
                      ),
                      Positioned(
                        top: 12,
                        right: 12,
                        child: PoseIcon(
                          PoseIconType.sparkle,
                          size: 20,
                          color: AppColors.brightRose,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Pose name + category.
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(AppDimens.radiusChip),
                      border: Border.all(color: AppColors.hairline),
                    ),
                    child: Text(
                      widget.pose.category,
                      style: AppTextStyles.label.copyWith(fontSize: 10),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                widget.pose.name,
                style: AppTextStyles.heading.copyWith(fontSize: 26),
              ),
              const SizedBox(height: 10),
              // Difficulty row.
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(AppDimens.radiusCard),
                  border: Border.all(color: AppColors.hairline),
                ),
                child: Row(
                  children: [
                    PoseIcon(
                      PoseIconType.body,
                      size: 18,
                      color: AppColors.brightRose,
                    ),
                    const SizedBox(width: 10),
                    const Text('Difficulty Level'),
                    const Spacer(),
                    Text(
                      'Beginner',
                      style: AppTextStyles.bodyStrong.copyWith(
                        color: AppColors.text,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Description.
              Text(
                'About this pose',
                style: AppTextStyles.label,
              ),
              const SizedBox(height: 8),
              Text(
                widget.pose.description,
                style: AppTextStyles.body,
              ),
              const SizedBox(height: 20),
              // Instructions.
              Text(
                'How to do it',
                style: AppTextStyles.label,
              ),
              const SizedBox(height: 8),
              _InstructionStep(
                number: 1,
                text: 'Stand relaxed with shoulders back.',
              ),
              _InstructionStep(
                number: 2,
                text: 'Angle your body slightly to the side.',
              ),
              _InstructionStep(
                number: 3,
                text: 'Place one hand gently on your hip.',
              ),
              const SizedBox(height: 26),
              // Primary action: Try This Pose (opens camera).
              PosePrimaryButton(
                label: 'Try This Pose',
                icon: PoseIconType.camera,
                onPressed: _tryPose,
              ),
              const SizedBox(height: 12),
              // Secondary action: Save Pose.
              PoseSecondaryButton(
                label: _saved ? 'Saved' : 'Save Pose',
                icon: PoseIconType.favorite,
                onPressed: _toggleSave,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class _InstructionStep extends StatelessWidget {
  final int number;
  final String text;

  const _InstructionStep({required this.number, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.hairline),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: AppColors.primaryPink,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '$number',
                style: const TextStyle(
                  color: AppColors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: AppTextStyles.bodyStrong,
            ),
          ),
        ],
      ),
    );
  }
}

