import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class VarStarRatingColumnItem extends StatelessWidget {
  VarStarRatingColumnItem(
      {super.key, this.rating = 5, this.starAmount = 5, this.onTap});

  final double rating;
  final double starAmount;
  VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Material(
          color: const Color.fromARGB(255, 65, 72, 77),
          child: InkWell(
            onTap: onTap,
            child: Row(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Icon(
                    Icons.circle_outlined,
                    size: 15,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsetsDirectional.symmetric(horizontal: 8),
                    child: Container(
                      color: const Color.fromARGB(255, 65, 93, 180),
                      height: 40,
                    ),
                  ),
                ),
                for (var i = 0; i < 5; i++) ...[
                  if (i + 0.5 == starAmount) ...[
                    const Icon(
                      Icons.star_half_outlined,
                      size: 15,
                      color: Color.fromARGB(252, 229, 207, 146),
                    )
                  ] else if (i < starAmount) ...[
                    const Icon(
                      Icons.star,
                      size: 15,
                      color: Color.fromARGB(252, 229, 207, 146),
                    )
                  ] else ...[
                    const Icon(Icons.star_border,
                        size: 15, color: Color.fromARGB(252, 229, 207, 146)),
                  ]
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
