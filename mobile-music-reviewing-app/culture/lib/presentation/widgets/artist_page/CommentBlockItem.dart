import 'package:flutter/material.dart';

class CommentBlockItem extends StatelessWidget {
  const CommentBlockItem(
      {super.key,
      this.username = 'undefined',
      this.comment =
          'Nihil deleniti soluta itaque repudiandae nobis facere. Molestias voluptatibus eos eos aliquid.'});

  final String username;
  final String comment;

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      const CircleAvatar(
          radius: 20,
          backgroundImage: AssetImage('assets/genreImages/notImplemented.png')),
      SizedBox(
        width: 200,
        child: Column(
          children: [Text(username), Text(comment)],
        ),
      )
    ]);
  }
}
