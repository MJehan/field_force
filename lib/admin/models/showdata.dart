import 'package:field_force/admin/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShowData extends StatelessWidget {
  ShowData({Key? key}) : super(key: key);
  final _user = UserData();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('SCL Field Force'),
      ),
      body: _user.save(),
    );
  }
}

