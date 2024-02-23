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
    return Scaffold(
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
                    startDate: applications[index],
                    endDate: DateTime.now().toString(),
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
  const ApplicationPreview({super.key, required this.title, required this.startDate, required this.endDate, required this.leading, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      borderOnForeground: true,
      child: ListTile(
        title: Center(child: Text(title)),
        subtitle: Column(
          children: [
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("Start: " + startDate),
                Text("End: " +endDate),
              ],
            ),
            SizedBox(height: 10,),
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

