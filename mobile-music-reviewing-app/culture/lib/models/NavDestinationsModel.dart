import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

//Provider used for navigation throughout the application.
final selectedIndexProvider = StateProvider((ref) => 0);

class NavDestinations {
  static const List<NavigationDestination> destinations = [
    NavigationDestination(
      icon: Icon(Icons.home_outlined),
      selectedIcon: Icon(Icons.home),
      label: 'Home',
    ),
    NavigationDestination(
      icon: Icon(Icons.person_2_outlined),
      selectedIcon: Icon(Icons.person_2),
      label: 'Profile',
    ),
    NavigationDestination(
      icon: Icon(Icons.bookmark_border_outlined),
      selectedIcon: Icon(Icons.bookmark),
      label: 'Bookmarks',
    ),
    NavigationDestination(
      icon: Icon(Icons.logout_outlined),
      selectedIcon: Icon(Icons.logout_outlined),
      label: 'Log Out',
    ),
  ];
}
