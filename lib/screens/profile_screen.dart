import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../widgets/pose_brand.dart';
import '../widgets/pose_icons.dart';

/// Profile screen — UI placeholder.
///
/// Account features are not implemented yet; this screen presents the
/// profile layout with elegant menu rows.
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppDimens.screenPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 6),

              // Identity card.
              Container(
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: AppColors.softIvory,
                  borderRadius: BorderRadius.circular(AppDimens.radiusCard),
                  border: Border.all(color: AppColors.hairline),
                  boxShadow: const [
                    BoxShadow(
                      color: AppColors.cardShadow,
                      blurRadius: 16,
                      offset: Offset(0, 6),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 68,
                      height: 68,
                      decoration: const BoxDecoration(
                        color: AppColors.softPeach,
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: PoseLogo(size: 44, withSparkle: false),
                      ),
                    ),
                    const SizedBox(width: 18),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('PoseMe User', style: AppTextStyles.title),
                          SizedBox(height: 4),
                          Text(
                            'Premium pose assistant',
                            style: AppTextStyles.caption,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 26),

              // Menu rows.
              Container(
                decoration: BoxDecoration(
                  color: AppColors.softIvory,
                  borderRadius: BorderRadius.circular(AppDimens.radiusCard),
                  border: Border.all(color: AppColors.hairline),
                ),
                child: Column(
                  children: const [
                    _MenuRow(
                      icon: PoseIconType.history,
                      label: 'History',
                      last: false,
                    ),
                    _MenuRow(
                      icon: PoseIconType.settings,
                      label: 'Settings',
                      last: false,
                    ),
                    _MenuRow(
                      icon: PoseIconType.help,
                      label: 'Help & Support',
                      last: true,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 26),

              Center(
                child: Text(
                  'PoseMe · v1.0.0',
                  style: AppTextStyles.caption.copyWith(fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MenuRow extends StatefulWidget {
  final PoseIconType icon;
  final String label;
  final bool last;

  const _MenuRow({required this.icon, required this.label, required this.last});

  @override
  State<_MenuRow> createState() => _MenuRowState();
}

class _MenuRowState extends State<_MenuRow> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      onTap: () {
        // UI placeholder — menu actions not implemented yet.
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        decoration: BoxDecoration(
          color: _pressed ? AppColors.warmCream : null,
          borderRadius: BorderRadius.circular(AppDimens.radiusCard),
          border: widget.last
              ? null
              : const Border(bottom: BorderSide(color: AppColors.hairline)),
        ),
        child: Row(
          children: [
            PoseIcon(widget.icon, size: 20, color: AppColors.dustyRose),
            const SizedBox(width: 14),
            Expanded(
              child: Text(widget.label, style: AppTextStyles.bodyStrong),
            ),
            const Icon(
              Icons.chevron_right,
              size: 20,
              color: AppColors.blushPink,
            ),
          ],
        ),
      ),
    );
  }
}
