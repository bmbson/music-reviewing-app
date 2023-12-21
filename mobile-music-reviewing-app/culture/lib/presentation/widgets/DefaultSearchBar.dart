import 'package:culture/presentation/pages/genre_selection_page.dart';
import 'package:culture/presentation/pages/hub_page.dart';
import 'package:culture/presentation/widgets/hub_page/searchFilterChip.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final hubSearchQueryProvider = StateProvider<String>((ref) => '');

class DefaultSearchBar extends ConsumerWidget {
  const DefaultSearchBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const SnackBar snackBar =
        SnackBar(content: Text("Please select a search filter."));

    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 16),
      child: SearchBar(
        onSubmitted: (value) {
          int? chipChoice = ref.watch(selectedChipProvider);
          if (chipChoice == 0 && value != '') {
            ref.read(hubSearchQueryProvider.notifier).state = value;
          } else if (chipChoice == 1 && value != '') {
            ref.read(hubSearchQueryProvider.notifier).state = value;
            debugPrint(value);
            context.go('/albumsearchscaffold');
          } else if (chipChoice == 2 && value != '') {
            ref.read(genreSearchProvider.notifier).state = value;
            context.go('/albumsearchscaffold');
          } else {
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        },
        onTap: () {
          ref.watch(chipVisibilityProvider.notifier).state = true;
        },
        leading: const Icon(Icons.search),
      ),
    );
  }
}
