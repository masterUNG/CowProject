import 'package:flutter/material.dart';

class MyDialog {
  Future<Null> normalDilalog(
      BuildContext context, String title, String message) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: ListTile(
          leading: Image.asset('assets/images/men.png'),
          title: Text(title),
          subtitle: Text(message),
        ),actions: [TextButton(onPressed: () => Navigator.pop(context), child: Text('OK'))],
      ),
    );
  }
}
