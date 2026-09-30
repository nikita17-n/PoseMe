import 'package:flutter/material.dart';

import '../models/favorites_store.dart';
import '../theme/app_theme.dart';
import '../widgets/pose_icons.dart';

/// Shows poses the user has hearted in the discovery screen.
class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favorites')),
      body: SafeArea(
        child: ListenableBuilder(
          listenable: FavoritesStore.instance,
          builder: (context, _) {
            final ids = FavoritesStore.instance.ids;
            if (ids.isEmpty) {
              return const _EmptyFavorites();
            }
            return ListView.separated(
              padding: const EdgeInsets.all(AppDimens.screenPadding),
              itemCount: ids.length,
              separatorBuilder: (_, _) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.softIvory,
                    borderRadius: BorderRadius.circular(AppDimens.radiusCard),
                    border: Border.all(color: AppColors.hairline),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 42,
                        height: 42,
                        decoration: const BoxDecoration(
                          color: AppColors.softPeach,
                          shape: BoxShape.circle,
                        ),
                        child: const Center(
                          child: PoseIcon(
                            PoseIconType.pose,
                            size: 20,
                            color: AppColors.dustyRose,
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Text(
                          'Saved pose ${index + 1}',
                          style: AppTextStyles.bodyStrong,
                        ),
                      ),
                      const PoseIcon(
                        PoseIconType.favorite,
                        size: 18,
                        color: AppColors.dustyRose,
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class _EmptyFavorites extends StatelessWidget {
  const _EmptyFavorites();

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
                color: AppColors.softPeach,
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: PoseIcon(
                  PoseIconType.favorite,
                  size: 40,
                  color: AppColors.dustyRose,
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text('No favorites yet', style: AppTextStyles.title),
            const SizedBox(height: 8),
            const Text(
              'Heart the poses you love and they will wait for you here.',
              textAlign: TextAlign.center,
              style: AppTextStyles.body,
            ),
          ],
        ),
      ),
    );
  }
}
