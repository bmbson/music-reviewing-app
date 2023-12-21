import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:culture/data/firebase/deleteRating.dart';
import 'package:culture/data/firebase/getRatings.dart';
import 'package:culture/presentation/pages/genre_selection_page.dart';
import 'package:culture/presentation/widgets/DefaultSearchBar.dart';
import 'package:culture/presentation/widgets/user_profile/UserProfileAlbumItem.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final ratingSearchBarVisibilityProvider = StateProvider<bool>((ref) => false);

class VarStarRatingScreen extends ConsumerWidget {
  const VarStarRatingScreen({super.key, this.reviewNumber = '5'});

  final String reviewNumber;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseFirestore db = FirebaseFirestore.instance;
    Future<List<Map<dynamic, dynamic>>> userReviewsByStar =
        getUserReviewByStarNumber(auth, db, reviewNumber);

    return Column(children: [
      Expanded(
          child: FutureBuilder(
              future: userReviewsByStar,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.isEmpty) {
                    ref.read(ratingSearchBarVisibilityProvider.notifier).state =
                        false;
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                            child: Text(
                          'No Ratings Found',
                          style: Theme.of(context).textTheme.bodyLarge,
                        )),
                        const Icon(
                          Icons.cancel,
                          color: Colors.red,
                          size: 100,
                        )
                      ],
                    );
                  } else {
                    return ListView(children: [
                      const DefaultSearchBar(),
                      Center(
                          child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Text("${reviewNumber} Star Ratings",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall))),
                      ListView.separated(
                        //shrinkWrap added to prevent issues: https://stackoverflow.com/questions/45270900/how-to-implement-nested-listview-in-flutter
                        shrinkWrap: true,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 0),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Dismissible(
                                  key: UniqueKey(),
                                  background: Container(color: Colors.red),
                                  onDismissed: (direction) {
                                    try {
                                      deleteRating(
                                          auth,
                                          db,
                                          snapshot.data![index]['albumName'],
                                          snapshot.data![index]['artistName'],
                                          snapshot.data![index]['albumImage'],
                                          reviewNumber);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(
                                                  '${snapshot.data![index]['albumName']} by ${snapshot.data![index]['artistName']} removed.')));
                                    } catch (error) {
                                      debugPrint("Error: $error");
                                    }
                                  },
                                  // child: AlbumSearchResultItem());
                                  child: UserProfileAlbumItem(
                                    albumName: snapshot.data![index]
                                        ['albumName'],
                                    imgUrl: snapshot.data![index]['albumImage'],
                                    artist: snapshot.data![index]['artistName'],
                                    onTap: () {
                                      ref
                                              .watch(genreSearchProvider.notifier)
                                              .state =
                                          snapshot.data![index]['artistName'];
                                      context.goNamed('detailedgenrereview',
                                          queryParameters: {
                                            'albumName': snapshot.data![index]
                                                ['albumName'],
                                            'artistName': snapshot.data![index]
                                                ['artistName'],
                                          });
                                    },
                                  )),
                            ),
                          );
                        },
                      )
                    ]);
                  }
                } else if (snapshot.hasError) {
                  return Column(children: [
                    const Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 60,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Text('Error: ${snapshot.error}'),
                    ),
                  ]);
                } else {
                  return const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
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
    ]);
  }
}
