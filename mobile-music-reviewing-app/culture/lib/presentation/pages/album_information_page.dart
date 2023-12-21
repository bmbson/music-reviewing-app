import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:confetti/confetti.dart';
import 'package:culture/data/firebase/addBookmark.dart';
import 'package:culture/data/firebase/addRating.dart';
import 'package:culture/data/getAlbumInfo.dart';
import 'package:culture/presentation/widgets/album_information_and_review_page/AlbumInfoColumn.dart';
import 'package:culture/presentation/widgets/album_information_and_review_page/AlbumTracksColumn.dart';
import 'package:culture/presentation/widgets/album_information_and_review_page/ReviewBox.dart';
import 'package:culture/presentation/widgets/hub_page/SquareCard.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class AlbumInformationAndReviewPage extends StatefulWidget {
  final String? albumName;
  final String? artistName;

  const AlbumInformationAndReviewPage(
      {super.key, required this.albumName, required this.artistName});

  @override
  State<AlbumInformationAndReviewPage> createState() =>
      _AlbumInformationAndReviewPageState();
}

class _AlbumInformationAndReviewPageState
    extends State<AlbumInformationAndReviewPage> {
  final _controller = ConfettiController(duration: const Duration(seconds: 3));
  bool confettiPlaying = false;

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var selectedAlbum =
        getAlbumInfo(artist = widget.artistName!, album = widget.albumName!);
    final FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseFirestore db = FirebaseFirestore.instance;

    return Stack(
      children: [
        FutureBuilder(
          future: selectedAlbum,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              child: Text(snapshot.data!.albumName,
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineLarge),
                            ),
                            IconButton(
                                onPressed: () {
                                  try {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              'Added ${snapshot.data!.albumName} by ${snapshot.data!.artistName} to your bookmarks.')),
                                    );
                                    addBookmark(
                                        auth,
                                        db,
                                        snapshot.data!.albumName,
                                        snapshot.data!.albumImageUrl,
                                        snapshot.data!.artistName);
                                  } catch (error) {
                                    print(error);
                                  }
                                },
                                icon: const Icon(Icons.bookmark_add))
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child:
                                  Image.network(snapshot.data!.albumImageUrl)),
                          height: 250,
                          width: 250,
                        ),
                      ),
                      AlbumInfoColumn(
                        Artist: snapshot.data!.artistName,
                        Type: snapshot.data!.tags,
                        Release: snapshot.data!.releaseDate,
                      ),
                      RatingBar.builder(
                          initialRating: 3,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemPadding:
                              const EdgeInsets.symmetric(horizontal: 4.0),
                          itemBuilder: (context, _) => const Icon(Icons.star,
                              color: Color.fromARGB(252, 229, 207, 146)),
                          onRatingUpdate: (rating) {
                            if (rating == 5) {
                              confettiPlaying = !confettiPlaying;
                              _controller.play();
                            }
                            addRating(
                                auth,
                                db,
                                snapshot.data!.albumName,
                                snapshot.data!.albumImageUrl,
                                snapshot.data!.artistName,
                                rating.toString());

                            final snackBar = SnackBar(
                              content: Text(
                                'You gave "${snapshot.data!.albumName}" by ${snapshot.data!.artistName} ${rating} stars.',
                                textAlign: TextAlign.center,
                              ),
                              action: SnackBarAction(
                                label: 'Undo',
                                onPressed: () {
                                  // Some code to undo the change.
                                },
                              ),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }),
                      AlbumTracksColumn(trackList: snapshot.data!.tracks),
                      ReviewBox(
                        albumImage: snapshot.data!.albumImageUrl,
                        albumName: snapshot.data!.albumName,
                        artistName: snapshot.data!.artistName,
                        userName: "Test",
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              "Recommendations",
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: GridView.count(
                                crossAxisCount: 2,
                                physics: const NeverScrollableScrollPhysics(),
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                shrinkWrap: true,
                                children: const [
                                  SquareCard(),
                                  SquareCard(),
                                  SquareCard(),
                                  SquareCard(),
                                ]),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                      child: Text(
                    'Album Not Found',
                    style: Theme.of(context).textTheme.bodyLarge,
                  )),
                  const Icon(
                    Icons.error,
                    color: Colors.red,
                    size: 100,
                  )
                ],
              );
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
          },
        ),
        Positioned(
          child: ConfettiWidget(
            confettiController: _controller,
            blastDirectionality: BlastDirectionality.directional,
            blastDirection: 0,
            colors: const [Colors.black, Colors.white, Colors.blue],
          ),
        ),
      ],
    );
  }
}
