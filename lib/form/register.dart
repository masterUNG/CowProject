import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/form/login.dart';
import 'package:flutter_application_2/form/profile.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';

class register extends StatefulWidget {
  const register({Key? key}) : super(key: key);

  @override
  _registerState createState() => _registerState();
}

class _registerState extends State<register> {
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
                title: Text(("สร้างบัญชีผู้ใช้")),
              ),
              body: Container(
                child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 50, 10, 0),
                      child: Column(children: [
                        Container(
                            padding: EdgeInsets.only(left: 10),
                            alignment: FractionalOffset.topLeft,
                            child: Text('ชื่อผู้ใช้')),
                        Container(
                          margin: EdgeInsets.only(top: 5, bottom: 20),
                          height: 50,
                          child: TextFormField(
                            validator: RequiredValidator(
                                errorText: "กรุณากรอกชื่อผู้ใช้ด้วยครับ"),
                            onSaved: (String? fname) {
                              profile.fname = fname;
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
                            child: Text('นามสกุล')),
                        Container(
                          margin: EdgeInsets.only(top: 5, bottom: 20),
                          height: 50,
                          child: TextFormField(
                            validator: RequiredValidator(
                                errorText: "กรุณากรอกนามสกุลด้วยครับ"),
                            onSaved: (String? lname) {
                              profile.lname = lname;
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
                              icon: Icon(Icons.add),
                              label: Text(
                                "ยืนยันการลงทะเบียน",
                                style: TextStyle(fontSize: 20),
                              ),
                              onPressed: () async {
                                if (formKey.currentState!.validate()) {
                                  formKey.currentState!.save();
                                  try {
                                    await FirebaseAuth.instance
                                        .createUserWithEmailAndPassword(
                                            email: profile.email!,
                                            password: profile.password!)
                                        .then((value) {
                                      formKey.currentState!.reset();
                                      Fluttertoast.showToast(
                                          msg: "ลงทะเบียนเรียบร้อยแล้ว",
                                          gravity: ToastGravity.CENTER);

                                      Navigator.pushReplacement(context,
                                          MaterialPageRoute(builder: (context) {
                                        return login();
                                      }));
                                    });
                                  } on FirebaseAuthException catch (e) {
                                    print(e.code);
                                    String? message;
                                    if (e.code == 'email-already-in-use') {
                                      message =
                                          "มีอีเมลนี้ในระบบแล้วครับ โปรดใช้อีเมลอื่นแทน";
                                    } else if (e.code == 'weak-password') {
                                      message =
                                          "รหัสผ่านต้องมีความยาว 6 ตัวขึ้นไป";
                                    } else {
                                      message = e.message;
                                    }
                                    Fluttertoast.showToast(
                                        msg: message!,
                                        gravity: ToastGravity.CENTER);
                                  }
                                }
                              }),
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
