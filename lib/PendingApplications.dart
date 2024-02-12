import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PendingApplications extends StatefulWidget {
  const PendingApplications({super.key});

  @override
  State<PendingApplications> createState() => _PendingApplicationsState();
}

class _PendingApplicationsState extends State<PendingApplications> {
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
                  return ApplicationPreview(
                    title: applications[index],
                    leading: Icons.medical_services,
                  );
                },
              );
            }
          )
      ),
    );
  }
}

class ApplicationPreview extends StatelessWidget {
  final String title;
  final IconData leading;
  const ApplicationPreview({super.key, required this.title, required this.leading});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Center(child: Text(title)),
      subtitle: Row(
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
      leading: Icon(leading),
      onTap: () => {},
    );
  }
}

