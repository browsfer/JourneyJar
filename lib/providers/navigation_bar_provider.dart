import 'package:flutter/material.dart';
import '../places/add_place_screen.dart';
import '../places/categories_screen.dart';
import '../users/user_settings_screen.dart';

class NavigationBarProvider with ChangeNotifier {
  List<NavbarItem> navBarItems = [
    NavbarItem(
      label: 'Home',
      icon: Icons.home,
      screen: CategoryScreen(),
    ),
    NavbarItem(label: 'Favorites', icon: Icons.favorite, screen: null),
    NavbarItem(
      label: 'My places',
      icon: Icons.add_location_alt_outlined,
      screen: AddPlaceScreen(),
    ),
    NavbarItem(
        label: 'User Profile',
        icon: Icons.person,
        screen: UserSettingsScreen()),
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
  Widget? screen;
  IconData icon;

  NavbarItem({required this.label, required this.icon, required this.screen});
}
