import 'package:flutter/material.dart';

import '../models/favorites_store.dart';
import '../theme/app_theme.dart';
import 'pose_brand.dart';
import 'pose_icons.dart';

/// A reusable pose card used in home ("Poses for you") and saved poses.
class PoseCard extends StatefulWidget {
  final String id;
  final String name;
  final String category;
  final String description;
  final Color tint1;
  final Color tint2;
  final VoidCallback? onTry;
  final VoidCallback? onTap;
  final bool favorite;

  const PoseCard({
    super.key,
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.tint1,
    required this.tint2,
    this.onTry,
    this.onTap,
    this.favorite = false,
  });

  @override
  State<PoseCard> createState() => _PoseCardState();
}

class _PoseCardState extends State<PoseCard> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final active = FavoritesStore.instance.isFavorite(widget.id);

    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      onTap: widget.onTap,
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
              colors: [widget.tint1, widget.tint2],
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
              // Pose illustration.
              Positioned.fill(
                child: IgnorePointer(
                  child: Center(
                    child: PoseFigure(
                      height: 110,
                      color: AppColors.text.withValues(alpha: 0.14),
                      sparkleColor: AppColors.text.withValues(alpha: 0.2),
                    ),
                  ),
                ),
              ),

              // Favorite toggle.
              Positioned(
                top: 12,
                right: 12,
                child: GestureDetector(
                  onTap: () => FavoritesStore.instance.toggle(widget.id),
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: AppColors.white.withValues(alpha: 0.92),
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.hairline),
                    ),
                    child: Center(
                      child: PoseIcon(
                        PoseIconType.favorite,
                        size: 16,
                        color: active ? AppColors.brightRose : AppColors.secondaryText,
                      ),
                    ),
                  ),
                ),
              ),

              // Content overlay.
              Positioned(
                left: 14,
                right: 14,
                bottom: 14,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.white.withValues(alpha: 0.85),
                            borderRadius: BorderRadius.circular(AppDimens.radiusChip),
                          ),
                          child: Text(
                            widget.category,
                            style: AppTextStyles.label.copyWith(fontSize: 9.5),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      widget.name,
                      style: AppTextStyles.bodyStrong.copyWith(fontSize: 14.5),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.description,
                      style: AppTextStyles.caption.copyWith(fontSize: 11.5),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
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
