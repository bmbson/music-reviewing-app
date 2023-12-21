import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:culture/data/firebase/deleteBookmark.dart';
import 'package:culture/data/firebase/getUserbookmarks.dart';
import 'package:culture/presentation/pages/genre_selection_page.dart';
import 'package:culture/presentation/widgets/DefaultSearchBar.dart';
import 'package:culture/presentation/widgets/user_list_page/UserListItem.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';

final searchBarVisibilityProvider = StateProvider<bool>((ref) => false);

class UserListPage extends ConsumerWidget {
  const UserListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseFirestore db = FirebaseFirestore.instance;
    Future<List<Map<dynamic, dynamic>>> userBookMarks =
        getUserBookmark(auth, db);

    return Column(children: [
      Expanded(
          child: FutureBuilder(
              future: userBookMarks,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.isEmpty) {
                    ref.read(searchBarVisibilityProvider.notifier).state =
                        false;
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                            child: Text(
                          'No Bookmarks Added',
                          style: Theme.of(context).textTheme.bodyLarge,
                        )),
                        const Icon(
                          Icons.bookmark,
                          color: Colors.blue,
                          size: 100,
                        )
                      ],
                    );
                  } else {
                    return Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(bottom: 16.0),
                          child: DefaultSearchBar(),
                        ),
                        ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: snapshot.data!.length,
                            itemBuilder: ((context, index) {
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Dismissible(
                                    key: UniqueKey(),
                                    background:
                                        Container(color: Colors.blueGrey),
                                    onDismissed: (direction) {
                                      deleteBookmark(
                                        auth,
                                        db,
                                        snapshot.data![index]['albumName'],
                                        snapshot.data![index]['artistName'],
                                        snapshot.data![index]['albumImage'],
                                      );
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(
                                                  'Deleted ${snapshot.data![index]['albumName']} by ${snapshot.data![index]['artistName']} from your bookmarks.')));
                                    },
                                    child: UserListItem(
                                      imgUrl: snapshot.data![index]
                                          ['albumImage'],
                                      artist: snapshot.data![index]
                                          ['artistName'],
                                      albumName: snapshot.data![index]
                                          ['albumName'],
                                      onTap: () {
                                        ref.watch(genreSearchProvider.notifier)
                                                .state =
                                            snapshot.data![index]['artistName'];
                                        context.goNamed('detailedgenrereview',
                                            queryParameters: {
                                              'albumName': snapshot.data![index]
                                                  ['albumName'],
                                              'artistName': snapshot
                                                  .data![index]['artistName'],
                                            });
                                      },
                                    )),
                              );
                            })),
                      ],
                    );
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
