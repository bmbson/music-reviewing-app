import 'package:culture/data/GetTopAlbums.dart';
import 'package:culture/models/SearchResultsTopAlbumsModel.dart';
import 'package:culture/presentation/pages/genre_selection_page.dart';
import 'package:culture/presentation/widgets/DefaultSearchBar.dart';
import 'package:culture/presentation/widgets/hub_page/RectangleCard.dart';
import 'package:culture/presentation/widgets/hub_page/SquareCard.dart';
import 'package:culture/presentation/widgets/hub_page/searchFilterChip.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final chipVisibilityProvider = StateProvider.autoDispose<bool>((ref) => false);
final selectedRatingProvider = StateProvider<double>((ref) => 5);

class HubPage extends ConsumerStatefulWidget {
  const HubPage({
    super.key,
  });

  @override
  ConsumerState<HubPage> createState() => _HubPageState();
}

class _HubPageState extends ConsumerState<HubPage> {
  late Future<SearchResultsTopAlbums> topAlbums;

  @override
  Widget build(BuildContext context) {
    topAlbums = getTopAlbums('pop');

    return ListView(
      scrollDirection: Axis.vertical,
      children: [
        FutureBuilder(
            future: topAlbums,
            builder: ((context, snapshot) {
              if (snapshot.hasData) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      const DefaultSearchBar(),
                      Visibility(
                          visible: ref.watch(chipVisibilityProvider),
                          child: AnimatedOpacity(
                              opacity:
                                  ref.watch(chipVisibilityProvider) ? 1.0 : 0.0,
                              duration: const Duration(milliseconds: 1000),
                              child: const SearchFilterChips())),
                      RectangleCard(
                        image: 'assets/genreImages/genres.png',
                        name: 'Genre',
                        onTap: () => context.go('/genreselectionscaffold'),
                      ),
                      GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: snapshot.data!.albums.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  mainAxisSpacing: 8,
                                  crossAxisSpacing: 8,
                                  crossAxisCount: 2),
                          itemBuilder: ((context, index) {
                            return SquareCard(
                                image:
                                    snapshot.data!.albums[index].albumImageUrl,
                                onTap: () {
                                  ref
                                      .watch(genreSearchProvider.notifier)
                                      .state = "pop";
                                  context.goNamed('detailedgenrereview',
                                      queryParameters: {
                                        'albumName': snapshot
                                            .data!.albums[index].albumName,
                                        'artistName': snapshot
                                            .data!.albums[index].artistName,
                                        'clickedGenreName': 'pop'
                                      });
                                });
                          })),
                    ],
                  ),
                );
              } else if (snapshot.hasError) {
                return const Text('error');
              } else {
                return const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        width: 60,
                        height: 60,
                        child: CircularProgressIndicator(),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 16),
                        child: Text('Awaiting result...'),
                      ),
                    ]);
              }
            }))
      ],
    );
  }
}

 // GridView.count(
        //     crossAxisCount: 2,
        //     physics: const NeverScrollableScrollPhysics(),
        //     crossAxisSpacing: 10,
        //     mainAxisSpacing: 10,
        //     shrinkWrap: true,
        //     children: const [
        //       SquareCard(),
        //       SquareCard(),
        //       SquareCard(),
        //       SquareCard(),
        //       SquareCard(),
        //       SquareCard(),
        //       SquareCard(),
        //       SquareCard(),
        //       SquareCard(),
        //       SquareCard(),
        //       SquareCard(),
        //       SquareCard(),
        //       SquareCard(),
        //       SquareCard(),
        //     ]),