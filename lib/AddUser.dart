import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class AddUser extends StatefulWidget {
  final int? userId;
  const AddUser({super.key, this.userId});

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
void initState() {
    super.initState();
    if (widget.userId != null) {
      getUser(context);
    }
  }


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

  Future<void> getUser(BuildContext context) async {
    final url = Uri.parse('http://192.168.43.214:8080/user/${widget.userId}');
    print(url);

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> userData = json.decode(response.body);
      _employeeIdController.text = userData['employeeId'].toString();
      _userNameController.text = userData['username'];
      _emailController.text = userData['email'];
      _firstNameController.text = userData['firstName'];
      _lastNameController.text = userData['lastName'];
      _selectedGender = userData['gender'];
      _role = userData['role'];
      print(_userNameController.text);
    } else {
      print('Failed to load user data. Status code: ${response.statusCode}');
    }
  }

  Future<void> _updateUser(BuildContext context) async {
    final String username = _userNameController.text;
    final String employeeId = _employeeIdController.text;
    final String password = _passwordController.text;
    final String email = _emailController.text;
    final String firstName = _firstNameController.text;
    final String lastName = _lastNameController.text;
    final String gender = _selectedGender ?? '';
    final String role = _role ?? '';
    final url = Uri.parse('http://192.168.43.214:8080/user/update/${widget.userId}');

    final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'id': widget.userId.toString(),
          'username': username,
          'employeeId': employeeId,
          'password': password,
          'email': email,
          'role': role,
          'firstName': firstName,
          'lastName': lastName,
          'gender': gender
        }
        )
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Success'),
            content: Text('User updated successfully'),
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
      print('Failed to update user. Status code: ${response.statusCode}');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Failed to update user'),
            content: Text('Failed to update user. Status code: ${response.statusCode}'),
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
        title: const Text('Add User'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _userNameController,
                decoration: const InputDecoration(labelText: 'Enter username', border: OutlineInputBorder()),
              ),
              if(widget.userId == null) const SizedBox(height: 20),
              if(widget.userId == null) TextFormField(
                controller: _employeeIdController,
                decoration: InputDecoration(labelText: 'Enter employee Id', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Enter a default password', border: OutlineInputBorder()),
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Enter email address', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _firstNameController,
                decoration: InputDecoration(labelText: 'Enter first name', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _lastNameController,
                decoration: InputDecoration(labelText: 'Enter last name', border: OutlineInputBorder()),
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
                decoration: InputDecoration(labelText: 'Select gender', border: OutlineInputBorder()),
              ),
              if(widget.userId == null) const SizedBox(height: 20),
              if(widget.userId == null) DropdownButtonFormField<String>(
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
                decoration: InputDecoration(labelText: 'Select role', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (widget.userId != null) {
                    print('Updating user');
                    _updateUser(context);
                  } else {
                    print('Adding user');
                    _submitUser(context);
                  }
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
