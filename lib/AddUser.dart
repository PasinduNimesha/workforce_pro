import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class AddUser extends StatefulWidget {
  const AddUser({Key? key}) : super(key: key);

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _employeeIdController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  String? _role;
  String? _selectedGender;

  @override
  void dispose() {
    _userNameController.dispose();
    _employeeIdController.dispose();
    _passwordController.dispose();
    _emailController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  Future<void> _submitUser(BuildContext context) async {
    final String username = _userNameController.text;
    final String employeeId = _employeeIdController.text;
    final String password = _passwordController.text;
    final String email = _emailController.text;
    final String firstName = _firstNameController.text;
    final String lastName = _lastNameController.text;
    final String gender = _selectedGender ?? '';
    final String role = _role ?? '';

    final url = Uri.parse('http://192.168.43.214:8080/user');
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'employeeId': employeeId,
        'password': password,
        'email': email,
        'role': role,
        'firstName': firstName,
        'lastName': lastName,
        'gender': gender,
      }),
    );

    if (response.statusCode == 200) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Success'),
            content: Text('User added successfully'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context); // Navigate back twice to return to the previous screen
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      // Request failed
      print('Failed to add user. Status code: ${response.statusCode}');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Failed to add user'),
            content: Text('Failed to add user. Status code: ${response.statusCode}'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context); // Navigate back twice to return to the previous screen
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Leave Application'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _userNameController,
                decoration: InputDecoration(labelText: 'Enter username'),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _employeeIdController,
                decoration: InputDecoration(labelText: 'Enter employee Id'),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Enter a default password',),
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Enter email address'),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _firstNameController,
                decoration: InputDecoration(labelText: 'Enter first name'),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _lastNameController,
                decoration: InputDecoration(labelText: 'Enter last name'),
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: _selectedGender,

                onChanged: (String? newValue) {
                  setState(() {
                    _selectedGender = newValue;
                  });
                },
                items: <String>['Male', 'Female', 'Other']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                decoration: InputDecoration(labelText: 'Select gender'),
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: _role,
                onChanged: (String? newValue) {
                  setState(() {
                    _role = newValue;
                  });
                },
                items: <String>['Standard User', 'Elevated User', 'Manager']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                decoration: InputDecoration(labelText: 'Select role'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _submitUser(context);
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
