import 'package:field_force/screens/leave_screen.dart';
import 'package:field_force/screens/more_screen.dart';
import 'package:field_force/screens/my_feed.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// class MyNavigationBar extends StatefulWidget {
//   static const String id = 'bottom_screen';
//
//   @override
//   _MyNavigationBarState createState() => _MyNavigationBarState();
// }
//
// class _MyNavigationBarState extends State<MyNavigationBar > {
//   int _selectedIndex = 0;
//   static const List<Widget> _widgetOptions = <Widget>[
//     MyProfile(),
//     LeaveScreen(),
//     MoreScreen(),
//   ];
//
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: _widgetOptions.elementAt(_selectedIndex),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//           items: const <BottomNavigationBarItem>[
//             BottomNavigationBarItem(
//                 icon: Icon(Icons.home),
//                 label: 'Home' ,
//             ),
//             BottomNavigationBarItem(
//                 icon: Icon(Icons.calendar_today_outlined),
//                 label: 'Search',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.more_horiz),
//               label: 'Profile',
//             ),
//           ],
//           type: BottomNavigationBarType.shifting,
//           currentIndex: _selectedIndex,
//           backgroundColor: Colors.white,
//           selectedItemColor: Colors.green,
//           selectedLabelStyle: const TextStyle(fontSize: 22, color: Colors.green),
//           unselectedItemColor: Colors.black87.withOpacity(.60),
//           unselectedLabelStyle: const TextStyle(fontSize: 18),
//           iconSize: 40,
//           onTap: _onItemTapped,
//           elevation: 5
//       ),
//     );
//   }
// }
//


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
