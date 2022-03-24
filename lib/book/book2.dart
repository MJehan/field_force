import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Book2 extends StatefulWidget {
  static const String id = 'book2';
  const Book2({Key? key}) : super(key: key);

  @override
  _Book2State createState() => _Book2State();
}

class _Book2State extends State<Book2> {
  final _key = UniqueKey();
  final _url = "https://www.academia.edu/30166983/CA03_0_Principles_of_Data_Structures_Book_pdf";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: WebView(
                key: _key,
                javascriptMode: JavascriptMode.unrestricted,
                initialUrl: _url,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

