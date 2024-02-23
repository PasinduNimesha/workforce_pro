import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workforce_pro/AddEmployee.dart';
import 'package:workforce_pro/AddUser.dart';
import 'package:workforce_pro/ProfilesOverview.dart';

import 'Home.dart';
import 'Profile.dart';
import 'ViewApplications.dart';

class Administrator extends StatelessWidget {
  const Administrator({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: GridView(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          children: [
            ActionTile(
              title: 'View All Users',
              iconData: Icons.view_list,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfilesOverview()),
                );
              }
            ),
            ActionTile(
                title: 'Add New User',
                iconData: Icons.person_add,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AddUser()),
                  );
                }
            ),
            ActionTile(
                title: 'Add new employee',
                iconData: Icons.person_add_alt_sharp,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AddEmployee()),
                  );
                }
            ),
            ActionTile(
                title: 'View Employees',
                iconData: Icons.view_list,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ViewApplications()),
                  );
                }
            ),
            ActionTile(
                title: 'View Reports',
                iconData: Icons.insert_chart,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ViewApplications()),
                  );
                }
            ),
            ActionTile(
                title: 'View Applications',
                iconData: Icons.view_list,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ViewApplications()),
                  );
                }
            ),
          ]
        ),
      )
    );
  }
}
