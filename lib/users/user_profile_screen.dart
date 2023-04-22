import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_favorite_places/helpers/auth.dart';
import 'package:my_favorite_places/screens/guest_profile_screen.dart';
import 'package:my_favorite_places/screens/user_settings_screen.dart';
import 'package:line_icons/line_icons.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfileScreen> {
  final User? _isLogged = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: _isLogged == null
          ? const GuestProfileScreen()
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 10, bottom: 10),
                    height: 200,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage('https://i.pravatar.cc/300'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: IconButton(
                          icon: const Icon(LineIcons.camera),
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Text(
                          'John Doe',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const Spacer(),
                        IconButton(
                            onPressed: () => Navigator.of(context)
                                .pushNamed(UserSettingsScreen.routeName),
                            icon: const Icon(
                              LineIcons.tools,
                              size: 30,
                            ))
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'johndoe@example.com',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Bio',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum consectetur nibh ut lorem eleifend, ac pretium tortor placerat. Suspendisse lobortis vestibulum elit vel pulvinar.',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Favorite countries',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Wrap(
                      spacing: 10,
                      children: const [
                        Chip(
                          label: Text('Poland'),
                        ),
                        Chip(
                          label: Text('Mexico'),
                        ),
                        Chip(
                          label: Text('Spain'),
                        ),
                        Chip(
                          label: Text('Morocco'),
                        ),
                      ],
                    ),
                  ),
                  ButtonBar(
                    children: [
                      IconButton(
                        iconSize: 40,
                        onPressed: () => Auth().signOut(),
                        icon: const Icon(LineIcons.alternateSignOut),
                      ),
                    ],
                  )
                ],
              ),
            ),
    );
  }
}
