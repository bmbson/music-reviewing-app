import 'package:culture/presentation/widgets/DefaultSearchBar.dart';
import 'package:culture/presentation/widgets/selected_user_list_page/selectedUserListBanner.dart';
import 'package:culture/presentation/widgets/user_list_page/UserListItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SelectedUserListPage extends ConsumerWidget {
  const SelectedUserListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(children: [
      const DefaultSearchBar(),
      const SelectedUserListBanner(),
      Expanded(
        child: ListView.separated(
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
            itemCount: 10,
            itemBuilder: (BuildContext context, int index) {
              return const UserListItem();
            }),
      )
    ]);
  }
}
