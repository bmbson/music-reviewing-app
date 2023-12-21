import 'package:culture/models/NavDestinationsModel.dart';
import 'package:culture/presentation/pages/album_information_page.dart';
import 'package:culture/presentation/pages/detailed_genre_selection_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AlbumSearchScaffold extends ConsumerWidget {
  const AlbumSearchScaffold({super.key, required this.genreName});

  final String? genreName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(selectedIndexProvider, (int? prevState, int newState) {
      if (newState == 0) {
        context.go('/');
      } else if (newState == 1) {
        context.go('/userprofilescaffold/5');
      } else if (newState == 2) {
        context.go('/listselectedlist');
      } else if (newState == 3) {
        FirebaseAuth.instance.signOut();
      }
    });

    return AdaptiveScaffold(
      selectedIndex: ref.watch(selectedIndexProvider),
      onSelectedIndexChange: (int index) {
        ref.read(selectedIndexProvider.notifier).update((state) => index);
      },
      body: (_) => DetailedGenreSelectionPage(),
      secondaryBody: (_) =>
          const AlbumInformationAndReviewPage(albumName: "", artistName: ""),
      destinations: NavDestinations.destinations,
      smallSecondaryBody: AdaptiveScaffold.emptyBuilder,
    );
  }
}
