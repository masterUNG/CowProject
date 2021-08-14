import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/datapage.dart';
import 'package:flutter_application_2/form/login.dart';

final Map<String, WidgetBuilder> map = {
  '/authen': (BuildContext context) => Login(),
  '/dataPage': (BuildContext context) => Datapage(),
};

String? firesState;

Future<Null> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) async {
    await FirebaseAuth.instance.authStateChanges().listen((event) {
      if (event == null) {
        firesState = '/authen';
        runApp(MyApp());
      } else {
        firesState = '/dataPage';
        runApp(MyApp());
      }
    });
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'mainpage',
      theme: ThemeData(primarySwatch: Colors.green),
      routes: map,
      initialRoute: firesState,
    );
  }
}
