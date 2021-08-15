import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_2/models/cowdata_model.dart';
import 'package:flutter_application_2/utility/my_constant.dart';
import 'package:flutter_application_2/utility/my_dialog.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class Adddata extends StatefulWidget {
  const Adddata({Key? key}) : super(key: key);

  @override
  _AdddataState createState() => _AdddataState();
}

class _AdddataState extends State<Adddata> {
  String? type;

  String? gendle;
  String? dateChooseStr;
  final formKey = GlobalKey<FormState>();
  TextEditingController idController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  File? file;
  final ImagePicker picker = ImagePicker();
  Future<Null> chooseImage(ImageSource imageSource) async {
    try {
      var object = await picker.getImage(
          source: imageSource, maxHeight: 600.0, maxWidth: 600.0);

      setState(() {
        file = File(object!.path);
      });
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('เพิ่มข้อมูล'),
        actions: [
          IconButton(
              onPressed: () => processSaveData(),
              icon: Icon(Icons.cloud_upload))
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //text
              Container(
                  padding: EdgeInsets.only(left: 20),
                  margin: EdgeInsets.only(top: 10),
                  child: Text(
                    'รหัส',
                    style: TextStyle(fontSize: 20),
                  )),
              Container(
                margin:
                    EdgeInsets.only(left: 10, top: 5, right: 10, bottom: 20),
                height: 50,
                child: TextFormField(
                  controller: idController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'กรุณากรอก รหัส';
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Container(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    'ประเภท',
                    style: TextStyle(fontSize: 20),
                  )),
              buildType(),
              Container(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    'เพศ',
                    style: TextStyle(fontSize: 20),
                  )),
              buildGendle(),
              Container(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    'อายุ(ปี)',
                    style: TextStyle(fontSize: 20),
                  )),
              Container(
                margin:
                    EdgeInsets.only(left: 10, top: 5, right: 10, bottom: 20),
                height: 50,
                child: TextFormField(
                  controller: ageController,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'กรุณากรอก อายุ';
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  'วันที่ฉีดวัคซีน',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              buildDate(),
              //text

              //picture
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.add_a_photo,
                      size: 36.0,
                    ),
                    onPressed: () => chooseImage(ImageSource.camera),
                  ),
                  Container(
                    width: 250.0,
                    child: file == null
                        ? Image.asset('assets/images/addata.png')
                        : Image.file(file!),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.add_photo_alternate,
                      size: 36.0,
                    ),
                    onPressed: () => chooseImage(ImageSource.gallery),
                  ),
                ],
              ),
              //picture

              //button
              Column(
                children: [
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(top: 20, bottom: 20),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.only(
                              top: 12, bottom: 12, right: 20, left: 20),
                          primary: Colors.black,
                          textStyle: TextStyle(fontSize: 16),
                          backgroundColor: Colors.lightGreenAccent[400],
                        ),
                        onPressed: () {
                          print("you win");
                          processSaveData();
                        },
                        child: Text('บันทึกข้อมูล'),
                      ),
                    ),
                  ),
                ],
              ),
              //button
            ],
          ),
        ),
      ),
    );
  }

  Container buildDate() {
    return Container(
      margin: EdgeInsets.only(left: 10, top: 5, right: 10, bottom: 20),
      child: ListTile(
        leading: Icon(Icons.date_range),
        title: Text(dateChooseStr == null ? 'dd-MM-YYYY' : dateChooseStr!),
        onTap: () => chooseDate(),
      ),
    );
  }

  Future<Null> chooseDate() async {
    DateTime dateTime = DateTime.now();
    String showDateTime = dateTime.toString();

    DateTime? chooseDateTime = await showDatePicker(
        context: context,
        initialDate: dateTime,
        firstDate: DateTime(dateTime.year - 5),
        lastDate: DateTime(dateTime.year + 5));

    DateFormat dateFormat = DateFormat('dd-MM-yyyy');
    setState(() {
      dateChooseStr = dateFormat.format(chooseDateTime!);
    });

    print('chooseDateTiem == $dateChooseStr');
  }

  Container buildGendle() {
    return Container(
      margin: EdgeInsets.only(left: 10, top: 5, right: 10, bottom: 20),
      height: 50,
      child: type == null ? SizedBox() : Text(gendle!),
    );
  }

  Container buildType() {
    List<String> titles = MyConstant.titles;
    return Container(
      margin: EdgeInsets.only(left: 10, top: 5, right: 10, bottom: 20),
      height: 50,
      child: DropdownButton(
        onChanged: (value) {
          setState(() {
            type = value as String?;
            if (type == titles[1]) {
              gendle = 'เพศเมีย';
            } else {
              gendle = 'เพศผู้';
            }
          });
        },
        hint: Text('กรุณาเลือก ประเภท'),
        value: type,
        items: titles
            .map(
              (e) => DropdownMenuItem(
                child: Text(e),
                value: e,
              ),
            )
            .toList(),
      ),
    );
  }

  Future<Null> processSaveData() async {
    if (formKey.currentState!.validate()) {
      if (type == null) {
        MyDialog().normalDilalog(
            context, 'ยังไม่ได้เลือก ประเภท', 'โปรดเลือก ประเภทด้วยคะ');
      } else if (dateChooseStr == null) {
        MyDialog().normalDilalog(
            context, 'ยังไม่ได้ เลือกวันที่ฉีด', 'กรุณาเลือก วันที่ฉีด');
      } else if (file == null) {
        MyDialog().normalDilalog(context, 'ยังไม่มีภาพ ?',
            'กรุณาถ่ายภาพ หรือ เลือกจาก Gallery ด้วยคะ');
      } else {
        String idCode = idController.text;
        String age = ageController.text;

        await Firebase.initializeApp().then((value) async {
          await FirebaseAuth.instance.authStateChanges().listen((event) async {
            String uid = event!.uid;

            int i = Random().nextInt(1000000);
            String nameFile = 'cow$i.jpg';

            FirebaseStorage storage = FirebaseStorage.instance;
            var refer = storage.ref().child('cowpic/$nameFile');
            UploadTask task = refer.putFile(file!);
            await task.whenComplete(() async {
              await refer.getDownloadURL().then((value) async {
                String pathImage = value;

                CowDataModel model = CowDataModel(
                    age: int.parse(age),
                    dateChoose: dateChooseStr!,
                    gendle: gendle!,
                    idCode: idCode,
                    pathImage: pathImage,
                    type: type!,
                    uidRecord: uid);

                Map<String, dynamic> map = model.toMap();

                await FirebaseFirestore.instance
                    .collection('cowdata')
                    .doc()
                    .set(map)
                    .then((value) => Navigator.pop(context));

                // print('## idCode = $idCode, type = $type, gendle = $gendle,');
                // print(
                //     '## age = $age, dateChoose = $dateChooseStr, uid = $uid, pathImage= $pathImage');
              });
            });
          });
        });
      }
    }
  }
}
