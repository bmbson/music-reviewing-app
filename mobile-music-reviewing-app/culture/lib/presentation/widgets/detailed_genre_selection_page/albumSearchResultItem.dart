import 'package:flutter/material.dart';

class AlbumSearchResultItem extends StatelessWidget {
  final String albumName;
  final String artist;
  final String imgUrl;
  final String avgRating;
  final String reviewAmount;
  final VoidCallback? onTap;
  final VoidCallback? bookmarkTap;

  const AlbumSearchResultItem({
    super.key,
    this.albumName = "album name",
    this.artist = "artist",
    this.imgUrl = "assets/genreImages/blues.jpg",
    this.avgRating = '3',
    this.reviewAmount = '10',
    this.onTap,
    this.bookmarkTap,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Material(
        type: MaterialType.transparency,
        child: Ink(
          child: InkWell(
            onTap: onTap,
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 100,
                    width: 100,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        imgUrl,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            child: Text(
                              albumName,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Flexible(
                            child: Text(
                              artist,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: IconButton(
                        onPressed: bookmarkTap, icon: const Icon(Icons.bookmark_add)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
