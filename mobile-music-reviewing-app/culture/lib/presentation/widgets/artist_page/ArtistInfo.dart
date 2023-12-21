import 'package:flutter/material.dart';

class ArtistInfo extends StatelessWidget {
  const ArtistInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
            width: 150,
            height: 150,
            child: Image.asset('assets/genreImages/blues.jpg')),
        const SizedBox(
          width: 10,
        ),
        const Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [Text('Age'), Text('Artist'), Text('Genres')]),
      ],
    );
  }
}
