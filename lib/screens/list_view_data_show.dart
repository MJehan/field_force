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
        children:  <Widget>[
          Material(
            child: Container(
              // decoration: BoxDecoration(
              //   borderRadius: BorderRadius.circular(30.00),
              //   gradient: const LinearGradient(
              //     begin: Alignment.topCenter,
              //     end: Alignment.bottomCenter,
              //     colors: [Color(0xffffffff), Color(0xffffffff)],
              //     //colors: [Color(0xff374ABE), Color(0xff64B6FF)],
              // ),
              // ),
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child:  (text == 'Check In')? ListTile(
                subtitle: Text(
                  'Time: $time',
                  textAlign: TextAlign.right,
                ),
                leading: const Icon(Icons.album_rounded, color: Colors.green),
                title: Text(
                  'Location: $location',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 15.0,
                  ),
                ),
                trailing: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                      //border: Border.all(color: Colors.blueAccent)
                  ),
                  child: Text(
                    text,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      backgroundColor: Colors.black12,
                      fontWeight: FontWeight.bold,
                    ),

                  ),
                ),
              ): ListTile(
                subtitle: Text('Time: $time', textAlign: TextAlign.right,),
                leading: const Icon(Icons.album_rounded, color: Colors.red,),
                title: Text(
                  'Location: $location',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 15.0,
                  ),
                ),
                trailing: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    //border: Border.all(color: Colors.blueAccent)
                  ),
                  child: Text(
                    text, textAlign: TextAlign.left,
                    style: const TextStyle(
                      backgroundColor: Colors.black12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            ),
          ),
        ],
      ),
    );
  }
}





