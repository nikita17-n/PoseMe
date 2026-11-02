import 'package:flutter/material.dart';

import '../models/favorites_store.dart';
import '../theme/app_theme.dart';
import '../widgets/pose_buttons.dart';
import '../widgets/pose_brand.dart';
import '../widgets/pose_icons.dart';

/// My Poses / Saved Poses screen — saved pose cards with empty state.
class SavedPosesScreen extends StatefulWidget {
  const SavedPosesScreen({super.key});

  @override
  State<SavedPosesScreen> createState() => _SavedPosesScreenState();
}

class _SavedPosesScreenState extends State<SavedPosesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: PoseIconButton(
          icon: PoseIconType.back,
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        title: const Text('My Poses ♡'),
      ),
      body: SafeArea(
        child: ListenableBuilder(
          listenable: FavoritesStore.instance,
          builder: (context, _) {
            final ids = FavoritesStore.instance.ids;
            if (ids.isEmpty) {
              return const _EmptySaved();
            }
            return ListView.separated(
              padding: const EdgeInsets.all(AppDimens.screenPadding),
              itemCount: ids.length,
              separatorBuilder: (_, _) => const SizedBox(height: 14),
              itemBuilder: (context, index) {
                return _SavedPoseTile(id: ids[index], index: index);
              },
            );
          },
        ),
      ),
    );
  }
}

class _SavedPoseTile extends StatelessWidget {
  final String id;
  final int index;

  const _SavedPoseTile({required this.id, required this.index});

  @override
  Widget build(BuildContext context) {
    final names = [
      'Sunbeam',
      'Daydream',
      'Editorial',
      'Mirror Story',
      'Golden Hour',
      'Wanderlust',
    ];
    final categories = [
      'Casual',
      'Cute',
      'Elegant',
      'Mirror Selfie',
      'Outdoor',
      'Travel',
    ];
    final tints = [
      [AppColors.lightBlush, AppColors.primaryPink],
      [AppColors.softLavender, AppColors.primaryPink],
      [AppColors.primaryPink, AppColors.brightRose],
      [AppColors.lightBlush, AppColors.softLavender],
      [AppColors.primaryPink, AppColors.lightBlush],
      [AppColors.softLavender, AppColors.primaryPink],
    ];
    final name = names[index % names.length];
    final category = categories[index % categories.length];
    final tint = tints[index % tints.length];

    return Container(
      height: 110,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppDimens.radiusCard),
        border: Border.all(color: AppColors.hairline),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: tint,
        ),
        boxShadow: const [
          BoxShadow(
            color: AppColors.cardShadow,
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Thumbnail.
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(AppDimens.radiusCard),
              bottomLeft: Radius.circular(AppDimens.radiusCard),
            ),
            child: Container(
              width: 90,
              height: double.infinity,
              color: AppColors.white.withValues(alpha: 0.5),
              child: Center(
                child: PoseFigure(
                  height: 70,
                  color: AppColors.text.withValues(alpha: 0.16),
                  sparkleColor: AppColors.text.withValues(alpha: 0.22),
                ),
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    name,
                    style: AppTextStyles.bodyStrong.copyWith(fontSize: 15),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    category,
                    style: AppTextStyles.caption.copyWith(fontSize: 11.5),
                  ),
                ],
              ),
            ),
          ),
          // Open / remove actions.
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              PoseIconButton(
                icon: PoseIconType.pose,
                size: 36,
                iconSize: 18,
                onPressed: () {
                  // Open saved pose detail.
                },
              ),
              const SizedBox(height: 6),
              PoseIconButton(
                icon: PoseIconType.close,
                size: 36,
                iconSize: 18,
                onPressed: () {
                  // Remove from saved.
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _EmptySaved extends StatelessWidget {
  const _EmptySaved();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 96,
              height: 96,
              decoration: const BoxDecoration(
                color: AppColors.lightBlush,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: PoseIcon(
                  PoseIconType.favorite,
                  size: 40,
                  color: AppColors.brightRose,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'No saved poses yet',
              style: AppTextStyles.title,
            ),
            const SizedBox(height: 8),
            Text(
              'Save the poses you love and they will wait for you here.',
              textAlign: TextAlign.center,
              style: AppTextStyles.body,
            ),
            const SizedBox(height: 28),
            PosePrimaryButton(
              label: 'Explore Poses',
              icon: PoseIconType.pose,
              onPressed: () {
                Navigator.of(context).maybePop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
