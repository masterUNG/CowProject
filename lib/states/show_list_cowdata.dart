import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/models/cowdata_model.dart';
import 'package:flutter_application_2/widgets/show_progress.dart';
import 'package:flutter_application_2/widgets/show_title.dart';

class ShowListCowData extends StatefulWidget {
  final String type;
  const ShowListCowData({Key? key, required this.type}) : super(key: key);

  @override
  _ShowListCowDataState createState() => _ShowListCowDataState();
}

class _ShowListCowDataState extends State<ShowListCowData> {
  String? type;
  List<CowDataModel> cowDataModels = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    type = widget.type;
    readCowData();
  }

  Future<Null> readCowData() async {
    await Firebase.initializeApp().then((value) async {
      await FirebaseFirestore.instance
          .collection('cowdata')
          .where('type', isEqualTo: type)
          .snapshots()
          .listen((event) {
        for (var item in event.docs) {
          CowDataModel model = CowDataModel.fromMap(item.data());
          setState(() {
            cowDataModels.add(model);
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(type!),
      ),
      body: cowDataModels.length == 0
          ? ShowProgress()
          : LayoutBuilder(
              builder: (context, constraints) => buildListView(constraints),
            ),
    );
  }

  Future<Null> myShowDialog(CowDataModel model) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: ShowTitle(title: 'รหัส = ${model.idCode}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('เพศ = ${model.gendle}'),
            Text('อายุ = ${model.ageString}'),
            Text('วันที่ฉีดวัคซีน = ${model.dateChoose}'),
            SizedBox(
              height: 8,
            ),
            Image.network(model.pathImage),
            SizedBox(
              height: 8,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
        ],
      ),
    );
  }

  ListView buildListView(BoxConstraints constraints) {
    return ListView.builder(
      itemCount: cowDataModels.length,
      itemBuilder: (context, index) => InkWell(
        onTap: () => myShowDialog(cowDataModels[index]),
        child: Card(
          color: index % 2 == 0 ? Colors.grey.shade400 : Colors.white,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: constraints.maxWidth * 0.5 - 4,
                child: ShowTitle(title: cowDataModels[index].idCode),
              ),
              Container(
                width: constraints.maxWidth * 0.5 - 4,
                height: constraints.maxWidth * 0.4,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.network(
                    cowDataModels[index].pathImage,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
