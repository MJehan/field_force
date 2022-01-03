import 'package:field_force/screens/leave_screen.dart';
import 'package:field_force/screens/more_screen.dart';
import 'package:field_force/screens/my_feed.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';




class BottomNavBar extends StatefulWidget {
  static const String id = 'bottom_screen';

  const BottomNavBar({Key? key}) : super(key: key);
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  Widget child = Container();
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    switch(_currentIndex) {
      case 0:
        child = const MyProfile();
        break;

      case 1:
        child = const LeaveScreen();
        break;

      case 2:
        child = const MyProfile();
        break;

      case 3:
        child = const MoreScreen();
        break;
    }

    return BottomNavigationBar(
      currentIndex: _currentIndex,
      backgroundColor: Colors.white,
      selectedItemColor: Colors.green,
      unselectedItemColor: Colors.black87.withOpacity(.60),
      selectedFontSize: 14,
      unselectedFontSize: 14,
      onTap: (value) {
        setState(() => _currentIndex = value,
        );
      },
      items:  const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.archive_rounded),
          label: 'My Feed',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.card_travel),
          label: 'Leave',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add_task),
          label: 'Tasks',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.more_horiz),
          label: 'More',
        ),
      ],
    );
  }
}
