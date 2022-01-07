import 'package:field_force/component/rounded_button.dart';
import 'package:field_force/constrains/constrain.dart';
import 'package:field_force/login/registration.dart';
import 'package:field_force/screens/my_feed.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


final CollectionReference userName = FirebaseFirestore.instance.collection('users');

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool showSpinner = false;
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top:9.0),
                child: Flexible(
                  child: Hero(
                    tag: 'logo',
                    child: Container(
                      //height: 200.0,
                      child: Image.asset('images/scom.jpg'),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 50.0,
              ),
              Padding(
                  padding:const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      SingleChildScrollView(
                        child: TextField(
                          keyboardType: TextInputType.emailAddress,
                          textAlign: TextAlign.center,
                          onChanged: (value) {
                            email = value;
                          },
                          decoration:
                          kTextFieldDecoration.copyWith(hintText: 'Enter your email'),
                        ),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      TextField(
                        obscureText: true,
                        textAlign: TextAlign.center,
                        onChanged: (value) {
                          password = value;
                        },
                        decoration: kTextFieldDecoration.copyWith(
                            hintText: 'Enter your password'),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      RaisedButton(
                        onPressed: () async {
                          setState(() {
                            showSpinner = true;
                          });
                          try {
                            final user = await _auth.signInWithEmailAndPassword(
                                email: email, password: password);
                            if (user != null) {
                              //final result = await userName.doc().get();
                              SharedPreferences prefs = await SharedPreferences.getInstance();
                              prefs.setString('email',email);
                              Navigator.pushNamed(context, MyProfile.id);
                            }

                            setState(() {
                              showSpinner = false;
                            });
                          } on FirebaseAuthException catch (e) {
                            showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                title: const Text("Ops! Login Failed"),
                                content: Text('${e.message}'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(ctx).pop();
                                    },
                                    child: const Text('Okay'),
                                  )
                                ],
                              ),
                            );
                            print(e);
                          }
                          setState(() {
                            showSpinner = false;
                          });
                        },
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                        padding: const EdgeInsets.all(0.0),
                        child: Ink(
                          decoration: BoxDecoration(
                              gradient: const LinearGradient(colors: [Color(0xff374ABE), Color(0xff64B6FF)],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              borderRadius: BorderRadius.circular(30.0)
                          ),
                          child: Container(
                            constraints: const BoxConstraints(maxWidth: 375.0, minHeight: 50.0),
                            alignment: Alignment.center,
                            child: const Text(
                              "Log In",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white
                              ),
                            ),
                          ),
                        ),
                      ),
                      // RoundedButton(
                      //   title: 'Log In',
                      //   colour: Colors.lightBlueAccent,
                      //   onPressed: () async {
                      //     setState(() {
                      //       showSpinner = true;
                      //     });
                      //     try {
                      //       final user = await _auth.signInWithEmailAndPassword(
                      //           email: email, password: password);
                      //       if (user != null) {
                      //         //final result = await userName.doc().get();
                      //         SharedPreferences prefs = await SharedPreferences.getInstance();
                      //         prefs.setString('email',email);
                      //         Navigator.pushNamed(context, MyProfile.id);
                      //       }
                      //
                      //       setState(() {
                      //         showSpinner = false;
                      //       });
                      //     } on FirebaseAuthException catch (e) {
                      //       showDialog(
                      //         context: context,
                      //         builder: (ctx) => AlertDialog(
                      //           title: const Text("Ops! Login Failed"),
                      //           content: Text('${e.message}'),
                      //           actions: [
                      //             TextButton(
                      //               onPressed: () {
                      //                 Navigator.of(ctx).pop();
                      //               },
                      //               child: const Text('Okay'),
                      //             )
                      //           ],
                      //         ),
                      //       );
                      //       print(e);
                      //     }
                      //     setState(() {
                      //       showSpinner = false;
                      //     });
                      //   },
                      // ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      RaisedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, RegistrationScreen.id);
                        },
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                        padding: const EdgeInsets.all(0.0),
                        child: Ink(
                          decoration: BoxDecoration(
                              gradient: const LinearGradient(colors: [Color(0xff374ABE), Color(0xff64B6FF)],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              borderRadius: BorderRadius.circular(30.0)
                          ),
                          child: Container(
                            constraints: const BoxConstraints(maxWidth: 375.0, minHeight: 50.0),
                            alignment: Alignment.center,
                            child: const Text(
                              "Registration",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white
                              ),
                            ),
                          ),
                        ),
                      ),
                      // RoundedButton(
                      //     title: 'Registration',
                      //     colour: Colors.lightBlueAccent,
                      //     onPressed: () async {
                      //       Navigator.pushNamed(context, RegistrationScreen.id);
                      //     }
                      // ),
                    ],
                  ),

              ),
            ],
          ),
        ),
      ),
    );
  }
}