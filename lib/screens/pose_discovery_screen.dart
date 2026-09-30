import 'package:flutter/material.dart';

import '../models/favorites_store.dart';
import '../theme/app_theme.dart';
import '../widgets/pose_buttons.dart';
import '../widgets/pose_brand.dart';
import '../widgets/pose_icons.dart';

/// A browsable collection of pose ideas.
///
/// Images are original pastel placeholder cards (silhouette + gradient)
/// until licensed photography is provided. No external artwork is used.
class PoseDiscoveryScreen extends StatefulWidget {
  const PoseDiscoveryScreen({super.key});

  @override
  State<PoseDiscoveryScreen> createState() => _PoseDiscoveryScreenState();
}

class _PoseDiscoveryScreenState extends State<PoseDiscoveryScreen> {
  static const _categories = [
    'Casual',
    'Cute',
    'Elegant',
    'Standing',
    'Sitting',
    'Mirror Selfie',
    'Outdoor',
    'Cafe',
    'Party',
    'Travel',
  ];

  static const _poses = [
    _Pose(id: 'sunbeam', name: 'Sunbeam', category: 'Casual', tint: 0),
    _Pose(id: 'daydream', name: 'Daydream', category: 'Cute', tint: 1),
    _Pose(id: 'editorial', name: 'Editorial', category: 'Elegant', tint: 2),
    _Pose(
      id: 'first-thing',
      name: 'First Thing',
      category: 'Standing',
      tint: 3,
    ),
    _Pose(id: 'window-seat', name: 'Window Seat', category: 'Sitting', tint: 4),
    _Pose(
      id: 'mirror',
      name: 'Mirror Story',
      category: 'Mirror Selfie',
      tint: 5,
    ),
    _Pose(id: 'golden-hour', name: 'Golden Hour', category: 'Outdoor', tint: 6),
    _Pose(id: 'latte', name: 'Latte Art', category: 'Cafe', tint: 7),
    _Pose(id: 'confetti', name: 'Confetti', category: 'Party', tint: 8),
    _Pose(id: 'wanderlust', name: 'Wanderlust', category: 'Travel', tint: 9),
  ];

  String _selectedCategory = 'Casual';

  @override
  Widget build(BuildContext context) {
    final filtered = _poses
        .where((p) => p.category == _selectedCategory)
        .toList(growable: false);

    return Scaffold(
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

              // Category chips.
              SizedBox(
                height: 40,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _categories.length,
                  separatorBuilder: (_, _) => const SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    final category = _categories[index];
                    final selected = category == _selectedCategory;
                    return _CategoryChip(
                      label: category,
                      selected: selected,
                      onTap: () => setState(() => _selectedCategory = category),
                    );
                  },
                ),
              ),
              const SizedBox(height: 22),

              // Pose cards.
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: filtered.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 14,
                  crossAxisSpacing: 14,
                  childAspectRatio: 0.78,
                ),
                itemBuilder: (context, index) {
                  return _PoseCard(pose: filtered[index]);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CategoryChip extends StatefulWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _CategoryChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  State<_CategoryChip> createState() => _CategoryChipState();
}

class _CategoryChipState extends State<_CategoryChip> {
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
        duration: const Duration(milliseconds: 130),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          decoration: BoxDecoration(
            color: widget.selected ? AppColors.softRose : AppColors.softIvory,
            borderRadius: BorderRadius.circular(AppDimens.radiusChip),
            border: Border.all(
              color: widget.selected ? AppColors.softRose : AppColors.hairline,
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            widget.label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: widget.selected ? FontWeight.w600 : FontWeight.w400,
              color: widget.selected
                  ? AppColors.deepPlum
                  : AppColors.mutedRoseGray,
            ),
          ),
        ),
      ),
    );
  }
}

class _Pose {
  final String id;
  final String name;
  final String category;
  final int tint;

  const _Pose({
    required this.id,
    required this.name,
    required this.category,
    required this.tint,
  });
}

const _tints = [
  [Color(0xFFF8D8CF), Color(0xFFF4B6C2)],
  [Color(0xFFDDD2EA), Color(0xFFF4B6C2)],
  [Color(0xFFF4B6C2), Color(0xFFEFA3B5)],
  [Color(0xFFF8D8CF), Color(0xFFDDD2EA)],
  [Color(0xFFF4B6C2), Color(0xFFF8D8CF)],
  [Color(0xFFDDD2EA), Color(0xFFF8D8CF)],
  [Color(0xFFF8D8CF), Color(0xFFEFA3B5)],
  [Color(0xFFF4B6C2), Color(0xFFDDD2EA)],
  [Color(0xFFEFA3B5), Color(0xFFF8D8CF)],
  [Color(0xFFDDD2EA), Color(0xFFF4B6C2)],
];

class _PoseCard extends StatefulWidget {
  final _Pose pose;

  const _PoseCard({required this.pose});

  @override
  State<_PoseCard> createState() => _PoseCardState();
}

class _PoseCardState extends State<_PoseCard> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final pose = widget.pose;
    final colors = _tints[pose.tint % _tints.length];
    final favorite = FavoritesStore.instance.isFavorite(pose.id);

    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      onTap: () {
        // UI placeholder — pose detail not implemented yet.
      },
      child: AnimatedScale(
        scale: _pressed ? 0.97 : 1.0,
        duration: const Duration(milliseconds: 140),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppDimens.radiusCard),
            border: Border.all(color: AppColors.hairline),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: colors,
            ),
            boxShadow: const [
              BoxShadow(
                color: AppColors.cardShadow,
                blurRadius: 14,
                offset: Offset(0, 6),
              ),
            ],
          ),
          child: Stack(
            children: [
              // Silhouette illustration.
              Positioned.fill(
                child: IgnorePointer(
                  child: Center(
                    child: PoseFigure(
                      height: 130,
                      color: AppColors.deepPlum.withValues(alpha: 0.16),
                      sparkleColor: AppColors.deepPlum.withValues(alpha: 0.22),
                    ),
                  ),
                ),
              ),

              // Favorite button.
              Positioned(
                top: 10,
                right: 10,
                child: _FavoriteButton(id: pose.id, active: favorite),
              ),

              // Label.
              Positioned(
                left: 14,
                right: 14,
                bottom: 12,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      pose.name,
                      style: AppTextStyles.bodyStrong.copyWith(fontSize: 15),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      pose.category,
                      style: AppTextStyles.caption.copyWith(fontSize: 11.5),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FavoriteButton extends StatefulWidget {
  final String id;
  final bool active;

  const _FavoriteButton({required this.id, required this.active});

  @override
  State<_FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<_FavoriteButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      onTap: () => FavoritesStore.instance.toggle(widget.id),
      child: AnimatedScale(
        scale: _pressed ? 0.85 : 1.0,
        duration: const Duration(milliseconds: 130),
        child: Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            color: AppColors.softIvory.withValues(alpha: 0.92),
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.hairline),
          ),
          child: Center(
            child: PoseIcon(
              PoseIconType.favorite,
              size: 17,
              color: widget.active
                  ? AppColors.dustyRose
                  : AppColors.mutedRoseGray,
            ),
          ),
        ),
      ),
    );
  }
}
