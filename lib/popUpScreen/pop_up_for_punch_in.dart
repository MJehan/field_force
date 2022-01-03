import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PunchInPopUp extends StatelessWidget {
  const PunchInPopUp({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Center(
          child: Text(
        'Alart',
        style: TextStyle(color: Colors.red),
      )),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: Text(title),
          ),
        ],
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('Close'),
        ),
      ],
    );
  }
}

