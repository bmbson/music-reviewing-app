import 'package:flutter/material.dart';

class UserProfileAlbumItem extends StatelessWidget {
  final String albumName;
  final String artist;
  final String imgUrl;
  final String avgRating;
  final String reviewAmount;
  final VoidCallback? onTap;

  const UserProfileAlbumItem(
      {super.key,
      this.albumName = "album name",
      this.artist = "artist",
      this.imgUrl = "assets/genreImages/blues.jpg",
      this.avgRating = '3',
      this.reviewAmount = '10',
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      clipBehavior: Clip.antiAlias,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          splashColor: Colors.blueAccent,
          onTap: onTap,
          child: Row(
            children: [
              SizedBox(
                height: 135,
                width: 135,
                child: Image.network(
                  imgUrl,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        albumName,
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        artist,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
