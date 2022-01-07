import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:location/location.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';



final CollectionReference collectionReference = FirebaseFirestore.instance.collection('location_test');
final firebase = FirebaseFirestore.instance;

String date = '';
String ? address;
String ? time;



class ShowAllGoogleMap extends StatefulWidget {
  const ShowAllGoogleMap();

  @override
  _ShowAllGoogleMapState createState() => _ShowAllGoogleMapState();
}

class _ShowAllGoogleMapState extends State<ShowAllGoogleMap> {
  @override
  void initState() {
    crearmarcadores();
    super.initState();
  }

  final FirebaseFirestore _database = FirebaseFirestore.instance;
  Completer<GoogleMapController> _controller = Completer();
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  crearmarcadores(){
    setState(() {
      // _identifier = loggedInUser.uid;
      DateTime now = DateTime.now();
      DateTime Time = now.subtract(const Duration(minutes: 5));
      date = DateFormat.yMd().format(now);
      time = DateFormat.Hms().format(Time);
      print('DatetimePrinted: $time');
    });
    _database.collection('location_test').orderBy("Time", descending: true).where('Date', isEqualTo: date)// .limit(3)
       .get().then((value) { // .where("Time", isGreaterThanOrEqualTo: time)
      if(value.docs.isNotEmpty ){
        for(int i= 0; i < value.docs.length; i++) {
          initMarker(value.docs[i].data(), value.docs[i].id);
        }
      }
    });
  }

  void initMarker(index, lugaresid) {
    print('name: ${index['name']}');
    print('time: ${index['Time']}');
    address = index['CurrentAddress'];
    var markerIdVal = lugaresid;
    final MarkerId markerId = MarkerId(markerIdVal);

    // creating a new MARKER
    final Marker marker = Marker(
      markerId: markerId,
      position: LatLng(index['latitude'], index['longitude']),
      infoWindow: InfoWindow(title: index['name'], snippet: address),
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
    return  SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.only(bottom: 20.0,top: 30.0, left: 15.0,right: 15.0),
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
        floatingActionButton: FloatingActionButton.extended(
          onPressed: _currentLocation,
          label: const Text('Tap to View People'),
          icon: const Icon(Icons.location_on),
        ),
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
