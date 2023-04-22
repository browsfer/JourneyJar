import 'package:flutter/material.dart';
import 'package:my_favorite_places/helpers/auth.dart';
import 'package:my_favorite_places/screens/country_selection_screen.dart';
import 'package:my_favorite_places/screens/user_settings_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../screens/auth_screen.dart';

class UserDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    final User? isLogged = firebaseAuth.currentUser;

    return Drawer(
      child: isLogged == null
          ? Column(
              children: [
                const UserAccountsDrawerHeader(
                  currentAccountPicture: CircleAvatar(
                    child: Icon(Icons.person),
                  ),
                  accountName: null,
                  accountEmail: null,
                ),
                ListTile(
                  leading: const Icon(Icons.create),
                  title: const Text('Create Account'),
                  onTap: () {
                    Navigator.of(context).pushNamed(AuthScreen.routeName);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.place),
                  title: const Text('My Places'),
                  onTap: () {
                    // My places
                  },
                ),
              ],
            )
          : Column(
              children: [
                const UserAccountsDrawerHeader(
                  accountName: Text('Example One'),
                  accountEmail: Text('example@example.com'),
                  currentAccountPicture: CircleAvatar(
                    child: Icon(Icons.person), // later user avatar
                  ),
                ),
                Expanded(
                  child: ListView(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.home),
                        title: const Text('My places'),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.map),
                        title: const Text('Select Country'),
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(CountrySelectionScreen.routeName);
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.settings),
                        title: const Text('Settings'),
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(UserSettingsScreen.routeName);
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.help),
                        title: const Text('Help'),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: ListTile(
                    leading: const Icon(Icons.logout),
                    title: const Text('Logout'),
                    onTap: () {
                      Auth().signOut();
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
