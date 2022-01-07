import 'package:flutter/material.dart';

class ShowAllDataListView extends StatelessWidget {
  //String location;
  String name;
  String email;

  ShowAllDataListView(this.name, this.email, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          Material(
            borderRadius: BorderRadius.circular(30.00),
            elevation: 10.00,
            color: Colors.deepPurpleAccent,
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
              child: Text('Location: $name\nTime: $email',
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
