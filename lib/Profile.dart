import 'package:flutter/material.dart';
import 'package:workforce_pro/Home.dart';
import 'package:workforce_pro/Settings.dart';

import 'Administrator.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  int _currentIndex = 0;
  String _title = 'Profile';
  final List<Widget> _children = [
    const Home(),
    const Administrator(),
    const Settings(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
            switch(index) {
              case 0:
                _title = 'Home';
                break;
              case 1:
                _title = 'Administrator';
                break;
              case 2:
                _title = 'Settings';
                break;
            }
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.admin_panel_settings),
            label: 'Admin',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],

      )
    );
  }
}





