import 'package:flutter/material.dart';


class AddEmployee extends StatefulWidget {
  const AddEmployee({Key? key}) : super(key: key);

  @override
  State<AddEmployee> createState() => _AddEmployeeState();
}

class _AddEmployeeState extends State<AddEmployee> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _birthdateController = TextEditingController();
  final TextEditingController _maritalStatusController = TextEditingController();
  final TextEditingController _emergencyContactController = TextEditingController();
  final TextEditingController _organizationIdController = TextEditingController();
  final TextEditingController _jobIdController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _employmentStatusController = TextEditingController();
  final TextEditingController _supervisorController = TextEditingController();
  final TextEditingController _branchIdController = TextEditingController();
  DateTime? _selectedDate;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Employee'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _fullNameController,
                decoration: const InputDecoration(labelText: 'Full Name'),
              ),
              const SizedBox(height: 20),
              RowDatePicker(
                  message: "Birthdate",
                  onDateSelected: (date) {
                    setState(() {
                      _selectedDate = date;
                      _birthdateController.text = date.toLocal().toString().split(' ')[0];
                    });
                  },
              ),


              const SizedBox(height: 20),
              TextFormField(
                controller: _maritalStatusController,
                decoration: InputDecoration(labelText: 'Marital Status'),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _emergencyContactController,
                decoration: InputDecoration(labelText: 'Emergency Contact'),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _organizationIdController,
                decoration: InputDecoration(labelText: 'Organization ID'),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _jobIdController,
                decoration: InputDecoration(labelText: 'Job ID'),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _addressController,
                decoration: InputDecoration(labelText: 'Address'),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _employmentStatusController,
                decoration: InputDecoration(labelText: 'Employment Status'),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _supervisorController,
                decoration: InputDecoration(labelText: 'Supervisor'),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _branchIdController,
                decoration: InputDecoration(labelText: 'Branch ID'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Handle submit logic here
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _birthdateController.dispose();
    _maritalStatusController.dispose();
    _emergencyContactController.dispose();
    _organizationIdController.dispose();
    _jobIdController.dispose();
    _addressController.dispose();
    _employmentStatusController.dispose();
    _supervisorController.dispose();
    _branchIdController.dispose();
    super.dispose();
  }
}

class RowDatePicker extends StatefulWidget {
  final String message;
  final ValueChanged<DateTime> onDateSelected;
  const RowDatePicker({super.key, required this.message, required this.onDateSelected});

  @override
  State<RowDatePicker> createState() => _RowDatePickerState();
}

class _RowDatePickerState extends State<RowDatePicker> {
  DateTime? _selectedDate;
  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(_selectedDate == null ? 'Select ${widget.message}' : widget.message, style: TextStyle(fontSize: 16),),
          const SizedBox(width: 50,),
          TextButton(
              onPressed: () async {
                final pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2010),
                  lastDate: DateTime(2030),
                );
                if (pickedDate != null) {
                  setState(() {
                    _selectedDate = pickedDate;
                  });
                  widget.onDateSelected(pickedDate);
                }
              },
              child: Text(_selectedDate == null ? 'Select date' : '${_selectedDate!.toLocal()}'.split(' ')[0],
              )
          )
        ]
    );
  }
}



