import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PunchInPopUp extends StatelessWidget {
  const PunchInPopUp({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0)
        ),
        child: Stack(
          overflow: Overflow.visible,
          alignment: Alignment.topCenter,
          children: [
            Container(
              height: 200,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 70, 10, 10),
                child: Column(
                  children: [
                    const Text('Warning !!!', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                    const SizedBox(height: 5,),
                    const Text('You have already Press.', style: TextStyle(fontSize: 18),),
                    const SizedBox(height: 20,),
                    RaisedButton(
                      onPressed: () {
                      Navigator.of(context).pop();
                    },
                      color: Colors.red,
                      child: const Text('Okay', style: TextStyle(color: Colors.white),),
                    )
                  ],
                ),
              ),
            ),
            const Positioned(
                top: -60,
                child: CircleAvatar(
                  backgroundColor: Colors.redAccent,
                  radius: 50,
                  child: Icon(Icons.warning_amber, color: Colors.white, size: 70),
                )
            ),
          ],
        )
    );
  }




  // Widget build(BuildContext context) {
  //   return AlertDialog(
  //     title: const Center(
  //         child: Text(
  //       'Alart',
  //       style: TextStyle(color: Colors.red),
  //     )),
  //     content: Column(
  //       mainAxisSize: MainAxisSize.min,
  //       //crossAxisAlignment: CrossAxisAlignment.start,
  //       children: <Widget>[
  //         Center(
  //           child: Text(title),
  //         ),
  //       ],
  //     ),
  //     actions: <Widget>[
  //       FlatButton(
  //         onPressed: () {
  //           Navigator.of(context).pop();
  //         },
  //         textColor: Theme.of(context).primaryColor,
  //         child: const Text('Close'),
  //       ),
  //     ],
  //   );
  // }
}

