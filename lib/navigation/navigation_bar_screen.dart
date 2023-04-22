import 'package:flutter/material.dart';
import 'navigation_bar_provider.dart';
import 'package:provider/provider.dart';

class NavigationBarScreen extends StatelessWidget {
  static const routeName = '/navigation-bar-screen';
  const NavigationBarScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navBar = Provider.of<NavigationBarProvider>(context);
    return Scaffold(
      body: navBar.navBarItems[navBar.selectedIndex].screen,
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blueGrey,
        backgroundColor: Theme.of(context).colorScheme.primary,
        currentIndex: navBar.selectedIndex,
        onTap: (i) {
          navBar.changeIndex = i;
        },
        items: navBar.navBarItems
            .map((e) => BottomNavigationBarItem(
                  icon: Icon(e.icon),
                  label: e.label,
                ))
            .toList(),
      ),
    );
  }
}
