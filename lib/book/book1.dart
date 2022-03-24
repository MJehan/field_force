import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Book1 extends StatefulWidget {
  static const String id = 'ims_screen';
  const Book1({Key? key}) : super(key: key);

  @override
  _Book1State createState() => _Book1State();
}

class _Book1State extends State<Book1> {
  final _key = UniqueKey();
  final _url = "https://www.freetechbooks.com/algorithmic-problem-solving-t373.html";
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
