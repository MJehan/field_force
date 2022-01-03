import 'package:field_force/admin/models/user.dart';
import 'package:field_force/component/nav_drawer.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:location/location.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';


final CollectionReference collectionReference = FirebaseFirestore.instance.collection('Location_And_Data');
final firebase = FirebaseFirestore.instance;
final _auth = FirebaseAuth.instance;

final _user = UserData();
String _userName = '';
String date = '';


getUserName() async {
  final CollectionReference userName = FirebaseFirestore.instance.collection('users');
  final String uid = _auth.currentUser!.uid;
  await userName.doc(uid).get().then((DocumentSnapshot ) =>
  _userName = DocumentSnapshot['name']);
  print('user:$_userName');
}

class DateSearch extends StatefulWidget {
  const DateSearch({Key? key}) : super(key: key);
  @override
  _DateSearchState createState() => _DateSearchState();
}

class _DateSearchState extends State<DateSearch> {
  final _formKey = GlobalKey<FormState>();

  final FirebaseFirestore _database = FirebaseFirestore.instance;
  Completer<GoogleMapController> _controller = Completer();
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  @override
  void initState() {
    crearmarcadores();
    super.initState();
    getUserName();
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


  crearmarcadores(){
    print('insidefromdate: $date');
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
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: NavDrawer(),
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          title: const Center(
            child: Text('Search Employee'),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0, bottom: 35.0),
              child: Expanded(
                child: Form(
                  key: _formKey,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          child: FormBuilderDateTimePicker(
                            name: "From Date",
                            inputType: InputType.date,
                            format: DateFormat("dd-MM-yyyy"),
                            decoration: const InputDecoration(
                              labelText: "From Date",
                              labelStyle: TextStyle(
                                color: Color(0xFF6200EE),
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Color(0xFF6200EE)),
                              ),
                            ),
                             onSaved: (val) =>
                                 setState(() => _user.formDate  = val!.toString()),
                          ),
                      ),
                      const SizedBox(width: 10.0),
                      Expanded(
                        child: FormBuilderDateTimePicker(
                          name: "To Date",
                          inputType: InputType.date,
                          format: DateFormat("dd-MM-yyyy"),
                          decoration: const InputDecoration(
                            labelText: "To Date",
                            labelStyle: TextStyle(
                              color: Color(0xFF6200EE),
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF6200EE)),
                            ),
                          ),
                           onSaved: (val) =>
                               setState(() => _user.toDate  = val!.toString()),
                        ),
                      ),
                      const SizedBox(width: 15.0),
                      Expanded(
                          child: RaisedButton(
                            onPressed: () {
                               final form = _formKey.currentState;
                               if (form!.validate()) {
                                 form.save();
                                _user.save();
                                setState(() {
                                  date = _user.formDate;
                                  print('setdate: $date');
                                });
                              }
                                _currentLocation();
                            },
                            child: const Text('Submit',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20.00,
                              ),
                            ),
                            color: const Color(0xFF6200EE),
                          ),
                      ),
                    ],
                  ),
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
                        onMapCreated: (GoogleMapController controller){
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
      ),
    );
  }
}
