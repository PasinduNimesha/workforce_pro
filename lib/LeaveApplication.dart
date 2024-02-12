import 'package:flutter/material.dart';

class LeaveApplication extends StatefulWidget {
  const LeaveApplication({Key? key}) : super(key: key);

  @override
  State<LeaveApplication> createState() => _LeaveApplicationState();
}

class _LeaveApplicationState extends State<LeaveApplication> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _reasonController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _reasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Leave Application'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Your Name'),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _reasonController,
              decoration: InputDecoration(labelText: 'Reason for Leave'),
              maxLines: 3,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Process the leave application here
                final String name = _nameController.text;
                final String reason = _reasonController.text;
                // You can add validation and further processing here
                // For example, you can send this data to a server or perform local storage
                // For now, let's just print the details
                print('Name: $name');
                print('Reason: $reason');
                // Show a confirmation dialog or navigate to a new screen after processing
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}

