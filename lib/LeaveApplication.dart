import 'package:flutter/material.dart';
import 'package:workforce_pro/AddEmployee.dart';

class LeaveApplication extends StatefulWidget {
  const LeaveApplication({super.key});

  @override
  State<LeaveApplication> createState() => _LeaveApplicationState();
}

class _LeaveApplicationState extends State<LeaveApplication> {
  final TextEditingController _leaveTypeController = TextEditingController();
  final TextEditingController _reasonController = TextEditingController();

  @override
  void dispose() {
    _leaveTypeController.dispose();
    _reasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Leave Application'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _leaveTypeController,
                decoration: InputDecoration(labelText: 'Leave Type'),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _reasonController,
                decoration: InputDecoration(labelText: 'Reason for Leave'),
                maxLines: 3,
              ),
              const SizedBox(height: 20),
              DatePicker(message: "Start Date"),
              const SizedBox(height: 20),
              DatePicker(message: "End Date"),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  final String name = _leaveTypeController.text;
                  final String reason = _reasonController.text;
                  print('Name: $name');
                  print('Reason: $reason');
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

