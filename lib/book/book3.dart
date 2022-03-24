import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Book3 extends StatefulWidget {
  static const String id = 'book3';
  const Book3({Key? key}) : super(key: key);

  @override
  _Book3State createState() => _Book3State();
}

class _Book3State extends State<Book3> {
  final _key = UniqueKey();
  final _url = "https://www.academia.edu/29376441/Microelectronic_Circuits_6th_Edition_Adel_S_Sedra_and_Kenneth_Carless_Smith_pdf";
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
