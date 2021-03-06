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

class TimePicker extends StatefulWidget {
  const TimePicker({Key? key}) : super(key: key);

  @override
  _TimePickerState createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  final FirebaseFirestore _database = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  Completer<GoogleMapController> _controller = Completer();
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  String _userName = '';
  String date = '';
  var shopId;

  getUserName() async {
    final CollectionReference userName = FirebaseFirestore.instance.collection('users');
    final String uid = _auth.currentUser!.uid;
    await userName.doc(uid).get().then((DocumentSnapshot ) =>
    _userName = DocumentSnapshot['name']);
    print('user:$_userName');
  }


  crearmarcadores(){
    _database.collection('location_test')
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
    getUserName();
    crearmarcadores();
    super.initState();
    setState(() {
      // _identifier = loggedInUser.uid;
      DateTime now = DateTime.now();
      date = DateFormat.yMd().format(now);
    });
  }

  final _formKey = GlobalKey<FormState>();
  final _user = UserData();



  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(), builder: (context, snapshot) {
      if (!snapshot.hasData) {
        return const Center(
          child: CupertinoActivityIndicator(),
        );
      }

      return Container(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: Row(
          children: <Widget>[
            Expanded(
                flex: 2,
                child: Container(
                  padding: const EdgeInsets.fromLTRB(12.0, 10.0, 10.0, 10.0),
                  child: const Text(
                    "Shop",
                  ),
                )),
             Expanded(
              flex: 4,
              child: DropdownButton(
                value: shopId,
                isDense: true,
                onChanged: (valueSelectedByUser) {
                  setState(() {
                    shopId = valueSelectedByUser;
                  });
                },
                hint: const Text('Choose shop'),
                items: snapshot.data!.docs
                    .map((DocumentSnapshot document) {
                  return DropdownMenuItem<String>(
                    value: document.get('email') +
                        ' ' +
                        document.get('name'),
                    child: Text(document.get('_identifier') +
                        ' ' +
                        document.get('password')
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      );
    });


    // return SafeArea(
    //   child: Scaffold(
    //     drawer: NavDrawer(),
    //     appBar: AppBar(
    //       backgroundColor: Colors.deepPurple,
    //       title: const Center(
    //         child: Text('Search Employee'),
    //       ),
    //     ),
    //     body: Column(
    //       crossAxisAlignment: CrossAxisAlignment.stretch,
    //       children: <Widget>[
    //         Container(
    //           padding: const EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0, bottom: 35.0),
    //           child: Expanded(
    //             child: Form(
    //               key: _formKey,
    //               child: Column(
    //                 crossAxisAlignment: CrossAxisAlignment.stretch,
    //                 mainAxisAlignment: MainAxisAlignment.spaceAround,
    //                 children: [
    //                   FormBuilderDateTimePicker(
    //                     name: "Form",
    //                     inputType: InputType.date,
    //                     format: DateFormat.Hms(),
    //                     decoration: const InputDecoration(
    //                       labelText: "Form",
    //                       labelStyle: TextStyle(
    //                         color: Color(0xFF6200EE),
    //                         fontSize: 18.0,
    //                         fontWeight: FontWeight.bold,
    //                       ),
    //                       border: OutlineInputBorder(
    //                         borderSide: BorderSide(color: Color(0xFF6200EE)),
    //                       ),
    //                     ),
    //                     initialValue: DateTime.now(),
    //                     onSaved: (val) =>
    //                         setState(() => _user.formDate = val!.toString()),
    //                   ),
    //                   const SizedBox(height: 10.0),
    //                   FormBuilderDateTimePicker(
    //                     name: "To",
    //                     inputType: InputType.date,
    //                     format: DateFormat.Hms(),
    //                     decoration: const InputDecoration(
    //                       labelText: "To",
    //                       labelStyle: TextStyle(
    //                         color: Color(0xFF6200EE),
    //                         fontSize: 18.0,
    //                         fontWeight: FontWeight.bold,
    //                       ),
    //                       border: OutlineInputBorder(
    //                         borderSide: BorderSide(color: Color(0xFF6200EE)),
    //                       ),
    //                     ),
    //                     initialValue: DateTime.now(),
    //                     onSaved: (val) =>
    //                         setState(() => _user.toDate = val!.toString()),
    //                   ),
    //                   Container(
    //                     padding: const EdgeInsets.symmetric(
    //                         vertical: 16.0, horizontal: 16.0),
    //                     child: RaisedButton(
    //                       onPressed: () {
    //                         final form = _formKey.currentState;
    //                         if (form!.validate()) {
    //                           form.save();
    //                           _user.save();
    //                           print('Form: ${_user.formDate}');
    //                           print('To: ${_user.toDate}');
    //                         }
    //                       },
    //                       child: const Text('Submit',
    //                         style: TextStyle(
    //                           color: Colors.white,
    //                           fontWeight: FontWeight.bold,
    //                           fontSize: 18.00,
    //                         ),
    //                       ),
    //                       shape: const RoundedRectangleBorder(
    //                         borderRadius: BorderRadius.all(Radius.circular(16.0)),
    //                       ),
    //                       color: const Color(0xFF6200EE),
    //                       padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 10.0),
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //           ),
    //         ),
    //         // const SizedBox(
    //         //   height: 5.0,
    //         // ),
    //         Container(
    //           child: Expanded(
    //             child: Row(
    //               children:  <Widget>[
    //                 Expanded(
    //                   child: GoogleMap(
    //                     mapType: MapType.normal,
    //                     initialCameraPosition: _kinitialPosition,
    //                     onMapCreated: (GoogleMapController controller) {
    //                       _controller.complete(controller);
    //                     },
    //                     myLocationEnabled: true,
    //                     markers: Set<Marker>.of(markers.values),
    //                   ),
    //
    //                 ),
    //               ],
    //             ),
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }

  _showDialog(BuildContext context) {
    Scaffold.of(context).showSnackBar(
      const SnackBar(
        content: Text('Submitting form'),
      ),
    );
  }
}
