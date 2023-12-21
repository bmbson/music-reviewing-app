import 'package:culture/presentation/widgets/user_profile/UserInfo.dart';
import 'package:culture/presentation/widgets/user_profile/VarStarRatingColumn.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key, this.reviewAmount = 0});

  final int reviewAmount;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: ListView(
      children: const [UserInfo(), VarStarRatingColumn()],
    ));
  }
}
