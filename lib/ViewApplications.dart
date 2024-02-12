import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ViewApplications extends StatefulWidget {
  const ViewApplications({super.key});

  @override
  State<ViewApplications> createState() => _ViewApplicationsState();
}

class _ViewApplicationsState extends State<ViewApplications> {
  List<String> applications = [
    "Maternity Leave",
    "Sick Leave",
    "Vacation Leave",
    "Emergency Leave",
    "Study Leave"
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('View Applications'),
        ),
        body: Builder(
          builder: (context) {
            return ListView.builder(
              itemCount: applications.length,
              itemBuilder: (context, index) {
                return ApplicationTile(
                  title: applications[index],
                );
              },
            );
          }
        )
      ),
    );
  }
}

class ApplicationTile extends StatelessWidget {
  final String title;
  const ApplicationTile({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
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

