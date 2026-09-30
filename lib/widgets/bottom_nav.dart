import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import 'pose_icons.dart';

/// Clean PoseMe bottom navigation.
///
/// The Camera tab is visually emphasized with a raised rose circle.
class PoseBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const PoseBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  static const _tabs = [
    _NavItem(PoseIconType.home, 'Home'),
    _NavItem(PoseIconType.pose, 'Poses'),
    _NavItem(PoseIconType.camera, 'Camera', emphasized: true),
    _NavItem(PoseIconType.favorite, 'Favorites'),
    _NavItem(PoseIconType.profile, 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.softIvory,
        border: Border(top: BorderSide(color: AppColors.hairline, width: 1)),
        boxShadow: [
          BoxShadow(
            color: AppColors.cardShadow,
            blurRadius: 20,
            offset: Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 68,
          child: Row(
            children: [
              for (var i = 0; i < _tabs.length; i++)
                Expanded(
                  child: _NavButton(
                    item: _tabs[i],
                    selected: i == currentIndex,
                    onTap: () => onTap(i),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem {
  final PoseIconType icon;
  final String label;
  final bool emphasized;

  const _NavItem(this.icon, this.label, {this.emphasized = false});
}

class _NavButton extends StatefulWidget {
  final _NavItem item;
  final bool selected;
  final VoidCallback onTap;

  const _NavButton({
    required this.item,
    required this.selected,
    required this.onTap,
  });

  @override
  State<_NavButton> createState() => _NavButtonState();
}

class _NavButtonState extends State<_NavButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    final selected = widget.selected;

    if (item.emphasized) {
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTapDown: (_) => setState(() => _pressed = true),
        onTapUp: (_) => setState(() => _pressed = false),
        onTapCancel: () => setState(() => _pressed = false),
        onTap: widget.onTap,
        child: SizedBox(
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedScale(
                scale: _pressed ? 0.92 : 1.0,
                duration: const Duration(milliseconds: 140),
                child: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: selected ? AppColors.softRose : AppColors.softIvory,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: selected ? AppColors.softRose : AppColors.hairline,
                      width: 1.4,
                    ),
                    boxShadow: selected
                        ? const [
                            BoxShadow(
                              color: AppColors.cardShadow,
                              blurRadius: 14,
                              offset: Offset(0, 6),
                            ),
                          ]
                        : null,
                  ),
                  child: Center(
                    child: PoseIcon(
                      item.icon,
                      size: 24,
                      color: selected
                          ? AppColors.deepPlum
                          : AppColors.mutedRoseGray,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                item.label,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                  color: selected
                      ? AppColors.dustyRose
                      : AppColors.mutedRoseGray,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: _pressed ? 0.94 : 1.0,
        duration: const Duration(milliseconds: 140),
        child: SizedBox(
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              PoseIcon(
                item.icon,
                size: 23,
                color: selected ? AppColors.dustyRose : AppColors.mutedRoseGray,
              ),
              const SizedBox(height: 3),
              Text(
                item.label,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                  color: selected
                      ? AppColors.dustyRose
                      : AppColors.mutedRoseGray,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
