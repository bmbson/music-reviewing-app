import 'package:culture/models/NavDestinationsModel.dart';
import 'package:culture/presentation/pages/album_information_page.dart';
import 'package:culture/presentation/pages/var_star_rating_screen_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class VarStarReviewScaffold extends ConsumerWidget {
  const VarStarReviewScaffold(
      {super.key, this.starCount = '5', this.albumName, this.artistName});

  final String? starCount;
  final String? albumName;
  final String? artistName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(selectedIndexProvider, (int? prevState, int newState) {
      if (newState == 0) {
        context.go('/');
      } else if (newState == 1) {
        context.go('/userprofilescaffold/5');
      } else if (newState == 2) {
        context.go('/listselectedlist');
      }
    });

    return AdaptiveScaffold(
      selectedIndex: ref.watch(selectedIndexProvider),
      onSelectedIndexChange: (int index) {
        ref.read(selectedIndexProvider.notifier).update((state) => index);
      },
      body: (_) => VarStarRatingScreen(reviewNumber: starCount ?? '5'),
      secondaryBody: (_) => AlbumInformationAndReviewPage(
        albumName: albumName,
        artistName: artistName,
      ),
      destinations: NavDestinations.destinations,
      smallSecondaryBody: AdaptiveScaffold.emptyBuilder,
    );
  }
}
