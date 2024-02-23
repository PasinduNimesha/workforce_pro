import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:workforce_pro/PendingApplications.dart';

class ViewApplications extends StatefulWidget {
  const ViewApplications({super.key});

  @override
  State<ViewApplications> createState() => _ViewApplicationsState();
}

class _ViewApplicationsState extends State<ViewApplications> {
  List<Application> applications = [];

  @override
  void initState() {
    super.initState();
    fetchApplications();
  }

  Future<void> fetchApplications() async {
    final response = await http.get(Uri.parse('http://192.168.43.214:8080/application'));
    if (response.statusCode == 200) {
      final List<dynamic> responseData = jsonDecode(response.body);
      setState(() {
        applications = [];
        applications = responseData.map((data) => Application.fromJson(data)).toList();
      });
    } else {
      // Handle error
      print('Failed to fetch applications. Status code: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Applications'),
      ),
      body: applications.isEmpty ? const Center(child: CircularProgressIndicator()) : ListView.builder(
        itemCount: applications.length,
        itemBuilder: (context, index) {
          return ApplicationPreview(
            title: applications[index].leaveType,
            startDate: applications[index].startDate?.toString().split(' ')[0] ?? '',
            endDate: applications[index].endDate?.toString().split(' ')[0] ?? '',
            leading: Icons.medical_services,
            onTap: () {}
          );
        },
      ),
    );
  }
}

class Application {
  final int leaveId;
  final int employeeId;
  final String leaveType;
  final DateTime? startDate;
  final DateTime? endDate;
  final String reason;
  final String status;

  Application({
    required this.leaveId,
    required this.employeeId,
    required this.leaveType,
    this.startDate,
    this.endDate,
    required this.reason,
    required this.status,
  });

  factory Application.fromJson(Map<String, dynamic> json) {
    return Application(
      leaveId: json['leaveId'],
      employeeId: json['employeeId'],
      leaveType: json['leaveType'],
      startDate: json['startDate'] != null ? DateTime.fromMillisecondsSinceEpoch(json['startDate']) : null,
      endDate: json['endDate'] != null ? DateTime.fromMillisecondsSinceEpoch(json['endDate']) : null,
      reason: json['reason'],
      status: json['status'],
    );
  }
}


class ApplicationTile extends StatelessWidget {
  final Application application;
  const ApplicationTile({super.key, required this.application});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(application.leaveType),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(child: Icon(Icons.delete), onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Deleted'))
            );
          },
          ),
          GestureDetector(child: Icon(Icons.edit), onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Edited'))
            );
          },
          ),
        ],
      ),
      leading: Icon(Icons.medical_services),
      onTap: () => {
      },
    );
  }
}
