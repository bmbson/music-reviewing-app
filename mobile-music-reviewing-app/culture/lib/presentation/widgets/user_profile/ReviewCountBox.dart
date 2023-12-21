import 'package:flutter/material.dart';

class ReviewCountBox extends StatelessWidget {
  const ReviewCountBox({super.key, this.reviewAmount = 0});

  final int reviewAmount;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text("Rating Count:"),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.black,
              ),
              width: 75,
              height: 75,
              child: Center(
                  child: Text(reviewAmount.toString(),
                      style: Theme.of(context).textTheme.headlineSmall))),
        ),
      ],
    );
  }
}
