import 'package:flutter/material.dart';

class Women extends StatefulWidget {
  const Women({ Key? key }) : super(key: key);

  @override
  _WomenState createState() => _WomenState();
}

class _WomenState extends State<Women> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Women'),
      ),
      body: Text('แม่พันธุ์'),
    );
  }
}