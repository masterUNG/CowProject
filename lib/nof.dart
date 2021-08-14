import 'package:flutter/material.dart';

class nof extends StatefulWidget {
  const nof({ Key? key }) : super(key: key);

  @override
  _nofState createState() => _nofState();
}

class _nofState extends State<nof> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('nof'),
      ),
      body: Text('แจ้งเตือน'),
    );
  }
}