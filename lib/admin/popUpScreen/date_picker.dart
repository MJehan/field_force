import 'package:field_force/admin/Show%20Result/date_search_result.dart';
import 'package:field_force/admin/models/showdata.dart';
import 'package:field_force/admin/models/user.dart';
import 'package:field_force/admin/popUpScreen/date_picker.dart';
import 'package:field_force/component/nav_drawer.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:location/location.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';



class DatePickerPopUpScreen extends StatelessWidget {

   DatePickerPopUpScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final _user = UserData();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Center(
          child: Text(
            'Select Date',
            style: TextStyle(color: Colors.deepPurple),
          )),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0, bottom: 35.0),
            child: Expanded(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    FormBuilderDateTimePicker(
                      name: "Form Date",
                      inputType: InputType.date,
                      format: DateFormat("dd/MM/yyyy"),
                      decoration: const InputDecoration(
                        labelText: "Form Date",
                        labelStyle: TextStyle(
                          color: Color(0xFF6200EE),
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF6200EE)),
                        ),
                      ),
                      onSaved: (val)  {
                            _user.formDate = val!.toString();
                            //DateTime now = _user.formDate as DateTime;
                            _user.formDate = DateFormat.yMd().format(val);
                          },
                    ),
                    const SizedBox(height: 10.0),
                    FormBuilderDateTimePicker(
                      name: "To Date",
                      inputType: InputType.date,
                      format: DateFormat.yMd(),
                      decoration: const InputDecoration(
                        labelText: "To Date",
                        labelStyle: TextStyle(
                          color: Color(0xFF6200EE),
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF6200EE)),
                        ),
                      ),
                      onSaved: (val)  {
                            _user.toDate = val!.toString();
                            //DateTime now = _user.toDate as DateTime;
                            _user.toDate = DateFormat.yMd().format(val);
                          },
                    ),
                    // const SizedBox(height: 10.0),
                    // FormBuilderDropdown(
                    //   name: 'User Name',
                    //   decoration: const InputDecoration(
                    //     border: OutlineInputBorder(
                    //       borderSide: BorderSide(color: Color(0xFF6200EE)),
                    //     ),
                    //     labelText: 'User Name',
                    //     labelStyle: TextStyle(
                    //       color: Color(0xFF6200EE),
                    //       fontSize: 18.0,
                    //       fontWeight: FontWeight.bold,
                    //     ),
                    //   ),
                    //   // initialValue: 'Male',
                    //   //allowClear: true,
                    //   hint: const Center(child: Text('--Select User--')),
                    //   validator: FormBuilderValidators.compose(
                    //       [FormBuilderValidators.required(context)]),
                    //   items: <String>[name]
                    //       .map((category) => DropdownMenuItem(
                    //     value: category,
                    //     child: Text(category),
                    //   ))
                    //       .toList(),
                    //   onSaved: (val) {
                    //     () => _user.name = val!.toString();
                    //   },
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      actions: <Widget>[
        RaisedButton(
          onPressed: () {
            final form = _formKey.currentState;
            if (form!.validate()) {
              form.save();
              _user.save();
              //_user.formDate = _user.formDate.substring(0, 10);
              _user.formDate = _user.formDate;
              _user.toDate = _user.toDate;
            }
            // print('From_date: ${_user.formDate}');
            // print('To_date: ${_user.toDate}');
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => DateSearchResultScreen(_user.formDate, _user.toDate)));
            DateSearchResultScreen(_user.formDate, _user.toDate);
          },
          child: const Text('Submit',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18.00,
            ),
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
          ),
          color: const Color(0xFF6200EE),
          padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 10.0),
        ),
      ],
    );
  }
}

