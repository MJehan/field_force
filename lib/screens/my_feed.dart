import 'dart:async';
import 'package:field_force/constrains/bottom_navbar.dart';
import 'package:field_force/login/login_screen.dart';
import 'package:field_force/popUpScreen/pop_up_for_punch_in.dart';
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

import 'google_map.dart';
import 'list_view_data_show.dart';


final CollectionReference collectionReference = FirebaseFirestore.instance.collection('Location_And_Data');
final firebase = FirebaseFirestore.instance;
final _auth = FirebaseAuth.instance;


String ? _identifier;
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
  final loc.Location location = loc.Location();
  StreamSubscription<loc.LocationData>? _locationSubscription;

  String textData = '';
  String buttonTitle = '';
  final pop_controller = TextEditingController();
  final noteTextController = TextEditingController();
  List timelinedatalist = [];

  @override
  void initState() {
    super.initState();
    initUniqueIdentifierState();
    getCurrentUser();
    getUserName();
    setState(() {
      _identifier = loggedInUser.uid;
      DateTime now = DateTime.now();
      date = DateFormat.yMd().format(now);
    });
  }

  getUserName() async {
    final CollectionReference userName = FirebaseFirestore.instance.collection('users');
    final String uid = _auth.currentUser!.uid;
    await userName.doc(uid).get().then((DocumentSnapshot ) =>
    _userName = DocumentSnapshot['name']);
    print('user:$_userName');
  }


  void getCurrentUser() async
  {
    try
    {
      final user = _auth.currentUser;
      if(user != null)
      {
        loggedInUser = user;
      }
    }
    catch(e)
    {
      print(e);
    }
  }
  create() {
    firebase.collection('Location_And_Data').add({
      "identifier": _identifier,
      "latitude": lat,
      "longitude": long,
      "location": _currentAddress,
      "text" : buttonTitle,
      "time" : inTime,
      'outTime' : outTime,
      "date" : date,
      "noteText" : noteTextController.text,
    });
  }
  void dataStream() async
  {
    await for (var snapshot in firebase.collection('Location_And_Data').snapshots()) {
      for (var message in snapshot.docs) {
        print(message.data());
      }
    }
  }

  @override
  void dispose()
  {
    pop_controller.dispose();
    noteTextController.dispose();
    super.dispose();
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

  Future<String?> openDialog()=> showDialog<String>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Check Point'),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:  <Widget>[
            TextField(
              controller: noteTextController,
              autofocus: true,
              decoration: const InputDecoration(
                hintText: 'Note',
              ),
              //controller: pop_controller,

            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          child: const Text('Submit'),
          onPressed: submit,
        ),
      ],
    ),
  );

  void submit()
  {
    setState(() {

    });
    Navigator.of(context).pop(pop_controller.text);
  }


  Widget child = Container();
  String inTime = '';
  String outTime = '';

  double lat = 0.0;
  double long = 0.0;

  final geolocator = Geolocator.getCurrentPosition(forceAndroidLocationManager: true);
  Position ? _currentPosition;
  String ? _currentAddress;

  //final bool _fromTop = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'My Feed',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        leading: Align(
          alignment: Alignment.centerRight,
          child: IconButton(
            onPressed: () async{
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.remove('email');
              FirebaseAuth.instance.signOut().then((_){
                Navigator.pushNamed(context, LoginScreen.id);
              });
            },
            icon: const Icon(Icons.logout, color:Colors.black),
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
            color: Colors.black12,
            child: Expanded(
              child: Row(
                children:  <Widget>[
                  const Expanded(
                    child: CircleAvatar(
                      radius: 50,//radius is 50
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

          const SizedBox(
            height: 10.0,
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
            child: Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: FlatButton(
                      onPressed: () async {
                        if(flag == true  )
                        {
                          await _getCurrentLocation();
                          await _listLocation();
                          setState(() {

                            buttonTitle = 'Check In';
                            DateTime now = DateTime.now();
                            inTime = DateFormat.Hms().format(now);
                            date = DateFormat.yMd().format(now);
                            //create();
                          }) ;
                          if(_currentAddress == null)
                          {
                            await _listLocation();
                            await _getCurrentLocation();
                            DateTime now = DateTime.now();
                            inTime = DateFormat.Hms().format(now);
                            date = DateFormat.yMd().format(now);
                          }
                          else
                          {
                            create();
                          }
                          flag = false;
                        }
                        else {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) =>const PunchInPopUp(title: 'You have already Punched In',)
                          );
                        }
                      },
                      color: Colors.black12,
                      child: Column(
                        children: const <Widget>[
                          Icon(Icons.fingerprint_outlined, size: 65.00, color: Colors.green),
                          Text('Check In',
                            style: TextStyle(
                              fontSize: 15.00,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const VerticalDivider(
                    color: Colors.grey,
                    width: 20,
                  ),
                  const SizedBox(
                      width: 6.0
                  ),
                  Expanded(
                    child: FlatButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => MapScreen(_identifier!, _userName)));
                        // dataStream();
                        // openDialog();
                        // final textData = noteTextController.text;
                        // if(textData == null || textData.isEmpty)
                        // {
                        //   return;
                        // }
                        // setState(() {
                        //   this.textData = textData;
                        // });
                        // noteTextController.text = '';
                      },
                      color: Colors.black12,
                      child: Column(
                        children: const <Widget>[
                          Icon(Icons.location_on_outlined, size: 65.00, color: Colors.blue),
                          Text(
                            'View Map',
                            style: TextStyle(
                              fontSize: 15.00,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                      width: 6.0
                  ),
                  const VerticalDivider(
                    color: Colors.grey,
                    width: 20,
                  ),
                  Expanded(
                    child: FlatButton(
                      onPressed: (){
                        if(flag == false)
                        {
                          _stopLocation();
                          _getCurrentLocation();
                          setState(() {
                            buttonTitle = 'Check Out';
                            DateTime now = DateTime.now();
                            outTime = DateFormat.Hms().format(now);
                            date = DateFormat.yMd().format(now);
                          });
                          if(_currentAddress == null)
                          {
                            _stopLocation();
                            _getCurrentLocation();
                            DateTime now = DateTime.now();
                            outTime = DateFormat.Hms().format(now);
                            date = DateFormat.yMd().format(now);
                          }
                          else
                          {
                            create();
                          }
                          flag = true;
                        }
                        else {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) => const PunchInPopUp(title: 'You have already Punch Out for Today',),
                          );
                        }
                      },
                      color: Colors.black12,
                      child: Column(
                        children: const <Widget>[
                          Icon(Icons.fingerprint_outlined, size: 65.00, color: Colors.red),
                          Text('Check Out',
                            style: TextStyle(
                              fontSize: 15.00,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Container(
            padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 25.0),
            decoration: const BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.all(
                Radius.circular(12.0),
              ),
            ),
            child: Expanded(
              child: Row(
                children:  <Widget>[
                  Expanded(
                    child: Row(
                      children:  <Widget>[
                        const Icon(Icons.arrow_circle_down, color: Colors.green),
                        Expanded(
                          child: Text(
                            '$inTime \nCheck In',
                            style: const TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const VerticalDivider(
                    color: Colors.black,
                    width: 1,
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  Expanded(
                    child: Row(
                      children: const <Widget>[
                        Icon(Icons.lock_clock, color: Colors.blue,),
                        Expanded(
                          child: Text(
                            'Working Time',
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const VerticalDivider(
                    color: Colors.black,
                    width: 1,
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                  Expanded(
                    child: Row(
                      children:  <Widget>[
                        const Icon(Icons.arrow_circle_up, color: Colors.red,),
                        Expanded(
                          child: Text(
                            '$outTime \nLast Check Out',
                            style: const TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(
            height: 10.0,
          ),


          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 40),
            decoration: const BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.all(
                Radius.circular(12.0),
              ),
            ),
            child: Expanded(
              child: Row(
                children:  const <Widget>[
                  Icon(Icons.timeline),
                  Expanded(
                      child: Text('   Timeline')
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
      bottomNavigationBar: const BottomNavBar(),
    );
  }
  _getCurrentLocation() async{
    await Geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position)  async {
      setState(() {
        _currentPosition = position;
      });

      await _getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
  }
  _getAddressFromLatLng() async {
    try {
      List<Placemark> p = await placemarkFromCoordinates(
          _currentPosition!.latitude, _currentPosition!.longitude);
      lat = _currentPosition!.latitude;
      long = _currentPosition!.longitude;
      Placemark place = p[0];
      setState(() {
        _currentAddress = '${place.name},${place.locality},${place.postalCode},${place.country}';
        //_currentAddress = "${place.street},${place.subThoroughfare},${place.thoroughfare}, ${place.subLocality}, ${place.locality},${place.country},";
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> _listLocation() async {
    location.changeSettings(interval: 60000, distanceFilter: 5.0); // Define Time for fetch location
    _locationSubscription = location.onLocationChanged.handleError((onError) {
      print('error_in_call_live');
      print(onError);
      _locationSubscription?.cancel();
      setState(() {
        _locationSubscription = null;
      });
    }).listen((loc.LocationData currentlocation) async {
      //print('print_properly');
      await FirebaseFirestore.instance.collection('location').doc().set({
        'latitude': currentlocation.latitude,
        'longitude': currentlocation.longitude,
        "identifier": _identifier,
      },
        // SetOptions(merge: true),
      );
    });
  }

  _stopLocation() {
    _locationSubscription?.cancel();
    setState(() {
      _locationSubscription = null;
    });
  }

}

class StreamBuilderScreen extends StatelessWidget {
  const StreamBuilderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context)  {
    return StreamBuilder<QuerySnapshot>(
      stream: firebase.collection('Location_And_Data').orderBy('time').where('date',isEqualTo: date)
          .where('identifier', isEqualTo: _identifier ).snapshots(),
      //stream: firebase.collection('test').orderBy('time').where('date',isEqualTo: date).snapshots(),
      // stream: firebase.collection('test').orderBy('time').snapshots(),
      builder: (context, snapshot) {
        if(snapshot.hasData){
          final messages = snapshot.data!.docs;
          List<ListViewScreen> resultWidgets = [];
          for(var message in messages)
          {
            final location = message.get('location');
            final text = message.get('text');
            final time = message.get('time');
            final resultWidget = ListViewScreen(location, text, time);
            resultWidgets.add(resultWidget);
          }

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



