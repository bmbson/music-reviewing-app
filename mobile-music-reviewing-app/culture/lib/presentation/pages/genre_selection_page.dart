import 'package:culture/presentation/widgets/DefaultSearchBar.dart';
import 'package:culture/presentation/widgets/genre_selection_page/genreCardWidget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final genreSearchProvider = StateProvider<String>((ref) => 'Undefined');

class GenreSelectionPage extends ConsumerWidget {
  const GenreSelectionPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Column(children: [
        const DefaultSearchBar(),
        Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: Text("Select A Genre",
              selectionColor: Colors.white,
              style: Theme.of(context).textTheme.headlineSmall),
        ),
        Expanded(
          child: GridView.count(
            primary: false,
            padding: const EdgeInsets.all(20),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: 2,
            children: <Widget>[
              GenreCardWidget(
                imageUrl: "assets/genreImages/ambient.jpg",
                genreTitle: "Ambient",
                onTap: () {
                  ref.read(genreSearchProvider.notifier).state = "Ambient";

                  context.go('/genredetailedgenre/ambient');
                },
              ),
              GenreCardWidget(
                imageUrl: "assets/genreImages/blues.jpg",
                genreTitle: "Blues",
                onTap: () {
                  ref.read(genreSearchProvider.notifier).state = "Blues";
                  context.go('/genredetailedgenre/blues');
                },
              ),
              GenreCardWidget(
                imageUrl: "assets/genreImages/house.jpg",
                genreTitle: "House",
                onTap: () {
                  ref.read(genreSearchProvider.notifier).state = "House";
                  context.go('/genredetailedgenre/house');
                },
              ),
              GenreCardWidget(
                imageUrl: "assets/genreImages/dub.jpg",
                genreTitle: "Dub",
                onTap: () {
                  ref.read(genreSearchProvider.notifier).state = "Dub";
                  context.go('/genredetailedgenre/dub');
                },
              ),
              GenreCardWidget(
                imageUrl: "assets/genreImages/electronic.jpg",
                genreTitle: "Electronic",
                onTap: () {
                  ref.read(genreSearchProvider.notifier).state = "Electronic";
                  context.go('/genredetailedgenre/electronic');
                },
              ),
              GenreCardWidget(
                imageUrl: "assets/genreImages/rock.jpg",
                genreTitle: "Rock",
                onTap: () {
                  ref.read(genreSearchProvider.notifier).state = "Rock";

                  context.go('/genredetailedgenre/rock');
                },
              ),
              GenreCardWidget(
                imageUrl: "assets/genreImages/hiphop.jpg",
                genreTitle: "Hip Hop",
                onTap: () {
                  ref.read(genreSearchProvider.notifier).state = "Hip-Hop";
                  context.go('/genredetailedgenre/hip-hop');
                },
              ),
              GenreCardWidget(
                imageUrl: "assets/genreImages/jazz.jpg",
                genreTitle: "Jazz",
                onTap: () {
                  ref.read(genreSearchProvider.notifier).state = "Jazz";
                  context.go('/genredetailedgenre/jazz');
                },
              ),
              GenreCardWidget(
                imageUrl: "assets/genreImages/metal.webp",
                genreTitle: "Metal",
                onTap: () {
                  ref.read(genreSearchProvider.notifier).state = "Metal";
                  context.go('/genredetailedgenre/metal');
                },
              ),
              GenreCardWidget(
                imageUrl: "assets/genreImages/punk.webp",
                genreTitle: "Punk",
                onTap: () {
                  ref.read(genreSearchProvider.notifier).state = "Punk";
                  context.go('/genredetailedgenre/punk');
                },
              ),
              GenreCardWidget(
                imageUrl: "assets/genreImages/r&b.webp",
                genreTitle: "R&B",
                onTap: () {
                  ref.read(genreSearchProvider.notifier).state = "R&B";
                  context.go('/genredetailedgenre/r&b');
                },
              ),
              GenreCardWidget(
                imageUrl: "assets/genreImages/rock.jpg",
                genreTitle: "Rock",
                onTap: () {
                  ref.read(genreSearchProvider.notifier).state = "Techno";
                  context.go('/genredetailedgenre/techno');
                },
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
