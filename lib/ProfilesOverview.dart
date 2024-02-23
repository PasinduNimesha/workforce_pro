import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:page_transition/page_transition.dart';
import 'package:workforce_pro/ViewProfile.dart';

class ProfilesOverview extends StatefulWidget {
  const ProfilesOverview({Key? key}) : super(key: key);

  @override
  _ProfilesOverviewState createState() => _ProfilesOverviewState();
}

class _ProfilesOverviewState extends State<ProfilesOverview> {
  late List<Map<String, dynamic>> _profiles = [];

  @override
  void initState() {
    super.initState();
    _fetchProfiles();
  }

  Future<void> _fetchProfiles() async {
    final response = await http.get(Uri.parse('http://192.168.43.214:8080/user/list'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      setState(() {
        _profiles = List<Map<String, dynamic>>.from(data);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to load profiles')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profiles Overview'),
      ),
      body: _profiles == []
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: _profiles.length,
        itemBuilder: (context, index) {
          final profile = _profiles[index];
          return ProfilePreview(
            title: profile['username'],
            onTap: () {
              Navigator.push(
                context,
                PageTransition(
                  child: ViewProfile(userId: profile['id']),
                  type: PageTransitionType.rightToLeftWithFade,
                  alignment: Alignment.bottomCenter,
                  duration: const Duration(milliseconds: 200),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class ProfilePreview extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  const ProfilePreview({Key? key, required this.title, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text(title),
      subtitle: const Text('This is a profile'),
      leading: const Icon(Icons.person),
    );
  }
}
