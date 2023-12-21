import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:culture/data/GetTopAlbums.dart';
import 'package:culture/data/firebase/addBookmark.dart';
import 'package:culture/models/SearchResultsTopAlbumsModel.dart';
import 'package:culture/presentation/pages/genre_selection_page.dart';
import 'package:culture/presentation/widgets/DefaultSearchBar.dart';
import 'package:culture/presentation/widgets/detailed_genre_selection_page/albumSearchResultItem.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DetailedGenreSelectionPage extends ConsumerStatefulWidget {
  String goRouterGenreName;

  DetailedGenreSelectionPage({
    super.key,
    this.goRouterGenreName = 'undefined',
  });

  @override
  ConsumerState<DetailedGenreSelectionPage> createState() =>
      _DetailedGenreSelectionPageState();
}

class _DetailedGenreSelectionPageState
    extends ConsumerState<DetailedGenreSelectionPage> {
  late Future<SearchResultsTopAlbums> albums;

  @override
  Widget build(BuildContext context) {
    albums = getTopAlbums(ref.read(genreSearchProvider.notifier).state);
    final TextEditingController textBarController = TextEditingController();

    final FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseFirestore db = FirebaseFirestore.instance;
    return SafeArea(
      child: SingleChildScrollView(
          child: Column(children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, top: 16),
          child: SearchBar(
            controller: textBarController,
            hintText: "Filter",
            leading: const Icon(Icons.search),
          ),
        ),
        Center(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(ref.read(genreSearchProvider.notifier).state,
              style: Theme.of(context).textTheme.headlineSmall),
        )),
        FutureBuilder(
            future: albums,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
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
                              bookmarkTap: () {
                                try {
                                  addBookmark(
                                    auth,
                                    db,
                                    snapshot.data!.albums[index].albumName,
                                    snapshot.data!.albums[index].albumImageUrl,
                                    snapshot.data!.albums[index].artistName,
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            'Added ${snapshot.data!.albums[index].albumName} by ${snapshot.data!.albums[index].artistName} to your bookmarks.')),
                                  );
                                } catch (error) {
                                  print(error);
                                }
                              }),
                          const SizedBox(height: 10)
                        ],
                      );
                    }));
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
      ])),
    );
  }
}
