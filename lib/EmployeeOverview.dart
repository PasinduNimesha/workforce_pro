import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:http/http.dart' as http;
import 'package:page_transition/page_transition.dart';
import 'package:workforce_pro/ViewEmployee.dart';

import 'ProfilesOverview.dart';
import 'ViewProfile.dart';

class EmployeeOverview extends StatefulWidget {
  const EmployeeOverview({Key? key}) : super(key: key);

  @override
  _EmployeeOverviewState createState() => _EmployeeOverviewState();
}

class _EmployeeOverviewState extends State<EmployeeOverview> {
  late List<Map<String, dynamic>> _profiles = [];

  @override
  void initState() {
    super.initState();
    _fetchProfiles();
  }

  Future<void> _fetchProfiles() async {
    final response = await http.get(Uri.parse('http://192.168.43.214:8080/employee'));
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
      body: _profiles.isEmpty ? Center(child: Animate(
        effects: const [
          RotateEffect(
            alignment: Alignment.center,
            duration: Duration(seconds: 1),
          )
        ],
        child: const CircularProgressIndicator(),
        onComplete: (controller) {
          controller.loop();
        },
      )) : ListView.builder(itemCount: _profiles.length, itemBuilder: (context, index) {
        final profile = _profiles[index];
        return ProfilePreview(
          title: profile['fullName'],
          onTap: () {
            Navigator.push(
              context,
              PageTransition(
                child: ViewEmployee(userId: profile['employeeId']),
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