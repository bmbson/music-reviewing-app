import 'package:flutter/material.dart';

class LibraryBlockItem extends StatelessWidget {
  final String itemName;
  final String artistName;
  final String imgUrl;

  const LibraryBlockItem(
      {super.key,
      this.itemName = "List Name",
      this.artistName = "artistName",
      this.imgUrl = "assets/genreImages/blues.jpg"});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        //Todo: Add
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Ink.image(
            image: ExactAssetImage(imgUrl),
            width: 100,
            height: 100,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(itemName),
              Text(artistName),
            ],
          ),
          const Text("2"),
          const Text("200")
        ],
      ),
    );
  }
}