// class DatePickerPopUpScreen extends StatefulWidget {
//   const DatePickerPopUpScreen({Key? key}) : super(key: key);
//
//   @override
//   _DatePickerPopUpScreenState createState() => _DatePickerPopUpScreenState();
// }
//
//
//
// class _DatePickerPopUpScreenState extends State<DatePickerPopUpScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _user = UserData();
//
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: const Center(
//           child: Text(
//             'Alart',
//             style: TextStyle(color: Colors.red),
//           )),
//       content: Column(
//         mainAxisSize: MainAxisSize.min,
//         //crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           Container(
//             padding: const EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0, bottom: 35.0),
//             child: Expanded(
//               child: Form(
//                 key: _formKey,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     FormBuilderDateTimePicker(
//                       name: "Form Date",
//                       inputType: InputType.date,
//                       format: DateFormat("dd/MM/yyyy"),
//                       decoration: const InputDecoration(
//                         labelText: "Form Date",
//                         labelStyle: TextStyle(
//                           color: Color(0xFF6200EE),
//                           fontSize: 18.0,
//                           fontWeight: FontWeight.bold,
//                         ),
//                         border: OutlineInputBorder(
//                           borderSide: BorderSide(color: Color(0xFF6200EE)),
//                         ),
//                       ),
//                       onSaved: (val) =>
//                           setState(() {
//                             _user.formDate = val!.toString();
//                             //DateTime now = _user.formDate as DateTime;
//                             _user.formDate = DateFormat.yMd().format(val);
//                           }),
//                     ),
//                     const SizedBox(height: 10.0),
//                     FormBuilderDateTimePicker(
//                       name: "To Date",
//                       inputType: InputType.date,
//                       format: DateFormat.yMd(),
//                       decoration: const InputDecoration(
//                         labelText: "To Date",
//                         labelStyle: TextStyle(
//                           color: Color(0xFF6200EE),
//                           fontSize: 18.0,
//                           fontWeight: FontWeight.bold,
//                         ),
//                         border: OutlineInputBorder(
//                           borderSide: BorderSide(color: Color(0xFF6200EE)),
//                         ),
//                       ),
//                       onSaved: (val) =>
//                           setState(() {
//                             _user.toDate = val!.toString();
//                             //DateTime now = _user.toDate as DateTime;
//                             _user.toDate = DateFormat.yMd().format(val);
//                           }),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//       actions: <Widget>[
//         RaisedButton(
//           onPressed: () {
//             final form = _formKey.currentState;
//             if (form!.validate()) {
//               form.save();
//               _user.save();
//               //_user.formDate = _user.formDate.substring(0, 10);
//               _user.formDate = _user.formDate;
//               _user.toDate = _user.toDate;
//             }
//             // print('From_date: ${_user.formDate}');
//             // print('To_date: ${_user.toDate}');
//             Navigator.of(context).push(MaterialPageRoute(
//                 builder: (context) => DateSearchResultScreen(_user.formDate, _user.toDate)));
//             DateSearchResultScreen(_user.formDate, _user.toDate);
//           },
//           child: const Text('Submit',
//             style: TextStyle(
//               color: Colors.white,
//               fontWeight: FontWeight.bold,
//               fontSize: 18.00,
//             ),
//           ),
//           shape: const RoundedRectangleBorder(
//             borderRadius: BorderRadius.all(Radius.circular(16.0)),
//           ),
//           color: const Color(0xFF6200EE),
//           padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 10.0),
//         ),
//       ],
//     );
//   }
// }



//
// class DatePickerPopUpScreen extends StatefulWidget {
//   const DatePickerPopUpScreen({Key? key}) : super(key: key);
//
//   @override
//   _DatePickerPopUpScreenState createState() => _DatePickerPopUpScreenState();
// }
//
// class _DatePickerPopUpScreenState extends State<DatePickerPopUpScreen> {
//
//   final FirebaseFirestore _database = FirebaseFirestore.instance;
//   final _auth = FirebaseAuth.instance;
//   Completer<GoogleMapController> _controller = Completer();
//   Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
//   String _userName = '';
//   String date = '';
//
//   getUserName() async {
//     final CollectionReference userName = FirebaseFirestore.instance.collection('users');
//     final String uid = _auth.currentUser!.uid;
//     await userName.doc(uid).get().then((DocumentSnapshot ) =>
//     _userName = DocumentSnapshot['name']);
//     print('user:$_userName');
//   }
//
//
//   crearmarcadores(){
//     _database.collection('location_test')
//         .get().then((value) {
//       if(value.docs.isNotEmpty){
//         for(int i= 0; i < value.docs.length; i++) {
//           initMarker(value.docs[i].data(), value.docs[i].id);
//         }
//       }
//     });
//     print('crearmarcadores : ${_user.formDate}');
//   }
//
//   void initMarker(index, lugaresid) {
//     var markerIdVal = lugaresid;
//     final MarkerId markerId = MarkerId(markerIdVal);
//
//     // creating a new MARKER
//     final Marker marker = Marker(
//       markerId: markerId,
//       position: LatLng(index['latitude'], index['longitude']),
//       infoWindow: InfoWindow(title: _userName),
//     );
//
//     setState(() {
//       // adding a new marker to map
//       markers[markerId] = marker;
//     });
//   }
//   LocationData? currentLocation;
//
//   static const CameraPosition _kinitialPosition = CameraPosition(
//     target: LatLng(23.7511271, 91.3931642),
//     //target: LatLng(currentLocation!.latitude!.toDouble(), currentLocation!.longitude!.toDouble()),
//     zoom: 14.4746,
//   );
//
//   @override
//   void initState() {
//     getUserName();
//     crearmarcadores();
//     super.initState();
//     setState(() {
//       // _identifier = loggedInUser.uid;
//       DateTime now = DateTime.now();
//       date = DateFormat.yMd().format(now);
//     });
//   }
//
//   final _formKey = GlobalKey<FormState>();
//   final _user = UserData();
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         drawer: NavDrawer(),
//         appBar: AppBar(
//           title: const Center(child: Text('Search Employee')),
//           flexibleSpace: Container(
//             decoration: const BoxDecoration(
//               gradient: LinearGradient(
//                 begin: Alignment.centerLeft,
//                 end: Alignment.centerRight,
//                 colors: <Color>[
//                   Colors.blue,
//                   Colors.deepPurple
//                 ],
//               ),
//             ),
//           ),
//         ),
//         body: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: <Widget>[
//             Container(
//               padding: const EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0, bottom: 35.0),
//               child: Expanded(
//                 child: Form(
//                   key: _formKey,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       FormBuilderDateTimePicker(
//                         name: "Form Date",
//                         inputType: InputType.date,
//                         format: DateFormat("dd/MM/yyyy"),
//                         decoration: const InputDecoration(
//                           labelText: "Form Date",
//                           labelStyle: TextStyle(
//                             color: Color(0xFF6200EE),
//                             fontSize: 18.0,
//                             fontWeight: FontWeight.bold,
//                           ),
//                           border: OutlineInputBorder(
//                             borderSide: BorderSide(color: Color(0xFF6200EE)),
//                           ),
//                         ),
//                         onSaved: (val) =>
//                             setState(() {
//                             _user.formDate = val!.toString();
//                             //DateTime now = _user.formDate as DateTime;
//                             _user.formDate = DateFormat.yMd().format(val);
//                             }),
//                       ),
//                       const SizedBox(height: 10.0),
//                       FormBuilderDateTimePicker(
//                         name: "To Date",
//                         inputType: InputType.date,
//                         format: DateFormat.yMd(),
//                         decoration: const InputDecoration(
//                           labelText: "To Date",
//                           labelStyle: TextStyle(
//                             color: Color(0xFF6200EE),
//                             fontSize: 18.0,
//                             fontWeight: FontWeight.bold,
//                           ),
//                           border: OutlineInputBorder(
//                             borderSide: BorderSide(color: Color(0xFF6200EE)),
//                           ),
//                         ),
//                         onSaved: (val) =>
//                             setState(() {
//                               _user.toDate = val!.toString();
//                               //DateTime now = _user.toDate as DateTime;
//                               _user.toDate = DateFormat.yMd().format(val);
//                             }),
//                       ),
//                       Container(
//                         padding: const EdgeInsets.symmetric(
//                             vertical: 16.0, horizontal: 16.0),
//                         child: RaisedButton(
//                           onPressed: () {
//                             final form = _formKey.currentState;
//                             if (form!.validate()) {
//                               form.save();
//                               _user.save();
//                               //_user.formDate = _user.formDate.substring(0, 10);
//                               _user.formDate = _user.formDate;
//                               _user.toDate = _user.toDate;
//                             }
//                             // print('From_date: ${_user.formDate}');
//                             // print('To_date: ${_user.toDate}');
//                             Navigator.of(context).push(MaterialPageRoute(
//                                 builder: (context) => DateSearchResultScreen(_user.formDate, _user.toDate)));
//                             DateSearchResultScreen(_user.formDate, _user.toDate);
//                           },
//                           child: const Text('Submit',
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 18.00,
//                             ),
//                           ),
//                           shape: const RoundedRectangleBorder(
//                             borderRadius: BorderRadius.all(Radius.circular(16.0)),
//                           ),
//                           color: const Color(0xFF6200EE),
//                           padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 10.0),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             // const SizedBox(
//             //   height: 5.0,
//             // ),
//             Container(
//               child: Expanded(
//                 child: Row(
//                   children:  <Widget>[
//                     Expanded(
//                       child: GoogleMap(
//                         mapType: MapType.normal,
//                         initialCameraPosition: _kinitialPosition,
//                         onMapCreated: (GoogleMapController controller) {
//                           _controller.complete(controller);
//                         },
//                         myLocationEnabled: true,
//                         markers: Set<Marker>.of(markers.values),
//                       ),
//
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//
//   _showDialog(BuildContext context) {
//     Scaffold.of(context).showSnackBar(
//       const SnackBar(
//         content: Text('Submitting form'),
//       ),
//     );
//   }
// }
