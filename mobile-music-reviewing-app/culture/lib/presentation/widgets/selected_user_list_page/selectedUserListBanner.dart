import 'package:flutter/material.dart';

class SelectedUserListBanner extends StatelessWidget {
  final String image;
  final String listName;
  final String listCreator;
  final String description;

  const SelectedUserListBanner(
      {super.key,
      this.image = 'assets/genreImages/blues.jpg',
      this.listName = "list name",
      this.listCreator = 'list creator',
      this.description = 'list description'});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                  image,
                )))),
            Column(
              children: [Text(listName), Text(listCreator)],
            ),
          ]),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Text(description),
          )
        ],
      ),
    );
  }
}
