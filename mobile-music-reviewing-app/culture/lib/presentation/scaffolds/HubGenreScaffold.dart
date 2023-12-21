import 'package:culture/infrastructure/sideBarLogic.dart';
import 'package:culture/presentation/pages/genre_selection_page.dart';
import 'package:culture/presentation/pages/hub_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../models/NavDestinationsModel.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HubGenreScaffold extends ConsumerStatefulWidget {
  const HubGenreScaffold({super.key});

  @override
  ConsumerState<HubGenreScaffold> createState() => _HubGenreScaffoldState();
}

class _HubGenreScaffoldState extends ConsumerState<HubGenreScaffold> {
  @override
  Widget build(BuildContext context) {
    ref.listen(selectedIndexProvider, (int? prevState, int newState) {
      if (newState == 0) {
        context.go('/');
      } else if (newState == 1) {
        context.go('/userprofilescaffold/5');
      } else if (newState == 2) {
        context.go('/listselectedlist');
      } else if (newState == 3) {
        FirebaseAuth.instance.signOut();
        context.go('/loginpage');
      }
    });

    return SideBarLogic(
      child: AdaptiveScaffold(
        selectedIndex: ref.watch(selectedIndexProvider),
        onSelectedIndexChange: (int index) {
          ref.read(selectedIndexProvider.notifier).update((state) => index);
        },
        body: (_) => const HubPage(),
        secondaryBody: (_) => const GenreSelectionPage(),
        destinations: NavDestinations.destinations,
        smallSecondaryBody: AdaptiveScaffold.emptyBuilder,
      ),
    );
  }
}
