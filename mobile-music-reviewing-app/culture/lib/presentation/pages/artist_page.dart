import 'package:culture/presentation/widgets/artist_page/ArtistInfo.dart';
import 'package:culture/presentation/widgets/artist_page/CommentBlock.dart';
import 'package:culture/presentation/widgets/artist_page/LibraryBlock.dart';
import 'package:flutter/widgets.dart';

class ArtistPage extends StatelessWidget {
  const ArtistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
        child: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ArtistInfo(),
          LibraryBlock(
            libraryBlockTitle: 'Album',
          ),
          LibraryBlock(
            libraryBlockTitle: 'EP',
          ),
          CommentBlock()
        ],
      ),
    ));
  }
}
