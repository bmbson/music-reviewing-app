import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:culture/data/firebase/addCommentToAlbum.dart';
import 'package:culture/data/firebase/getCommentsForAlbum.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ReviewBox extends StatefulWidget {
  const ReviewBox(
      {super.key,
      this.albumName = "default",
      this.albumImage = "default",
      this.artistName = "default",
      this.userName = "default"});

  final String albumName;
  final String albumImage;
  final String artistName;
  final String userName;

  @override
  State<ReviewBox> createState() => _ReviewBoxState();
}

class _ReviewBoxState extends State<ReviewBox> {
  bool _reviewBoxVisibility = false;

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseFirestore db = FirebaseFirestore.instance;
    var commentsFuture = getAlbumComments(auth, db, widget.albumName);

    final commentTextController = TextEditingController();

    @override
    void dispose() {
      // Clean up the controller when the widget is disposed.
      commentTextController.dispose();
      super.dispose();
    }

    // ignore: avoid_unnecessary_containers
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text("Reviews", style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 8),
          FutureBuilder(
              future: commentsFuture,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.isEmpty) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        color: const Color.fromARGB(255, 17, 20, 22),
                        child: const Center(child: Text("No Reviews")),
                      ),
                    );
                  } else {
                    return ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: ((context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Container(
                                  padding: const EdgeInsets.all(20),
                                  color: const Color.fromARGB(255, 17, 20, 22),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const CircleAvatar(
                                          radius: 20,
                                          backgroundImage: AssetImage(
                                              'assets/genreImages/blues.jpg')),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16.0),
                                          child: Container(
                                            child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        snapshot.data![index]
                                                            ['userName'],
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      const SizedBox(width: 8),
                                                      Flexible(
                                                        child: Text(
                                                            snapshot
                                                                .data![index]
                                                                    ['date']
                                                                .substring(
                                                                    0, 10),
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodySmall),
                                                      )
                                                    ],
                                                  ),
                                                  const SizedBox(height: 2),
                                                  Text(
                                                    snapshot.data![index]
                                                        ['comment'],
                                                    textDirection:
                                                        TextDirection.ltr,
                                                  )
                                                ]),
                                          ),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(360),
                                            child: Material(
                                              color: Colors.transparent,
                                              child: InkWell(
                                                onTap: () {},
                                                child: const Icon(
                                                  Icons.thumb_up_rounded,
                                                  color: Color.fromARGB(
                                                      255, 95, 95, 95),
                                                  size: 15,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          const Text("+0",
                                              style: TextStyle(
                                                  color: Colors.green))
                                        ],
                                      )
                                    ],
                                  )),
                            ),
                          );
                        }));
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
              }),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton.icon(
                icon: const Icon(
                  Icons.edit,
                  size: 20,
                ),
                label: Text('Write Review',
                    style: Theme.of(context).textTheme.bodyMedium),
                onPressed: () {
                  setState(() {
                    _reviewBoxVisibility = !_reviewBoxVisibility;
                  });
                },
              ),
              Flexible(
                child: TextButton.icon(
                  icon: const Icon(Icons.expand_more),
                  label: Text("See More Reviews (50)",
                      style: Theme.of(context).textTheme.bodyMedium),
                  onPressed: () {},
                ),
              )
            ],
          ),
          Visibility(
            visible: _reviewBoxVisibility,
            child: Column(
              children: [
                TextField(
                  controller: commentTextController,
                  maxLines: null,
                ),
                const SizedBox(height: 8),
                TextButton.icon(
                    icon: const Icon(
                      Icons.send,
                      size: 20,
                    ),
                    onPressed: () {
                      addComment(
                          auth,
                          db,
                          widget.albumName,
                          widget.albumImage,
                          widget.artistName,
                          commentTextController.text,
                          widget.userName);
                    },
                    label: const Text("Submit Review"))
              ],
            ),
          )
        ],
      ),
    );
  }
}
