import 'package:culture/presentation/widgets/artist_page/LibraryBlockItem.dart';
import 'package:flutter/material.dart';

class LibraryBlock extends StatelessWidget {
  const LibraryBlock({super.key, required this.libraryBlockTitle});

  final String libraryBlockTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [Text(libraryBlockTitle), const Text('View All')],
        ),
        const LibraryBlockItem(),
        const Divider(),
        const LibraryBlockItem(),
        const Divider(),
        const LibraryBlockItem(),
        const Divider(),
      ],
    );
  }
}
