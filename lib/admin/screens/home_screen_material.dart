import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'list_view_all.dart';

// import 'package:location/location.dart' as loc;
// import 'package:field_force/constrains/bottom_navbar.dart';
// import 'package:field_force/login/login_screen.dart';
// import 'package:field_force/popUpScreen/pop_up_for_punch_in.dart';
// import 'package:field_force/admin/screens/home_screen.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:unique_identifier/unique_identifier.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:flutter/services.dart';
// import 'dart:async';


final CollectionReference collectionReference = FirebaseFirestore.instance.collection('Location_And_Data');
final firebase = FirebaseFirestore.instance;
final _auth = FirebaseAuth.instance;


//String ? _identifier;
String _userName = '';
int ? _userLenght ;
String date = '';



getUserName() async {
  final CollectionReference userName = FirebaseFirestore.instance.collection('users');
  final String uid = _auth.currentUser!.uid;
  await userName.doc(uid).get().then((DocumentSnapshot ) =>
  _userName = DocumentSnapshot['name']);
  print('user:$_userName');
}



class HomeScreenMaterial extends StatefulWidget {
  const HomeScreenMaterial({Key? key}) : super(key: key);

  @override
  _HomeScreenMaterialState createState() => _HomeScreenMaterialState();
}

class _HomeScreenMaterialState extends State<HomeScreenMaterial> {

  @override
  void initState() {
    super.initState();
    getUserName();
    setState(() {
      // _identifier = loggedInUser.uid;
      DateTime now = DateTime.now();
      date = DateFormat.yMd().format(now);
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
            color: Colors.black12,
            child: Expanded(
              child: Row(
                children:  <Widget>[
                   Expanded(
                    child: Text(
                      '$_userLenght \n Total Employee',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 15.00,
                      ),
                    ),

                  ),
                  const SizedBox(
                    width: 8.00,
                  ),
                  const Expanded(
                    child: Text(
                      'Absent Employee',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.00,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8.00,
                  ),
                  const Expanded(
                    child: Text(
                      'Present Employee',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.00,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
              height: 6.0
          ),
          Container(
            //padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0, bottom: 6.0),
            child: Expanded(
              child: Row(
                children:  const <Widget>[
                  StreamBuilderScreen(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class StreamBuilderScreen extends StatelessWidget {
  const StreamBuilderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context)  {
    return StreamBuilder<QuerySnapshot>(
      // stream: firebase.collection('Location_And_Data').orderBy('time').where('date',isEqualTo: date)
      //     .where('identifier', isEqualTo: _identifier ).snapshots(),
      //stream: firebase.collection('test').orderBy('time').where('date',isEqualTo: date).snapshots(),
      stream: firebase.collection('users').snapshots(),
      builder: (context, snapshot) {
        if(snapshot.hasData){
          final messages = snapshot.data!.docs;
          List<ShowAllDataListView> resultWidgets = [];
          for(var message in messages)
          {
            final name = message.get('name');
            final email = message.get('email');
            final resultWidget = ShowAllDataListView(name, email);
            resultWidgets.add(resultWidget);
          }
          _userLenght = resultWidgets.length;
          print('user_length: ${resultWidgets.length}');
          return Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 10.00, horizontal: 20.0),
              children: resultWidgets,
            ),
          );
        }
        return const Center(child: Text('No Data Found in firebase'));
      },
    );
  }
}
