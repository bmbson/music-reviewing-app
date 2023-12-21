import 'package:culture/presentation/widgets/artist_page/CommentBlockItem.dart';
import 'package:flutter/material.dart';

class CommentBlock extends StatelessWidget {
  const CommentBlock({super.key, this.commentAmount = '0'});
  final String commentAmount;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        const Text("Comments"),
        Container(
          color: const Color.fromARGB(255, 17, 20, 22),
          child: const Column(
            children: [CommentBlockItem(), CommentBlockItem()],
          ),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          const Text('Write Review'),
          Text('See More Comments ($commentAmount)')
        ])
      ]),
    );
  }
}
