import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class Adddata extends StatefulWidget {
  const Adddata({Key? key}) : super(key: key);

  @override
  _AdddataState createState() => _AdddataState();
}

class _AdddataState extends State<Adddata> {
  String? type;
  List<String> titles = ['พ่อพันธุ์', 'แม่พันธุ์', 'วัวขุน'];
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
                    'อายุ',
                    style: TextStyle(fontSize: 20),
                  )),
              Container(
                margin:
                    EdgeInsets.only(left: 10, top: 5, right: 10, bottom: 20),
                height: 50,
                child: TextFormField(
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
      
    }
  }
}
