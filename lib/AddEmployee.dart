import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

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
                decoration: const InputDecoration(labelText: 'Full Name', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RowDatePicker(
                      message: "Birthdate",
                      onDateSelected: (date) {
                        setState(() {
                          _selectedDate = date;
                          _birthdateController.text = date.toLocal().toString().split(' ')[0];
                        });
                      },
                  ),
                ),
              ),


              const SizedBox(height: 20),
              TextFormField(
                controller: _maritalStatusController,
                decoration: InputDecoration(labelText: 'Marital Status', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _emergencyContactController,
                decoration: InputDecoration(labelText: 'Emergency Contact', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _organizationIdController,
                decoration: InputDecoration(labelText: 'Organization ID', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _jobIdController,
                decoration: InputDecoration(labelText: 'Job ID', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _addressController,
                decoration: InputDecoration(labelText: 'Address', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _employmentStatusController,
                decoration: InputDecoration(labelText: 'Employment Status', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _supervisorController,
                decoration: InputDecoration(labelText: 'Supervisor', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _branchIdController,
                decoration: InputDecoration(labelText: 'Branch ID', border: OutlineInputBorder()),
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

  const RowDatePicker({Key? key, required this.message, required this.onDateSelected})
      : super(key: key);

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
        Text(
          _selectedDate == null ? 'Select ${widget.message}' : widget.message,
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(width: 50),
        TextButton(
          onPressed: () {
            _showDatePicker(context);
          },
          child: Text(
            _selectedDate == null
                ? 'Select date'
                : '${_selectedDate!.toLocal()}'.split(' ')[0],
          ),
        )
      ],
    );
  }

  Future<void> _showDatePicker(BuildContext context) async {
    final pickedDate = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(10),
          content: SizedBox(
            height: 300,
            child: SfDateRangePicker(
              selectionMode: DateRangePickerSelectionMode.single,
              showActionButtons: true,
              onSubmit: (value) {
                Navigator.pop(context, value);
              },
              onCancel: () {
                Navigator.pop(context, null);
              },
              onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
                if (args.value is PickerDateRange) {
                  final PickerDateRange range = args.value!;
                  if (range.startDate != null) {
                    Navigator.pop(context, range.startDate);
                  }
                } else if (args.value is DateTime) {
                  final DateTime selectedDate = args.value!;
                  Navigator.pop(context, selectedDate);
                }
              },
              initialSelectedRange: PickerDateRange(
                DateTime.now(),
                DateTime.now(),
              ),
            ),
          ),
        );
      },
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
      widget.onDateSelected(pickedDate);
    }
  }
}




