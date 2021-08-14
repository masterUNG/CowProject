import 'package:flutter/material.dart';

class Wagyu extends StatefulWidget {
  const Wagyu({ Key? key }) : super(key: key);

  @override
  _WagyuState createState() => _WagyuState();
}

class _WagyuState extends State<Wagyu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Wagyu'),
      ),
      body: Text('วัวขุน'),
    );
  }
}