import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: const [
            SettingsCard(
              title: 'Change user info',
              icon: Icons.person_outline_sharp,
            ),
            SettingsCard(
              title: 'Notifications',
              icon: Icons.notifications,
            ),
            SettingsCard(
              title: 'Dark Mode',
              icon: Icons.dark_mode,
            ),
            SettingsCard(
              title: 'Language',
              icon: Icons.language,
            ),
            SettingsCard(
              title: 'About',
              icon: Icons.info,
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsCard extends StatelessWidget {
  final String title;
  final IconData icon;

  const SettingsCard({
    Key? key,
    required this.title,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        trailing: const Icon(Icons.keyboard_arrow_right),
        onTap: () {
          // Handle onTap event
        },
      ),
    );
  }
}
