import 'package:culture/data/SearchAlbum.dart';
import 'package:culture/models/SearchResultsTopAlbumsModel.dart';
import 'package:culture/presentation/pages/genre_selection_page.dart';
import 'package:culture/presentation/widgets/DefaultSearchBar.dart';
import 'package:culture/presentation/widgets/detailed_genre_selection_page/albumSearchResultItem.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AlbumSearchSelectionPage extends ConsumerStatefulWidget {
  String goRouterGenreName;

  AlbumSearchSelectionPage({
    super.key,
    this.goRouterGenreName = 'pop',
  });

  @override
  ConsumerState<AlbumSearchSelectionPage> createState() =>
      _DetailedGenreSelectionPageState();
}

class _DetailedGenreSelectionPageState
    extends ConsumerState<AlbumSearchSelectionPage> {
  late Future<SearchResultsTopAlbums> albums;

  @override
  Widget build(BuildContext context) {
    albums = searchAlbums(ref.read(genreSearchProvider.notifier).state);

    return ListView(children: [
      FutureBuilder(
          future: albums,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  const DefaultSearchBar(),
                  Center(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(ref.read(genreSearchProvider.notifier).state,
                        style: Theme.of(context).textTheme.headlineSmall),
                  )),
                  ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: snapshot.data!.albums.length,
                      itemBuilder: ((context, index) {
                        return Column(
                          children: [
                            AlbumSearchResultItem(
                              imgUrl:
                                  snapshot.data!.albums[index].albumImageUrl,
                              albumName: snapshot.data!.albums[index].albumName,
                              artist: snapshot.data!.albums[index].artistName,
                              onTap: () {
                                context.goNamed('detailedgenrereview',
                                    queryParameters: {
                                      'albumName': snapshot
                                          .data!.albums[index].albumName,
                                      'artistName': snapshot
                                          .data!.albums[index].artistName,
                                    });
                              },
                            ),
                            const SizedBox(height: 10)
                          ],
                        );
                      })),
                ],
              );
            } else if (snapshot.hasError) {
              return const Text('error');
            } else {
              return const Column(children: <Widget>[
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
          })
    ]);
  }
}
