import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:page_transition/page_transition.dart';
import 'package:workforce_pro/PendingApplications.dart';
import 'package:workforce_pro/ProfilesOverview.dart';
import 'package:workforce_pro/ViewApplications.dart';

import 'LeaveApplication.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Expanded(
            flex: 2,
            child: UpperProfile(), // Upper part of the profile screen
          ),
          Expanded(
            flex: 3,
            child: LowerProfile(), // Lower part of the profile screen
          ),
        ],
      ),
    );
  }
}

class UpperProfile extends StatelessWidget {
  const UpperProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue, // Example color for upper part
      child: Center(
        child: Text('Upper Profile'),
      ),
    );
  }
}

class LowerProfile extends StatefulWidget {
  const LowerProfile({Key? key}) : super(key: key);

  @override
  State<LowerProfile> createState() => _LowerProfileState();
}

class _LowerProfileState extends State<LowerProfile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      child: GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        children: [
          ActionTile(iconData: Icons.add, title: 'Apply for a leave', onTap: () {
            Navigator.push(
              context,
              PageTransition(
                child: const LeaveApplication(),
            type: PageTransitionType.rightToLeft,
            alignment: Alignment.bottomCenter,
            duration: const Duration(milliseconds: 200)
            )
            );
          }),
          ActionTile(iconData: Icons.remove_red_eye, title: 'View your applications', onTap: () {
            Navigator.push(
                context,
                PageTransition(
                    child: const ViewApplications(),
                    type: PageTransitionType.rightToLeft,
                    alignment: Alignment.bottomCenter,
                    duration: const Duration(milliseconds: 200)
                )
            );
          },),
          ActionTile(iconData: Icons.list, title: 'View pending applications', onTap: () {
            Navigator.push(
                context,
                PageTransition(
                    child: const PendingApplications(),
                    type: PageTransitionType.rightToLeft,
                    alignment: Alignment.bottomCenter,
                    duration: const Duration(milliseconds: 200)
                )
            );
          },),
          ActionTile(iconData: Icons.person_pin_sharp, title: 'View Subordinates', onTap: () {
            Navigator.push(
                context,
                PageTransition(
                    child: const ProfilesOverview(),
                    type: PageTransitionType.rightToLeft,
                    alignment: Alignment.bottomCenter,
                    duration: const Duration(milliseconds: 200)
                )
            );
          },),
          ActionTile(iconData: Icons.payment, title: 'Payment', onTap: () {},),
          ActionTile(iconData: Icons.logout, title: 'Logout', onTap: () {},),
        ],
      ),
      );
  }
}

class ActionTile extends StatelessWidget {
  final IconData iconData;
  final String title;
  final VoidCallback onTap;
  const ActionTile({super.key, required this.iconData, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          color: Colors.red,
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Center(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(iconData, size: 50, color: Colors.white,),
                  ),
                  Text(title),
                ],
              )
            ),
          ),
        ),
      ),
    );
  }
}



