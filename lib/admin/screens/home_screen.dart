import 'package:field_force/component/nav_drawer.dart';
import 'package:flutter/material.dart';

import 'home_screen_material.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({Key? key}) : super(key: key);

  @override
  _AdminHomeScreenState createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: const Center(child: Text('SCL Field Force')),
        backgroundColor: const Color(0xFF6200EE),
      ),
      body: const HomeScreenMaterial(),
    );
  }
}
