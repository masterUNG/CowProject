import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/datapage.dart';
import 'package:flutter_application_2/form/profile.dart';
import 'package:flutter_application_2/form/register.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';

class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  _loginState createState() => _loginState();
}

class _loginState extends State<login> {
  final formKey = GlobalKey<FormState>();
  Profile profile = Profile();
  final Future<FirebaseApp> firebase = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: firebase,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              appBar: AppBar(
                title: Text("Error"),
              ),
              body: Center(
                child: Text("${snapshot.error}"),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              appBar: AppBar(
                title: Text(("เข้าสู่ระบบ")),
              ),
              body: Container(
                child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 50, 10, 0),
                      child: Column(children: [
                        Container(
                            margin: EdgeInsets.only(bottom: 20),
                            child: Image.asset(
                              'assets/images/cow.jpg',
                              width: 400,
                            )),
                        Container(
                            padding: EdgeInsets.only(left: 10),
                            alignment: FractionalOffset.topLeft,
                            child: Text('อีเมล')),
                        Container(
                          margin: EdgeInsets.only(top: 5, bottom: 20),
                          height: 50,
                          child: TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            validator: MultiValidator([
                              RequiredValidator(
                                  errorText: "กรุณากรอกรหัสผ่านด้วยครับ"),
                              EmailValidator(
                                  errorText: "รูปแบบอีเมลไม่ถูกต้อง"),
                            ]),
                            onSaved: (String? email) {
                              profile.email = email;
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: '',
                            ),
                          ),
                        ),
                        Container(
                            padding: EdgeInsets.only(left: 10),
                            alignment: FractionalOffset.topLeft,
                            child: Text('รหัสผ่าน')),
                        Container(
                          margin: EdgeInsets.only(top: 5, bottom: 20),
                          height: 50,
                          child: TextFormField(
                            obscureText: true,
                            validator: RequiredValidator(
                                errorText: "กรุณากรอกรหัสผ่านด้วยครับ"),
                            onSaved: (String? password) {
                              profile.password = password;
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: '',
                            ),
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                              icon: Icon(Icons.login),
                              label: Text(
                                "ลงชื่อเข้าใช้",
                                style: TextStyle(fontSize: 20),
                              ),
                              onPressed: () async {
                                if (formKey.currentState!.validate()) {
                                  formKey.currentState!.save();
                                  try {
                                    await FirebaseAuth.instance
                                        .signInWithEmailAndPassword(
                                            email: profile.email!,
                                            password: profile.password!)
                                        .then((value) {
                                      formKey.currentState!.reset();
                                      Navigator.pushReplacement(context,
                                          MaterialPageRoute(builder: (context) {
                                        return datapage();
                                      }));
                                    });
                                  } on FirebaseAuthException catch (e) {
                                    Fluttertoast.showToast(
                                        msg: e.message!,
                                        gravity: ToastGravity.CENTER);
                                  }
                                }
                              }),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            icon: Icon(Icons.add),
                            label: Text(
                              "สร้างบัญชีผู้ใช้",
                              style: TextStyle(fontSize: 20),
                            ),
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) {
                                  return register();
                                }),
                              );
                            },
                          ),
                        ),
                      ]),
                    ),
                  ),
                ),
              ),
            );
          }
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}
