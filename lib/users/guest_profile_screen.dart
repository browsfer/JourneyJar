import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
import 'package:my_favorite_places/screens/auth_screen.dart';

class GuestProfileScreen extends StatelessWidget {
  const GuestProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: Card(
          color: Theme.of(context).colorScheme.secondary,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset('assets/images/splash_photo.png'),
              const SizedBox(height: 20),
              const Text(
                'Create your account to save favorite places!',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w200),
              ),
              const SizedBox(height: 20),
              ButtonBar(
                children: [
                  TextButton.icon(
                    onPressed: () => Navigator.of(context)
                        .pushReplacementNamed(AuthScreen.routeName),
                    icon: LineIcon.alternateSignIn(),
                    label: const Text('Let\'s create my account'),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
