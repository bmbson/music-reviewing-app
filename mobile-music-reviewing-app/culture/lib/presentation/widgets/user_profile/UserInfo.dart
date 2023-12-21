import 'package:flutter/material.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: SizedBox(
                width: 125,
                height: 125,
                child: Image.asset('assets/genreImages/blues.jpg')),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        const Column(children: [Text('Denzel'), Text('Lelystad')]),
      ],
    );
  }
}
