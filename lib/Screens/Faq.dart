import 'package:flutter/material.dart';
class FAQ extends StatefulWidget {

  @override
  _FAQState createState() => _FAQState();
}

class _FAQState extends State<FAQ> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("FAQ",
            style: TextStyle(color: Colors.white, fontSize: 18)),
      ),
      body: Container(),
    );
  }
}
