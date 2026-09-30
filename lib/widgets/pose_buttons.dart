import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import 'pose_icons.dart';

/// Primary PoseMe button — soft rose fill, deep plum text, pill shape.
class PosePrimaryButton extends StatefulWidget {
  final String label;
  final VoidCallback? onPressed;
  final PoseIconType? icon;
  final bool expanded;
  final bool busy;

  const PosePrimaryButton({
    super.key,
    required this.label,
    this.onPressed,
    this.icon,
    this.expanded = true,
    this.busy = false,
  });

  @override
  State<PosePrimaryButton> createState() => _PosePrimaryButtonState();
}

class _PosePrimaryButtonState extends State<PosePrimaryButton> {
  bool _pressed = false;

  void _setPressed(bool value) {
    if (widget.onPressed != null && mounted) {
      setState(() => _pressed = value);
    }
  }

  @override
  Widget build(BuildContext context) {
    final enabled = widget.onPressed != null && !widget.busy;

    return GestureDetector(
      onTapDown: (_) => _setPressed(true),
      onTapUp: (_) => _setPressed(false),
      onTapCancel: () => _setPressed(false),
      child: AnimatedScale(
        scale: _pressed ? 0.97 : 1.0,
        duration: const Duration(milliseconds: 140),
        curve: Curves.easeOut,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          width: widget.expanded ? double.infinity : null,
          padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 16),
          decoration: BoxDecoration(
            color: enabled ? AppColors.softRose : AppColors.blushPink,
            borderRadius: BorderRadius.circular(AppDimens.radiusButton),
            boxShadow: enabled
                ? const [
                    BoxShadow(
                      color: AppColors.cardShadow,
                      blurRadius: 18,
                      offset: Offset(0, 8),
                    ),
                  ]
                : null,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: widget.expanded ? MainAxisSize.max : MainAxisSize.min,
            children: [
              if (widget.busy)
                const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.2,
                    color: AppColors.deepPlum,
                  ),
                )
              else if (widget.icon != null) ...[
                PoseIcon(widget.icon!, size: 19, color: AppColors.deepPlum),
                const SizedBox(width: 9),
              ],
              Text(
                widget.label,
                style: AppTextStyles.button.copyWith(
                  color: enabled ? AppColors.deepPlum : AppColors.mutedRoseGray,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Secondary PoseMe button — ivory fill, rose hairline border, plum text.
class PoseSecondaryButton extends StatefulWidget {
  final String label;
  final VoidCallback? onPressed;
  final PoseIconType? icon;
  final bool expanded;

  const PoseSecondaryButton({
    super.key,
    required this.label,
    this.onPressed,
    this.icon,
    this.expanded = true,
  });

  @override
  State<PoseSecondaryButton> createState() => _PoseSecondaryButtonState();
}

class _PoseSecondaryButtonState extends State<PoseSecondaryButton> {
  bool _pressed = false;

  void _setPressed(bool value) {
    if (widget.onPressed != null && mounted) {
      setState(() => _pressed = value);
    }
  }

  @override
  Widget build(BuildContext context) {
    final enabled = widget.onPressed != null;

    return GestureDetector(
      onTapDown: (_) => _setPressed(true),
      onTapUp: (_) => _setPressed(false),
      onTapCancel: () => _setPressed(false),
      child: AnimatedScale(
        scale: _pressed ? 0.97 : 1.0,
        duration: const Duration(milliseconds: 140),
        curve: Curves.easeOut,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          width: widget.expanded ? double.infinity : null,
          padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 16),
          decoration: BoxDecoration(
            color: enabled ? AppColors.softIvory : AppColors.warmCream,
            borderRadius: BorderRadius.circular(AppDimens.radiusButton),
            border: Border.all(
              color: enabled ? AppColors.blushPink : AppColors.hairline,
              width: 1.4,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: widget.expanded ? MainAxisSize.max : MainAxisSize.min,
            children: [
              if (widget.icon != null) ...[
                PoseIcon(widget.icon!, size: 19, color: AppColors.dustyRose),
                const SizedBox(width: 9),
              ],
              Text(
                widget.label,
                style: AppTextStyles.button.copyWith(
                  color: enabled ? AppColors.deepPlum : AppColors.mutedRoseGray,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Small circular icon button used in app bars and camera controls.
class PoseIconButton extends StatefulWidget {
  final PoseIconType icon;
  final VoidCallback? onPressed;
  final Color? color;
  final double size;
  final double iconSize;
  final Color? background;

  const PoseIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.color,
    this.size = 44,
    this.iconSize = 21,
    this.background,
  });

  @override
  State<PoseIconButton> createState() => _PoseIconButtonState();
}

class _PoseIconButtonState extends State<PoseIconButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedScale(
        scale: _pressed ? 0.9 : 1.0,
        duration: const Duration(milliseconds: 120),
        child: Container(
          width: widget.size,
          height: widget.size,
          decoration: BoxDecoration(
            color: widget.background ?? AppColors.softIvory,
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.hairline),
            boxShadow: const [
              BoxShadow(
                color: AppColors.cardShadow,
                blurRadius: 12,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Center(
            child: PoseIcon(
              widget.icon,
              size: widget.iconSize,
              color: widget.color ?? AppColors.deepPlum,
            ),
          ),
        ),
      ),
    );
  }
}
