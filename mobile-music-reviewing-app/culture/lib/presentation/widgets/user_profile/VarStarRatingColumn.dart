import 'package:culture/presentation/widgets/user_profile/VarStarRatingColumnItem.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final selectedRatingProvider = StateProvider<double>((ref) => 5);

class VarStarRatingColumn extends ConsumerWidget {
  const VarStarRatingColumn({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        VarStarRatingColumnItem(
          starAmount: 5,
          onTap: () {
            ref.read(selectedRatingProvider.notifier).state = 5;
            context.go('/userprofilescaffold/5');
          },
        ),
        VarStarRatingColumnItem(
          starAmount: 4.5,
          onTap: () {
            ref.read(selectedRatingProvider.notifier).state = 4.5;
            context.go('/userprofilescaffold/4.5');
          },
        ),
        VarStarRatingColumnItem(
          starAmount: 4,
          onTap: () {
            ref.read(selectedRatingProvider.notifier).state = 4.0;
            context.go('/userprofilescaffold/4');
          },
        ),
        VarStarRatingColumnItem(
          starAmount: 3.5,
          onTap: () {
            ref.read(selectedRatingProvider.notifier).state = 3.5;
            context.go('/userprofilescaffold/3.5');
          },
        ),
        VarStarRatingColumnItem(
          starAmount: 3,
          onTap: () {
            ref.read(selectedRatingProvider.notifier).state = 3;
            context.go('/userprofilescaffold/3');
          },
        ),
        VarStarRatingColumnItem(
          starAmount: 2.5,
          onTap: () {
            ref.read(selectedRatingProvider.notifier).state = 2.5;
            context.go('/userprofilescaffold/2.5');
          },
        ),
        VarStarRatingColumnItem(
          starAmount: 2,
          onTap: () {
            ref.read(selectedRatingProvider.notifier).state = 2;
            context.go('/userprofilescaffold/2');
          },
        ),
        VarStarRatingColumnItem(
          starAmount: 1.5,
          onTap: () {
            ref.read(selectedRatingProvider.notifier).state = 1.5;
            context.go('/userprofilescaffold/1.5');
          },
        ),
        VarStarRatingColumnItem(
          starAmount: 1,
          onTap: () {
            ref.read(selectedRatingProvider.notifier).state = 1;
            context.go('/userprofilescaffold/1');
          },
        ),
        VarStarRatingColumnItem(
          starAmount: 0.5,
          onTap: () {
            ref.read(selectedRatingProvider.notifier).state = 0.5;
            context.go('/userprofilescaffold/0.5');
          },
        ),
      ],
    );
  }
}
