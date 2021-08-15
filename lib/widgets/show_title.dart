import 'package:flutter/material.dart';

class ShowTitle extends StatelessWidget {
  final String title;
  const ShowTitle({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: 20),
        margin: EdgeInsets.only(top: 10),
        child: Text(
          title,
          style: TextStyle(fontSize: 20),
        ));
  }
}
