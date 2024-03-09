import 'package:flutter/material.dart';
import 'package:workforce_pro/AddUser.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            SettingsCard(
              title: 'Change user info',
              icon: Icons.person_outline_sharp,
              onTap: () {
                print("Moving");
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AddUser(userId: 2,)
                    )
                );
              },
            ),
            SettingsCard(
              title: 'Notifications',
              icon: Icons.notifications,
              onTap: () {
                print("Bruh");
              },
            ),
            SettingsCard(
              title: 'Dark Mode',
              icon: Icons.dark_mode,
              onTap: () {
                print("Bruh");
              },
            ),
            SettingsCard(
              title: 'Language',
              icon: Icons.language,
              onTap: () {
                print("Bruh");
              },
            ),
            SettingsCard(
              title: 'About',
              icon: Icons.info,
              onTap: () {
                print("Bruh");
              },
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
  final VoidCallback onTap;

  const SettingsCard({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        trailing: const Icon(Icons.keyboard_arrow_right),
        onTap: () {
          onTap();
        },
      ),
    );
  }
}
