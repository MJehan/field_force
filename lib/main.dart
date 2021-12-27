import 'package:field_force/screens/my_feed.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login/login_screen.dart';
import 'login/registration.dart';
// import 'package:theme_provider/theme_provider.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  ResponsiveSizingConfig.instance.setCustomBreakpoints(
    const ScreenBreakpoints(desktop: 800, tablet: 550, watch: 200),
  );
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var email = prefs.getString('email');
  runApp(
      MaterialApp(
        initialRoute: email == null ? LoginScreen.id : MyProfile.id,
        routes: {
          //WelcomeScreen.id: (context) => WelcomeScreen(),
           LoginScreen.id: (context) => LoginScreen(),
           MyProfile.id: (context) => const MyProfile(),
           RegistrationScreen.id: (context) => const RegistrationScreen(),
          // AdminDashboard.id: (context) => const AdminDashboard(),
        },
        debugShowCheckedModeBanner: false,
      )
  );
}