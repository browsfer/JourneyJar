import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:my_favorite_places/users/user_settings_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'guest_profile_screen.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

final User? _isLogged = FirebaseAuth.instance.currentUser;

class _UserProfilePageState extends State<UserProfileScreen> {
  String? userEmail;
  String? userName;
  TextEditingController controller = TextEditingController();

  Future<void> _getUserData() async {
    final currentUserId = _auth.currentUser!.uid;

    await _firestore.collection('users').doc(currentUserId).get().then((value) {
      setState(() {
        userName = value.data()!['username'].toString();
        userEmail = value.data()!['email'].toString();
      });
    });
  }

  Future changeUserName() async {
    final userId = _auth.currentUser!.uid;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Change your nickname"),
          content: TextField(
            controller: controller,
            autofocus: true,
            decoration: const InputDecoration(hintText: "Type something here"),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Save"),
              onPressed: () {
                setState(() {
                  userName = controller.text;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
    try {
      await _firestore
          .collection('users')
          .doc(userId)
          .update({'username': controller.text});
    } catch (e) {
      print(e);
    }
  }

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
                          userName ?? '',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        IconButton(
                          onPressed: changeUserName,
                          icon: const Icon(LineIcons.edit),
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
                      userEmail ?? '',
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
                        onPressed: () => _auth.signOut(),
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
