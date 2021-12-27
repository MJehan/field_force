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
                height: 70.0,
              ),
              Padding(
                  padding:const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      TextField(
                        keyboardType: TextInputType.emailAddress,
                        textAlign: TextAlign.center,
                        onChanged: (value) {
                          email = value;
                        },
                        decoration:
                        kTextFieldDecoration.copyWith(hintText: 'Enter your email'),
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
                        height: 10.0,
                      ),
                      RoundedButton(
                        title: 'Log In',
                        colour: Colors.lightBlueAccent,
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
                          } catch (e) {
                            print(e);
                          }
                        },
                      ),
                      const SizedBox(
                        height: 1.0,
                      ),
                      RoundedButton(
                          title: 'Registration',
                          colour: Colors.lightBlueAccent,
                          onPressed: () async {
                            Navigator.pushNamed(context, RegistrationScreen.id);
                          }
                      ),
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