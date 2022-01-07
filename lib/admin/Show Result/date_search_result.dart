import 'package:field_force/admin/models/showdata.dart';
import 'package:field_force/admin/models/user.dart';
import 'package:field_force/admin/popUpScreen/date_picker.dart';
import 'package:field_force/component/nav_drawer.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:location/location.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';



class DateSearchResultScreen extends StatefulWidget {
  final String _formDate;
  final String _toDate;
   const DateSearchResultScreen(this._formDate,this._toDate);

  @override
  _DateSearchResultScreenState createState() => _DateSearchResultScreenState();
}

class _DateSearchResultScreenState extends State<DateSearchResultScreen> {

  final FirebaseFirestore _database = FirebaseFirestore.instance;
  Completer<GoogleMapController> _controller = Completer();
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  crearmarcadores(){
    //print('FresultScreen: ${widget._formDate}');
    //print('TresultScreen: ${widget._toDate}');
    _database.collection('location_test').where("Date", isGreaterThanOrEqualTo:  widget._formDate).
    where("Date", isLessThanOrEqualTo: widget._toDate)
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
      infoWindow: InfoWindow(title: index['name'],snippet: index['CurrentAddress']),
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
            //padding: const EdgeInsets.only( left: 5.0,right: 5.0),
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


