import 'package:flutter/material.dart';

class Men extends StatefulWidget {
  const Men({ Key? key }) : super(key: key);

  @override
  _MenState createState() => _MenState();
}

class _MenState extends State<Men> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Men'),
      ),
      body: Text('พ่อพันธุ์'),
    );
  }
}