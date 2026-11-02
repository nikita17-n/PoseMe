import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import 'pose_icons.dart';

/// A soft, rounded search bar for the home dashboard.
class PoseSearch extends StatelessWidget {
  final String hint;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;

  const PoseSearch({
    super.key,
    this.hint = 'Find your perfect pose...',
    this.onChanged,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppDimens.radiusButton),
        border: Border.all(color: AppColors.hairline),
      ),
      child: Row(
        children: [
          const SizedBox(width: 14),
          PoseIcon(PoseIconType.search, size: 19, color: AppColors.secondaryText),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              onChanged: onChanged,
              onTap: onTap,
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: AppTextStyles.caption.copyWith(
                  color: AppColors.secondaryText,
                ),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding: EdgeInsets.zero,
                isDense: true,
              ),
              style: AppTextStyles.bodyStrong,
            ),
          ),
          const SizedBox(width: 14),
        ],
      ),
    );
  }
}
