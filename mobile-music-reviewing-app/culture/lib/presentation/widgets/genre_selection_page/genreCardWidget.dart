import 'package:flutter/material.dart';

class GenreCardWidget extends StatelessWidget {
  const GenreCardWidget(
      {super.key,
      required this.imageUrl,
      required this.genreTitle,
      this.onTap});

  final String imageUrl;
  final String genreTitle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Material(
        color: Colors.transparent,
        child: Ink.image(
          image: ExactAssetImage(imageUrl),
          child: InkWell(
            onTap: onTap,
            splashColor: const Color.fromARGB(80, 255, 255, 255),
            child: Center(
                child: Text(genreTitle.toString(),
                    style: const TextStyle(color: Colors.white))),
          ),
        ),
      ),
    );
  }
}
