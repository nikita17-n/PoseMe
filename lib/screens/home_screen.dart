import 'package:flutter/material.dart';

import '../models/pose_item.dart';
import '../theme/app_theme.dart';
import '../utils/pose_page_route.dart';
import '../widgets/pose_buttons.dart';
import '../widgets/pose_card.dart';
import '../widgets/pose_icons.dart';
import '../widgets/pose_search.dart';
import 'explore_screen.dart';
import 'pose_details_screen.dart';

/// Home Dashboard — greeting, search, shortcuts, featured poses and moods.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<_Shortcut> _shortcuts = const [
    _Shortcut('Selfie', PoseIconType.camera, AppColors.lightBlush),
    _Shortcut('Sitting', PoseIconType.pose, AppColors.softLavender),
    _Shortcut('Standing', PoseIconType.body, AppColors.lightBlush),
    _Shortcut('Mirror', PoseIconType.pose, AppColors.softLavender),
    _Shortcut('Outdoor', PoseIconType.pose, AppColors.lightBlush),
    _Shortcut('Couple', PoseIconType.body, AppColors.softLavender),
  ];

  final List<PoseItem> _posesForYou = const [
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
  ];

  final List<_Mood> _moods = const [
    _Mood('Soft & Aesthetic', AppColors.lightBlush),
    _Mood('Casual', AppColors.softLavender),
    _Mood('Elegant', AppColors.primaryPink),
    _Mood('Pinterest Inspired', AppColors.lightBlush),
    _Mood('Cute & Playful', AppColors.softLavender),
  ];

  void _openPoseDetails(PoseItem pose) {
    Navigator.of(context).push(
      PosePageRoute(
        builder: (_) => PoseDetailsScreen(pose: pose),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimens.screenPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 8),
              // Top bar: profile/menu icon.
              Row(
                children: [
                  PoseIconButton(
                    icon: PoseIconType.profile,
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Profile coming soon.')),
                      );
                    },
                  ),
                  const Spacer(),
                  PoseIconButton(
                    icon: PoseIconType.settings,
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Settings coming soon.')),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 24),
              // Greeting.
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            style: AppTextStyles.heading,
                            children: [
                              const TextSpan(text: 'Hey, beautiful! '),
                              TextSpan(
                                text: '♡',
                                style: TextStyle(
                                  color: AppColors.brightRose,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Ready to capture your perfect moment?',
                          style: AppTextStyles.body,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 22),
              // Search bar.
              PoseSearch(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Search coming soon.')),
                  );
                },
              ),
              const SizedBox(height: 24),
              // Category shortcuts.
              Text('Quick Capture', style: AppTextStyles.label),
              const SizedBox(height: 10),
              SizedBox(
                height: 74,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _shortcuts.length,
                  separatorBuilder: (_, _) => const SizedBox(width: 10),
                  itemBuilder: (context, index) {
                    final s = _shortcuts[index];
                    return _ShortcutChip(
                      label: s.label,
                      icon: s.icon,
                      color: s.color,
                    );
                  },
                ),
              ),
              const SizedBox(height: 28),
              // Poses for you section.
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Poses for you', style: AppTextStyles.heading),
                  GestureDetector(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('View all coming soon.')),
                      );
                    },
                    child: Text(
                      'See all',
                      style: AppTextStyles.label.copyWith(
                        color: AppColors.primaryPink,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              SizedBox(
                height: 250,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _posesForYou.length,
                  separatorBuilder: (_, _) => const SizedBox(width: 14),
                  itemBuilder: (context, index) {
                    final pose = _posesForYou[index];
                    return SizedBox(
                      width: 172,
                      child: PoseCard(
                        id: pose.id,
                        name: pose.name,
                        category: pose.category,
                        description: pose.description,
                        tint1: pose.tint1,
                        tint2: pose.tint2,
                        onTap: () => _openPoseDetails(pose),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 28),
              // Explore by Mood section.
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Explore by Mood', style: AppTextStyles.heading),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        PosePageRoute(builder: (_) => const ExploreScreen()),
                      );
                    },
                    child: Text(
                      'See all',
                      style: AppTextStyles.label.copyWith(
                        color: AppColors.primaryPink,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: _moods.map((mood) {
                  return _MoodChip(
                    label: mood.label,
                    color: mood.color,
                    onTap: () {
                      Navigator.of(context).push(
                        PosePageRoute(builder: (_) => const ExploreScreen()),
                      );
                    },
                  );
                }).toList(growable: false),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

class _Shortcut {
  final String label;
  final PoseIconType icon;
  final Color color;

  const _Shortcut(this.label, this.icon, this.color);
}

class _ShortcutChip extends StatefulWidget {
  final String label;
  final PoseIconType icon;
  final Color color;

  const _ShortcutChip({
    required this.label,
    required this.icon,
    required this.color,
  });

  @override
  State<_ShortcutChip> createState() => _ShortcutChipState();
}

class _ShortcutChipState extends State<_ShortcutChip> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${widget.label} coming soon.')),
        );
      },
      child: AnimatedScale(
        scale: _pressed ? 0.94 : 1.0,
        duration: const Duration(milliseconds: 140),
        child: Container(
          width: 84,
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: widget.color.withValues(alpha: 0.55),
            borderRadius: BorderRadius.circular(AppDimens.radiusCard),
            border: Border.all(color: AppColors.hairline),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              PoseIcon(widget.icon, size: 20, color: AppColors.text),
              const SizedBox(height: 6),
              Text(
                widget.label,
                style: AppTextStyles.label.copyWith(
                  color: AppColors.text,
                  fontSize: 11,
                ),
                textAlign: TextAlign.center,
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
