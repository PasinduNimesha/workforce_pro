import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

import 'ViewApplications.dart';

class PendingApplications extends StatefulWidget {
  const PendingApplications({super.key});

  @override
  State<PendingApplications> createState() => _PendingApplicationsState();
}

class _PendingApplicationsState extends State<PendingApplications> {
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
        applications = responseData.map((data) => Application.fromJson(data)).toList();
      });
    } else {
      print('Failed to fetch applications. Status code: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Pending Applications'),
        ),
        body: applications.isEmpty ? const Center(child: CircularProgressIndicator()) : Builder(
            builder: (context) {
              return ListView.builder(
                itemCount: applications.length,
                itemBuilder: (context, index) {
                  return ApplicationPreview(
                    title: applications[index].leaveType,
                    startDate: applications[index].startDate?.toString().split(' ')[0] ?? '',
                    endDate: applications[index].endDate?.toString().split(' ')[0] ?? '',
                    leading: Icons.medical_services,
                    onTap: () {},
                  );
                },
              );
            }
        )
    );
  }
}

class ApplicationPreview extends StatelessWidget {
  final String title;
  final String startDate;
  final String endDate;
  final IconData leading;
  final VoidCallback onTap;

  const ApplicationPreview({
    super.key, required this.title,
    required this.startDate,
    required this.endDate,
    required this.leading,
    required this.onTap
  }
  );

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      borderOnForeground: true,
      child: ListTile(
        title: Center(child: Text(title)),
        subtitle: Column(
          children: [
            const SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("Start: $startDate"),
                Text("End: $endDate"),
              ],
            ),
            const SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(child: Icon(Icons.approval), onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Approved'))
                  );
                },
                ),
                GestureDetector(child: Icon(Icons.cancel), onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Rejected'))
                  );
                },
                ),
              ],
            ),
          ],
        ),
        leading: Icon(leading),
        onTap: onTap,
      ),
    );
  }
}

