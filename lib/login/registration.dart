import 'package:field_force/component/rounded_button.dart';
import 'package:field_force/constrains/constrain.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

final CollectionReference collectionReference = FirebaseFirestore.instance.collection('users');

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';

  const RegistrationScreen({Key? key}) : super(key: key);
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  late String email;
  late String password;
  late String name;
  late String department;
  late String regnum;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    //height: 200.0,
                    child: Image.asset('images/bg_l.png'),
                  ),
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              const Center(
                child: Text(
                  "SignUp",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.blueAccent,
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                //obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  name = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Student Name'),
              ),
              const SizedBox(
                height: 8.0,
              ),
              TextField(
                //obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  regnum = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Registration number'),
              ),
              const SizedBox(
                height: 8.0,
              ),
              TextField(
                //obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  department = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Department'),
              ),
              const SizedBox(
                height: 8.0,
              ),
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
                height: 24.0,
              ),

              RaisedButton(
                onPressed: () async {
                  setState(() {
                    showSpinner = true;
                  });
                  try{
                    final newUser  = await _auth.createUserWithEmailAndPassword(email: email, password: password);
                    if(newUser != null)
                    {
                      User? user = await _auth.currentUser;
                      collectionReference.doc(user!.uid).set({
                        "name" : name,
                        "regnum": regnum,
                        "department" : department,
                        "email" : email,
                        "password" : password,
                        "_identifier" : user.uid,
                      }).then((value) async {
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        prefs.setString('email',email);
                        Navigator.pushNamed(context, LoginScreen.id);
                      });
                    }
                    setState(() {
                      showSpinner = false;
                    });
                  } on FirebaseAuthException catch (e) {
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title:
                        const Text(' Ops! Registration Failed'),
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
              //   title: 'Register',
              //   colour: Colors.lightBlueAccent,
              //   onPressed: () async {
              //     setState(() {
              //       showSpinner = true;
              //     });
              //     try{
              //       final newUser  = await _auth.createUserWithEmailAndPassword(email: email, password: password);
              //       if(newUser != null)
              //         {
              //           User? user = await _auth.currentUser;
              //           collectionReference.doc(user!.uid).set({
              //             "name" : name,
              //             "email" : email,
              //             "password" : password,
              //             "_identifier" : user.uid,
              //           }).then((value) async {
              //             SharedPreferences prefs = await SharedPreferences.getInstance();
              //             prefs.setString('email',email);
              //             Navigator.pushNamed(context, LoginScreen.id);
              //           });
              //         }
              //       setState(() {
              //         showSpinner = false;
              //       });
              //     } on FirebaseAuthException catch (e) {
              //       showDialog(
              //         context: context,
              //         builder: (ctx) => AlertDialog(
              //           title:
              //           const Text(' Ops! Registration Failed'),
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
              //     }
              //     setState(() {
              //       showSpinner = false;
              //     });
              //   },
              // ),


            ],
          ),
        ),
      ),
    );
  }
}