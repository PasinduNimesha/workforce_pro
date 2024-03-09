import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'LeaveApplication.dart';
import 'PendingApplications.dart';
import 'ProfilesOverview.dart';
import 'ViewApplications.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 2,
            child: UpperProfile(),
          ),
          Expanded(
            flex: 3,
            child: LowerProfile(),
          ),
        ],
      ),
    );
  }
}



class UpperProfile extends StatelessWidget {
  const UpperProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: const Padding(
        padding: EdgeInsets.all(30.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                CircleAvatar(backgroundImage: NetworkImage('https://thicc-af.mywaifulist.moe/waifus/pipkin-pippa/ZyayaR059j0Ktwq8hX2AxV8kfJ08XCsWc2QfPwzW.png?class=thumbnail',), radius: 60,),
                Text('Name'),
                Text('Role'),
              ],
            ),
            Column(
              children: [
                Text('asdasdasdEmail'),
                Text('Phone'),
                Text('Address'),
              ],
            ),
          ],
        ),
      )
    );
  }
}


class LowerProfile extends StatelessWidget {
  const LowerProfile({super.key});

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
                    type: PageTransitionType.scale,
                    alignment: Alignment.center,
                    duration: const Duration(milliseconds: 300)
                )

            );
          }
          ),
          ActionTile(iconData: Icons.remove_red_eye, title: 'View your applications', onTap: () {
            Navigator.push(
                context,
                PageTransition(
                    child: const ViewApplications(),
                    type: PageTransitionType.rightToLeftWithFade,
                    alignment: Alignment.center,
                    duration: const Duration(milliseconds: 300)
                )
            );
          },),
          ActionTile(iconData: Icons.list, title: 'View pending applications', onTap: () {
            Navigator.push(
                context,
                PageTransition(
                    child: const PendingApplications(),
                    type: PageTransitionType.scale,
                    alignment: Alignment.bottomLeft,
                    duration: const Duration(milliseconds: 300)
                )
            );
          },),
          ActionTile(iconData: Icons.person_pin_sharp, title: 'View Subordinates', onTap: () {
            Navigator.push(
                context,
                PageTransition(
                    child: const ProfilesOverview(),
                    type: PageTransitionType.scale,
                    alignment: Alignment.bottomRight,
                    duration: const Duration(milliseconds: 300)
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
      child: Card(
        color: Colors.red,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
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