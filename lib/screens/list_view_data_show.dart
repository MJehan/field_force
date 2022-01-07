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
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black54,
            ),
          ),
          Material(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.00),
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xff374ABE), Color(0xff64B6FF)],
              ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Text('Location: $location\nTime: $time',
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





