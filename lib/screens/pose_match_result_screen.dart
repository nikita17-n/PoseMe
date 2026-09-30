import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../utils/pose_page_route.dart';
import '../widgets/pose_buttons.dart';
import '../widgets/pose_brand.dart';
import '../widgets/pose_icons.dart';
import 'pose_discovery_screen.dart';

/// Pose match result — UI placeholder.
///
/// Real pose-match scoring is not implemented yet, so this screen shows
/// the result layout (photo, score ring, breakdown rows, actions)
/// without generating any fake scores. The score area displays an
/// honest "coming soon" state until the matching engine exists.
class PoseMatchResultScreen extends StatelessWidget {
  const PoseMatchResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: PoseIconButton(
          icon: PoseIconType.close,
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        title: const Text('Pose Match'),
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
              Row(
                children: [
                  Expanded(
                    child: Text('That pose ✨', style: AppTextStyles.heading),
                  ),
                  const Sparkle(size: 18),
                ],
              ),
              const SizedBox(height: 22),

              // Captured photo placeholder.
              ClipRRect(
                borderRadius: BorderRadius.circular(AppDimens.radiusImage),
                child: Container(
                  height: 300,
                  decoration: BoxDecoration(
                    color: AppColors.softPeach,
                    border: Border.all(color: AppColors.hairline),
                    borderRadius: BorderRadius.circular(AppDimens.radiusImage),
                  ),
                  child: const Center(child: PoseFigure(height: 240)),
                ),
              ),
              const SizedBox(height: 24),

              // Score card.
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                decoration: BoxDecoration(
                  color: AppColors.softIvory,
                  borderRadius: BorderRadius.circular(AppDimens.radiusCard),
                  border: Border.all(color: AppColors.hairline),
                ),
                child: Column(
                  children: [
                    Text('POSE MATCH', style: AppTextStyles.label),
                    const SizedBox(height: 14),
                    Container(
                      width: 108,
                      height: 108,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.blushPink,
                          width: 5,
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          '—',
                          style: TextStyle(
                            fontSize: 34,
                            fontWeight: FontWeight.w300,
                            color: AppColors.dustyRose,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Score coming soon',
                      style: AppTextStyles.caption,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Breakdown rows (placeholder state).
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: AppColors.softIvory,
                  borderRadius: BorderRadius.circular(AppDimens.radiusCard),
                  border: Border.all(color: AppColors.hairline),
                ),
                child: Column(
                  children: const [
                    _BreakdownRow(label: 'Arms'),
                    _BreakdownRow(label: 'Body angle'),
                    _BreakdownRow(label: 'Legs'),
                    _BreakdownRow(label: 'Position', last: true),
                  ],
                ),
              ),
              const SizedBox(height: 26),

              PosePrimaryButton(
                label: 'Save Photo',
                icon: PoseIconType.favorite,
                onPressed: () {
                  // UI placeholder — saving not implemented yet.
                },
              ),
              const SizedBox(height: 14),
              PoseSecondaryButton(
                label: 'Try Again',
                icon: PoseIconType.flip,
                onPressed: () => Navigator.of(context).maybePop(),
              ),
              const SizedBox(height: 14),
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      PosePageRoute(
                        builder: (_) => const PoseDiscoveryScreen(),
                      ),
                    );
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Text(
                      'Try Another Pose',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.dustyRose,
                        decoration: TextDecoration.underline,
                        decorationColor: AppColors.dustyRose,
                      ),
                    ),
                  ),
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

class _BreakdownRow extends StatelessWidget {
  final String label;
  final bool last;

  const _BreakdownRow({required this.label, this.last = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 13),
      decoration: BoxDecoration(
        border: last
            ? null
            : const Border(bottom: BorderSide(color: AppColors.hairline)),
      ),
      child: Row(
        children: [
          const PoseIcon(
            PoseIconType.check,
            size: 18,
            color: AppColors.blushPink,
          ),
          const SizedBox(width: 12),
          Expanded(child: Text(label, style: AppTextStyles.bodyStrong)),
          Text(
            'pending',
            style: AppTextStyles.caption.copyWith(color: AppColors.blushPink),
          ),
        ],
      ),
    );
  }
}
