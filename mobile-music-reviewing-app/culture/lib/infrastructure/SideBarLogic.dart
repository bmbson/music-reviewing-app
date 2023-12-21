import 'package:culture/models/NavDestinationsModel.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SideBarLogic extends ConsumerStatefulWidget {
  final Widget child;

  const SideBarLogic({super.key, required this.child});

  @override
  SideBarLogicState createState() => SideBarLogicState();
}

class SideBarLogicState extends ConsumerState<SideBarLogic> {
  @override
  Widget build(BuildContext context) {
    ref.listen(selectedIndexProvider, (int? prevState, int newState) {
      if (newState == 0) {
        context.go('/');
      } else if (newState == 1) {
        context.go('/userprofilescaffold/5');
      } else if (newState == 2) {
        context.go('/listselectedlist');
      }
    });
    return SizedBox(child: widget.child);
  }
}
