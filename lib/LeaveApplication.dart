import 'package:flutter/material.dart';
import 'package:workforce_pro/AddEmployee.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class LeaveApplication extends StatefulWidget {
  const LeaveApplication({super.key});

  @override
  State<LeaveApplication> createState() => _LeaveApplicationState();
}

class _LeaveApplicationState extends State<LeaveApplication> {
  final TextEditingController _leaveTypeController = TextEditingController();
  final TextEditingController _reasonController = TextEditingController();
  DateTime? _startDate;
  DateTime? _endDate;

  @override
  void dispose() {
    _leaveTypeController.dispose();
    _reasonController.dispose();
    super.dispose();
  }

  Future<void> _submitLeaveApplication() async {
    final String leaveType = _leaveTypeController.text;
    final String reason = _reasonController.text;
    if (leaveType.isNotEmpty && reason.isNotEmpty && _startDate != null && _endDate != null) {
      final url = Uri.parse('http://192.168.43.214:8080/application');
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'employeeId': 1,
          'leaveType': leaveType,
          'reason': reason,
          'startDate': _startDate!.millisecondsSinceEpoch,
          'endDate': _endDate!.millisecondsSinceEpoch,
          'status': 'PENDING',
        }),
      );

      if (response.statusCode == 200) {
        showDialog(context: context, builder: (context) {
          return AlertDialog(
            title: const Text('Leave Application'),
            content: const Text('Leave application submitted successfully'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          );
        });

      } else {

        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Failed to submit leave application')));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please fill all fields')));
    }
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
                decoration: const InputDecoration(labelText: 'Leave Type'),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _reasonController,
                decoration: const InputDecoration(labelText: 'Reason for Leave'),
                maxLines: 3,
              ),
              const SizedBox(height: 20),
              RowDatePicker(
                message: "Start Date",
                onDateSelected: (date) {
                  setState(() {
                    _startDate = date;
                  });
                },
              ),
              const SizedBox(height: 20),
              RowDatePicker(
                message: "End Date",
                onDateSelected: (date) {
                  setState(() {
                    _endDate = date;
                  });
                },
              ),
              const SizedBox(height: 300),
              ElevatedButton(
                onPressed: _submitLeaveApplication,
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DatePicker extends StatelessWidget {
  final String message;
  final ValueChanged<DateTime>? onDateSelected;

  const DatePicker({super.key, required this.message, this.onDateSelected});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime(2100),
        ).then((date) {
          if (date != null && onDateSelected != null) {
            onDateSelected!(date);
          }
        });
      },
      child: Text(message),
    );
  }
}


