import 'dart:async';
import 'package:field_force/Widget/image_button.dart';
import 'package:field_force/component/nav_drawer.dart';
import 'package:field_force/constrains/constrain.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unique_identifier/unique_identifier.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:location/location.dart' as loc;


class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String _userName = '';
  String department = '';
  String regnum = '';
  String email = '';
  final firebase = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;


  getUserName() async {
    final CollectionReference userName = FirebaseFirestore.instance.collection('users');
    final String uid = _auth.currentUser!.uid;
    await userName.doc(uid).get().then((DocumentSnapshot ) =>
    _userName = DocumentSnapshot['name'],
    );

    print('user:$_userName');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('E-Book'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: <Color>[Colors.blue, Colors.deepPurple],
            ),
          ),
        ),
      ),
      drawer: NavDrawer(),

      body:  Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            // decoration: const BoxDecoration(
            //   borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50.0)),
            // ),
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
            color: Colors.black12,
            child: Expanded(
              child: Row(
                children:  <Widget>[
                  const Expanded(
                    child: CircleAvatar(
                      radius: 50,//radius is 50
                      //backgroundImage: AssetImage('images/scom2.png'),
                      backgroundImage: NetworkImage(
                          'https://www.donkey.bike/wp-content/uploads/2020/12/user-member-avatar-face-profile-icon-vector-22965342-300x300.jpg'),
                    ),
                  ),
                  const SizedBox(
                    width: 8.00,
                  ),
                  Expanded(
                    child: Text(
                      _userName,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20.00,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
