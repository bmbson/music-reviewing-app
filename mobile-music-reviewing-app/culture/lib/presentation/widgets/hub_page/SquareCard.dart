import 'package:flutter/material.dart';

class SquareCard extends StatelessWidget {
  const SquareCard(
      {super.key,
      this.onTap,
      this.image = 'assets/genreImages/notImplemented.png',
      this.text = ''});

  final VoidCallback? onTap;
  final String image;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Material(
        color: Colors.transparent,
        child: Ink.image(
          image: NetworkImage(image),
          fit: BoxFit.cover,
          child: InkWell(
            splashColor: const Color.fromARGB(80, 255, 255, 255),
            onTap: onTap,
            child: Center(
                child: Text(text.toString(),
                    style: const TextStyle(color: Colors.white))),
          ),
        ),
      ),
    );
  }
}
