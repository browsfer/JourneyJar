import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import '../places/add_place_screen.dart';
import '../places/categories_screen.dart';
import '../places/places_list_screen.dart';
import '../users/user_profile_screen.dart';

class NavigationBarProvider with ChangeNotifier {
  List<NavbarItem> navBarItems = [
    NavbarItem(
      label: 'Home',
      icon: LineIcons.home,
      screen: CategoryScreen(),
    ),
    NavbarItem(
      label: 'Favorites',
      icon: LineIcons.heartAlt,
      screen: PlacesListScreen(),
    ),
    NavbarItem(
      label: 'My places',
      icon: LineIcons.alternateMapMarker,
      screen: AddPlaceScreen(),
    ),
    NavbarItem(
      label: 'User Profile',
      icon: LineIcons.user,
      screen: const UserProfileScreen(),
    ),
  ];

  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  set changeIndex(int value) {
    _selectedIndex = value;
    notifyListeners();
  }
}

class NavbarItem {
  String label;
  Widget screen;
  IconData icon;

  NavbarItem({required this.label, required this.icon, required this.screen});
}
