import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListViewScreen extends StatelessWidget {
  ListViewScreen(this.location, this.text, this.time, {Key? key}) : super(key: key);
  String location;
  String text;
  String time;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          Text(
            text,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.black54,
            ),
          ),
          Material(
            borderRadius: BorderRadius.circular(30.00),
            elevation: 5.00,
            color: Colors.deepPurpleAccent,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Text( 'Location: $location\nTime: $time',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}





