import 'package:field_force/admin/Search/search_screen_home.dart';
import 'package:flutter/material.dart';

class SearchEmployee extends StatefulWidget {
  const SearchEmployee({Key? key}) : super(key: key);

  @override
  _SearchEmployeeState createState() => _SearchEmployeeState();
}

class _SearchEmployeeState extends State<SearchEmployee> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'All Employee',
          style: TextStyle(color: Colors.deepPurple),
        ),
        backgroundColor: Colors.white70,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const SearchScreenHome()));
          },
          icon:
              const Icon(Icons.compare_arrows_sharp, color: Colors.deepPurple),
        ),
      ),
    );
  }
}
