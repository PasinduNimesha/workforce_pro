import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ViewEmployee extends StatefulWidget {
  final int userId;
  const ViewEmployee({Key? key, required this.userId}) : super(key: key);

  @override
  _ViewEmployeeState createState() => _ViewEmployeeState();
}

class _ViewEmployeeState extends State<ViewEmployee> {
  late Future<Map<String, dynamic>> _userData;

  @override
  void initState() {
    super.initState();
    _userData = fetchUserData(); // Call a function to fetch user data
  }

  Future<Map<String, dynamic>> fetchUserData() async {
    final response = await http.get(Uri.parse('http://192.168.43.214:8080/employee/${widget.userId}'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> userData = json.decode(response.body);
      userData['birthDate'] = DateTime.fromMillisecondsSinceEpoch(userData['birthDate']).toString().split(' ').first;
      return userData;
    } else {
      throw Exception('Failed to load user data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Employee'),
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
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      title: Text('Full Name'),
                      subtitle: Text(userData['fullName']),
                    ),
                    ListTile(
                      title: Text('BirthDate'),
                      subtitle: Text(userData['birthDate']),
                    ),
                    ListTile(
                      title: Text('Marital Status'),
                      subtitle: Text(userData['maritalStatus']),
                    ),
                    ListTile(
                      title: Text('Emergency Contact'),
                      subtitle: Text(userData['emergencyContact']),
                    ),
                    ListTile(
                      title: Text('Organization Id'),
                      subtitle: Text(userData['organizationId'].toString()),
                    ),
                    ListTile(
                      title: Text('Job ID'),
                      subtitle: Text(userData['jobId'].toString()),
                    ),
                    ListTile(
                      title: Text('Address'),
                      subtitle: Text(userData['address']),
                    ),
                    ListTile(
                      title: Text('Employment Status'),
                      subtitle: Text(userData['employmentStatus']),
                    ),
                    ListTile(
                      title: Text('Supervisor'),
                      subtitle: Text(userData['supervisor'].toString()),
                    ),
                    ListTile(
                      title: Text('Branch ID'),
                      subtitle: Text(userData['branchId'].toString()),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

