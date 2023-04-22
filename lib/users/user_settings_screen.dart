import 'package:flutter/material.dart';

class UserSettingsScreen extends StatefulWidget {
  static const routeName = '/user-settings';

  @override
  _UserSettingsScreenState createState() => _UserSettingsScreenState();
}

class _UserSettingsScreenState extends State<UserSettingsScreen> {
  bool _darkModeEnabled = false;
  String _language = 'English';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Settings'),
      ),
      body: Column(
        children: [
          ListTile(
            title: const Text('Notifications'),
            trailing: Switch(
              value: false,
              onChanged: (_) {},
            ),
          ),
          ListTile(
            title: const Text('Dark Mode'),
            trailing: Switch(
              activeColor: Colors.amber,
              value: _darkModeEnabled,
              onChanged: (value) {
                setState(() {
                  _darkModeEnabled = value;
                });
              },
            ),
          ),
          ListTile(
            title: const Text('Language'),
            trailing: DropdownButton<String>(
              value: _language,
              onChanged: (value) {
                setState(() {
                  _language = value!;
                });
              },
              items: <String>[
                'English',
                'Spanish',
                'French',
                'German',
                'Italian',
                'Portuguese',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
