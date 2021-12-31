import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:location/location.dart';

// String ? _identifier;
//  User ? loggedInUser;
// final _auth = FirebaseAuth.instance;

class MapScreen extends StatefulWidget {
  final String user_id;
  final String user_name;
  final String _currentAddress;
  const MapScreen(this.user_id, this.user_name, this._currentAddress);
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen>  {

  final FirebaseFirestore _database = FirebaseFirestore.instance;
  Completer<GoogleMapController> _controller = Completer();
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  crearmarcadores(){
    _database.collection('location_test').where('identifier', isEqualTo: widget.user_id)
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
      infoWindow: InfoWindow(title: widget.user_name, snippet: widget._currentAddress),
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
    return  Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _kinitialPosition,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        myLocationEnabled: true,
        markers: Set<Marker>.of(markers.values),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _currentLocation,
        label: const Text('Tap to View People'),
        icon: const Icon(Icons.location_on),
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



// class MapScreen extends StatefulWidget {
//   final String user_id;
//   const MapScreen(this.user_id);
//   @override
//   _MapScreenState createState() => _MapScreenState();
// }
//
// class _MapScreenState extends State<MapScreen>  {
//
//   final loc.Location Location = loc.Location();
//   late GoogleMapController _controller;
//   bool _added = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: StreamBuilder(
//           stream: FirebaseFirestore.instance.collection('location').where('identifier', isEqualTo: widget.user_id ).snapshots(),
//           builder: (context, AsyncSnapshot<QuerySnapshot> snapshot)
//           {
//             if(_added)
//             {
//               map(snapshot);
//             }
//             if(!snapshot.hasData)
//             {
//               return const Center(child: CircularProgressIndicator());
//             }
//             return GoogleMap(
//               mapType: MapType.normal,
//               markers: {
//                 Marker(
//                   position: LatLng(
//                     snapshot.data!.docs.singleWhere(
//                             (element) => element.id == widget.user_id)['latitude'],
//                     snapshot.data!.docs.singleWhere(
//                             (element) => element.id == widget.user_id)['longitude'],
//                   ),
//                   infoWindow: const InfoWindow(title: 'Hello I am Here..!!!'),
//                   markerId: const MarkerId('id'),
//                   icon: BitmapDescriptor.defaultMarkerWithHue(
//                     BitmapDescriptor.hueMagenta,
//                   ),
//                 ),
//               },
//               initialCameraPosition: CameraPosition(
//                   target: LatLng(
//                       snapshot.data!.docs.singleWhere(
//                               (element) => element.id == widget.user_id)['latitude'],
//                       snapshot.data!.docs.singleWhere(
//                               (element) => element.id == widget.user_id)['longitude']
//                   ),zoom: 14.47
//               ),
//               onMapCreated: (GoogleMapController controller) async{
//                 setState(() {
//                   _controller = controller;
//                   _added = true;
//                 });
//               },
//             );
//           }
//       ),
//     );
//   }
//
//   Future<void> map(AsyncSnapshot<QuerySnapshot> snapshot) async{
//     await _controller.animateCamera(
//         CameraUpdate.newCameraPosition(CameraPosition(
//             target:LatLng(
//                 snapshot.data!.docs.singleWhere(
//                         (element) => element.id == widget.user_id)['latitude'],
//                 snapshot.data!.docs.singleWhere(
//                         (element) => element.id == widget.user_id)['longitude']
//             ),zoom: 14.47))
//     );
//   }
// }