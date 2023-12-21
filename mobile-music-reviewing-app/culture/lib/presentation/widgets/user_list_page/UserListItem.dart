import 'package:flutter/material.dart';

class UserListItem extends StatelessWidget {
  final String albumName;
  final String artist;
  final String imgUrl;
  final String avgRating;
  final String reviewAmount;
  final VoidCallback? onTap;

  const UserListItem(
      {super.key,
      this.albumName = "album name",
      this.artist = "artist",
      this.imgUrl = "assets/genreImages/blues.jpg",
      this.avgRating = '3',
      this.reviewAmount = '10',
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
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
