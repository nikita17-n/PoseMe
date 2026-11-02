import 'package:flutter/material.dart';

import '../models/pose_item.dart';
import '../theme/app_theme.dart';
import '../utils/pose_page_route.dart';
import '../widgets/pose_buttons.dart';
import '../widgets/pose_card.dart';
import '../widgets/pose_icons.dart';
import 'pose_details_screen.dart';

/// Explore screen — mood-based pose browsing.
class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final List<_Mood> _moods = const [
    _Mood('Soft & Aesthetic', AppColors.lightBlush),
    _Mood('Casual', AppColors.softLavender),
    _Mood('Elegant', AppColors.primaryPink),
    _Mood('Pinterest Inspired', AppColors.lightBlush),
    _Mood('Cute & Playful', AppColors.softLavender),
    _Mood('Mirror Selfie', AppColors.primaryPink),
    _Mood('Outdoor', AppColors.softLavender),
    _Mood('Travel', AppColors.lightBlush),
  ];

  final List<PoseItem> _poses = const [
    PoseItem(
      id: 'sunbeam',
      name: 'Sunbeam',
      category: 'Casual',
      description: 'A relaxed, natural standing pose.',
      tint1: AppColors.lightBlush,
      tint2: AppColors.primaryPink,
    ),
    PoseItem(
      id: 'daydream',
      name: 'Daydream',
      category: 'Cute',
      description: 'Soft gaze with a gentle tilt of the head.',
      tint1: AppColors.softLavender,
      tint2: AppColors.primaryPink,
    ),
    PoseItem(
      id: 'editorial',
      name: 'Editorial',
      category: 'Elegant',
      description: 'Confident posture with one hand on hip.',
      tint1: AppColors.primaryPink,
      tint2: AppColors.brightRose,
    ),
    PoseItem(
      id: 'mirror',
      name: 'Mirror Story',
      category: 'Mirror Selfie',
      description: 'Casual mirror selfie with soft lighting.',
      tint1: AppColors.lightBlush,
      tint2: AppColors.softLavender,
    ),
    PoseItem(
      id: 'golden-hour',
      name: 'Golden Hour',
      category: 'Outdoor',
      description: 'Warm outdoor pose at sunset.',
      tint1: AppColors.primaryPink,
      tint2: AppColors.lightBlush,
    ),
    PoseItem(
      id: 'wanderlust',
      name: 'Wanderlust',
      category: 'Travel',
      description: 'Carefree travel pose with a smile.',
      tint1: AppColors.softLavender,
      tint2: AppColors.primaryPink,
    ),
  ];

  void _openPoseDetails(PoseItem pose) {
    Navigator.of(context).push(
      PosePageRoute(builder: (_) => PoseDetailsScreen(pose: pose)),
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
        title: const Text('Explore Poses'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            AppDimens.screenPadding,
            4,
            AppDimens.screenPadding,
            24,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Explore Poses', style: AppTextStyles.heading),
              const SizedBox(height: 8),
              const Text(
                'Find a pose that fits your mood.',
                style: AppTextStyles.body,
              ),
              const SizedBox(height: 22),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: _moods.map((mood) {
                  return _MoodChip(
                    label: mood.label,
                    color: mood.color,
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('${mood.label} coming soon.')),
                      );
                    },
                  );
                }).toList(growable: false),
              ),
              const SizedBox(height: 26),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _poses.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 14,
                  crossAxisSpacing: 14,
                  childAspectRatio: 0.78,
                ),
                itemBuilder: (context, index) {
                  return SizedBox(
                    width: double.infinity,
                    child: PoseCard(
                      id: _poses[index].id,
                      name: _poses[index].name,
                      category: _poses[index].category,
                      description: _poses[index].description,
                      tint1: _poses[index].tint1,
                      tint2: _poses[index].tint2,
                      onTap: () => _openPoseDetails(_poses[index]),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Mood {
  final String label;
  final Color color;

  const _Mood(this.label, this.color);
}

class _MoodChip extends StatefulWidget {
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _MoodChip({
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  State<_MoodChip> createState() => _MoodChipState();
}

class _MoodChipState extends State<_MoodChip> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: _pressed ? 0.94 : 1.0,
        duration: const Duration(milliseconds: 140),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
          decoration: BoxDecoration(
            color: _pressed ? AppColors.primaryPink : AppColors.white,
            borderRadius: BorderRadius.circular(AppDimens.radiusChip),
            border: Border.all(
              color: _pressed ? AppColors.primaryPink : AppColors.hairline,
            ),
          ),
          child: Text(
            widget.label,
            style: AppTextStyles.caption.copyWith(
              color: _pressed ? AppColors.white : AppColors.secondaryText,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
