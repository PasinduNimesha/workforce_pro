import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfilesOverview extends StatelessWidget {
  const ProfilesOverview({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> profiles = [
      "Profile 1",
      "Profile 2",
      "Profile 3",
      "Profile 4",
      "Profile 5"
    ];
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Profiles Overview'),
        ),
        body: Builder(
          builder: (context) {
            return ListView.builder(
              itemCount: profiles.length,
              itemBuilder: (context, index) {
                return ProfilePreview(
                  title: profiles[index],
                );
              },
            );
          }
      ),
    )
    );
  }
}

class ProfilePreview extends StatelessWidget {
  final String title;
  const ProfilePreview({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Text('This is a profile'),
      leading: Icon(Icons.person),
    );
  }
}

