import 'package:flutter/material.dart';

class ShowAllDataListView extends StatelessWidget {
  //String location;
  String name;
  String email;
  String _userID;

  ShowAllDataListView(this.name, this.email, this._userID, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          Material(
            borderRadius: BorderRadius.circular(10.00),
            elevation:    20.00,
            //color: Colors.deepPurpleAccent,
            child: Container(
              // decoration: BoxDecoration(
              //   borderRadius: BorderRadius.circular(30.00),
              //   gradient: const LinearGradient(
              //     begin: Alignment.topCenter,
              //     end: Alignment.bottomCenter,
              //     colors: [Color(0xff374ABE), Color(0xff64B6FF)],
              //   ),
              // ),
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical:10.0),
              child: ListTile(
                subtitle: Text('Email: $email', textAlign: TextAlign.left,),
                leading: Image.asset('images/scom2.png',width: 90,height: 180,),
                title: Text(
                  'Name: $name',
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
                    _userID, textAlign: TextAlign.left,
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
