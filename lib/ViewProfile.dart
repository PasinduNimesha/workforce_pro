import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ViewProfile extends StatefulWidget {
  final int userId;
  const ViewProfile({Key? key, required this.userId}) : super(key: key);

  @override
  _ViewProfileState createState() => _ViewProfileState();
}

class _ViewProfileState extends State<ViewProfile> {
  late Future<Map<String, dynamic>> _userData;

  @override
  void initState() {
    super.initState();
    _userData = fetchUserData(); // Call a function to fetch user data
  }

  Future<Map<String, dynamic>> fetchUserData() async {
    final response = await http.get(Uri.parse('http://192.168.43.214:8080/user/${widget.userId}'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> userData = json.decode(response.body);
      return userData;
    } else {
      throw Exception('Failed to load user data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Profile'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _userData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            final userData = snapshot.data!;
            return Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    title: Text('Username'),
                    subtitle: Text(userData['username']),
                  ),
                  ListTile(
                    title: Text('Email'),
                    subtitle: Text(userData['email']),
                  ),
                  ListTile(
                    title: Text('Role'),
                    subtitle: Text(userData['role']),
                  ),
                  ListTile(
                    title: Text('First Name'),
                    subtitle: Text(userData['firstName']),
                  ),
                  ListTile(
                    title: Text('Last Name'),
                    subtitle: Text(userData['lastName']),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

