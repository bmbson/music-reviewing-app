import 'package:flutter/material.dart';

class RectangleCard extends StatelessWidget {
  const RectangleCard(
      {super.key,
      this.name = 'default',
      this.onTap,
      this.image = 'genreImages/ambient.jpg'});

  final String name;
  final String image;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Material(
            color: Colors.transparent,
            child: Ink.image(
              image: AssetImage(image),
              fit: BoxFit.cover,
              child: InkWell(
                splashColor: const Color.fromARGB(80, 255, 255, 255),
                onTap: onTap,
                child: SizedBox(
                  height: 150,
                  child: Center(child: Text(name)),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
