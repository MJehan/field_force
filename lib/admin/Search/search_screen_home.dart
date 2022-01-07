import 'package:field_force/admin/popUpScreen/date_picker.dart';
import 'package:field_force/admin/popUpScreen/time_picker.dart';
import 'package:field_force/component/nav_drawer.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:location/location.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

final firebase = FirebaseFirestore.instance;
final _auth = FirebaseAuth.instance;
final CollectionReference collectionReference = FirebaseFirestore.instance.collection('location_test');

String _userName = '';
String date = '';

getUserName() async {
  final CollectionReference userName = FirebaseFirestore.instance.collection('users');
  final String uid = _auth.currentUser!.uid;
  await userName.doc(uid).get().then((DocumentSnapshot ) =>
  _userName = DocumentSnapshot['name']);
  print('user:$_userName');
}



class SearchScreenHome extends StatefulWidget {
  const SearchScreenHome({Key? key}) : super(key: key);

  @override
  _SearchScreenHomeState createState() => _SearchScreenHomeState();
}

class _SearchScreenHomeState extends State<SearchScreenHome> {
  final FirebaseFirestore _database = FirebaseFirestore.instance;
  Completer<GoogleMapController> _controller = Completer();
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  crearmarcadores(){
    _database.collection('location_test').where('Date', isEqualTo: date)
        .get().then((value) {
      if(value.docs.isNotEmpty){
        for(int i= 0; i < value.docs.length; i++) {
          initMarker(value.docs[i].data(), value.docs[i].id);
        }
      }
    });
  }

  void initMarker(index, lugaresid) {
    var markerIdVal = lugaresid;
    final MarkerId markerId = MarkerId(markerIdVal);

    // creating a new MARKER
    final Marker marker = Marker(
      markerId: markerId,
      position: LatLng(index['latitude'], index['longitude']),
      infoWindow: InfoWindow(title: _userName),
    );

    setState(() {
      // adding a new marker to map
      markers[markerId] = marker;
    });
  }
  LocationData? currentLocation;

  static const CameraPosition _kinitialPosition = CameraPosition(
    target: LatLng(23.7511271, 91.3931642),
    //target: LatLng(currentLocation!.latitude!.toDouble(), currentLocation!.longitude!.toDouble()),
    zoom: 14.4746,
  );

  @override
  void initState() {
    crearmarcadores();
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
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: const Text('Search Employee'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: <Color>[
                Colors.blue,
                Colors.deepPurple
              ],
            ),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0, bottom: 35.0),
            child: Expanded(
              child: Row(
                children:  <Widget>[
                   Expanded(
                    child: FloatingActionButton.extended(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => DatePickerPopUpScreen()));
                      },
                      icon: const Icon(Icons.search),
                      label: const Text("Date"),
                      backgroundColor: Colors.lightBlueAccent,
                    ),
                   ),
                   const SizedBox(
                    width: 8.00,
                  ),
                  Expanded(
                    child: FloatingActionButton.extended(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>   const TimePicker()));
                      },
                      icon: const Icon(Icons.search_rounded),
                      label: const Text("Time"),
                      backgroundColor: Colors.teal,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 15.0,
          ),
          Container(
            child: Expanded(
              child: Row(
                children:  <Widget>[
                  Expanded(
                    child: GoogleMap(
                      mapType: MapType.normal,
                      initialCameraPosition: _kinitialPosition,
                      onMapCreated: (GoogleMapController controller) {
                        _controller.complete(controller);
                      },
                      myLocationEnabled: true,
                      markers: Set<Marker>.of(markers.values),
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

  void _currentLocation() async {
    final GoogleMapController controller = await _controller.future;
    LocationData? currentLocation;
    var location =  Location();
    try {
      currentLocation = await location.getLocation();
    } on Exception {
      currentLocation = null;
    }

    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        bearing: 0,
        target: LatLng(currentLocation!.latitude!.toDouble(), currentLocation.longitude!.toDouble()),
        zoom: 17.0,
      ),
    ),
    );
  }
}
