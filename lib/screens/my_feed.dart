import 'dart:async';
import 'package:field_force/Widget/image_button.dart';
import 'package:field_force/Widget/image_button_2.dart';
import 'package:field_force/Widget/image_button_3.dart';
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

final CollectionReference collectionReference =
    FirebaseFirestore.instance.collection('Location_And_Data');
final firebase = FirebaseFirestore.instance;
final _auth = FirebaseAuth.instance;

String? _identifier;
String _userName = '';
late User loggedInUser;
String date = '';
bool flag = true;

class MyProfile extends StatefulWidget {
  static const String id = 'myProfile_screen';

  const MyProfile({Key? key}) : super(key: key);
  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  @override
  void initState() {
    super.initState();
    initUniqueIdentifierState();
    getCurrentUser();
    getUserName();
    setState(() {
      _identifier = loggedInUser.uid;
    });
  }

  getUserName() async {
    final CollectionReference userName =
        FirebaseFirestore.instance.collection('users');
    final String uid = _auth.currentUser!.uid;
    await userName
        .doc(uid)
        .get()
        .then((DocumentSnapshot) => _userName = DocumentSnapshot['name']);
    print('user:$_userName');
  }

  void getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> initUniqueIdentifierState() async {
    String identifier;
    try {
      identifier = (await UniqueIdentifier.serial)!;
    } on PlatformException {
      identifier = 'Failed to get Unique Identifier';
    }
    if (!mounted) return;

    setState(() {
      _identifier = loggedInUser.uid;
    });
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[


            Container(
              padding:
                  const EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 40),
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColor.kPrimaryColor.withOpacity(0.05),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
              ),
              child: SingleChildScrollView(
                child: Wrap(
                  runSpacing: 20,
                  spacing: 20,
                  children: <Widget>[
                    //ImageButton(title: "Boo1", imgPath: "images/back_login.jpg",)
                    Row(
                      children: <Widget>[
                        ButtonImage(title: "Algorithm", path: "images/algo.jpg",),
                        SizedBox(width: 20,),
                        ImageButton2(title: "Data Structure", path: "images/cpp.jpg",),
                        SizedBox(width: 20,),
                        ImageButton3(title: "Micro.", path: "images/mc.png",),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        ImageButton3(title: "Micro.", path: "images/mc.png",),
                        SizedBox(width: 20,),
                        ButtonImage(title: "Algorithm", path: "images/algo.jpg",),
                        SizedBox(width: 20,),
                        ImageButton2(title: "Data Structure", path: "images/cpp.jpg",),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        ButtonImage(title: "Algorithm", path: "images/algo.jpg",),
                        SizedBox(width: 20,),
                        ImageButton2(title: "Data Structure", path: "images/cpp.jpg",),
                        SizedBox(width: 20,),
                        ImageButton3(title: "Micro.", path: "images/mc.png",),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        ImageButton3(title: "Micro.", path: "images/mc.png",),
                        SizedBox(width: 20,),
                        ButtonImage(title: "Algorithm", path: "images/algo.jpg",),
                        SizedBox(width: 20,),
                        ImageButton2(title: "Data Structure", path: "images/cpp.jpg",),
                      ],
                    ),
                  ],
                ),
              ),
            ),


          ],
        ),
      ),
    );
  }
}

