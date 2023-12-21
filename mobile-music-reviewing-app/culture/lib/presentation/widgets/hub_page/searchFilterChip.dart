import 'package:culture/models/search_chip_enum.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final selectedChipProvider = StateProvider<int?>((ref) => 2);

class SearchFilterChips extends ConsumerStatefulWidget {
  const SearchFilterChips({super.key});

  @override
  ConsumerState<SearchFilterChips> createState() => _SearchFilterChipsState();
}

class _SearchFilterChipsState extends ConsumerState<SearchFilterChips> {
  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const SizedBox(height: 10.0),
        Wrap(
          spacing: 5.0,
          children: List<Widget>.generate(
            SearchChipEnum.values.length,
            (int index) {
              return ChoiceChip(
                //String manipulation to not get SearchChipEnum.[index] as result.
                label: Text(
                    SearchChipEnum.values[index].toString().split('.').last),
                selected: ref.watch(selectedChipProvider) == index,
                onSelected: (bool selected) {
                  setState(() {
                    ref.watch(selectedChipProvider.notifier).state =
                        selected ? index : null;
                  });
                },
              );
            },
          ).toList(),
        ),
      ],
    );
  }
}
