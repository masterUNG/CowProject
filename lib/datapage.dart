import 'package:flutter/material.dart';
import 'package:flutter_application_2/Setting.dart';
import 'package:flutter_application_2/adddata.dart';
import 'package:flutter_application_2/nof.dart';

import 'cow/Men.dart';
import 'cow/Wagyu.dart';
import 'cow/Women.dart';

class datapage extends StatefulWidget {
  const datapage({Key? key}) : super(key: key);

  @override
  _datapageState createState() => _datapageState();
}

class _datapageState extends State<datapage> {
  @override
  Widget build(BuildContext context) => DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: Center(
              child: Text(
                'Cow Management System',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                color: Colors.black,
                icon: Icon(Icons.notifications),
                onPressed: () {},
              ),
              IconButton(
                color: Colors.black,
                icon: Icon(Icons.person_rounded),
                onPressed: () {},
              )
            ],
            flexibleSpace: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.green, Colors.blueGrey],
                      begin: Alignment.bottomRight,
                      end: Alignment.topLeft)),
            ),
            bottom: TabBar(
              indicatorWeight: 2,
              isScrollable: true,
              indicatorColor: Colors.white,
              tabs: [
                Tab(
                  icon: Icon(
                    Icons.home,
                    color: Colors.black,
                  ),
                  text: ('Home'),
                ),
                Tab(
                  icon: Icon(
                    Icons.star,
                    color: Colors.black,
                  ),
                  text: ('Feed'),
                ),
                Tab(
                  icon: Icon(
                    Icons.face,
                    color: Colors.black,
                  ),
                  text: ('Profile'),
                ),
                Tab(
                  icon: Icon(
                    Icons.settings,
                    color: Colors.black,
                  ),
                  text: ('Setting'),
                ),
              ],
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(bottom: 52),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/cow22.png'),
                      fit: BoxFit.cover)),
              child: Center(
                child: Wrap(
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MaterialButton(
                            child: Container(
                                width: 135,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.white, // set border color
                                      width: 7.0), // set border width
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(
                                          10.0)), // set rounded corner radius
                                ),
                                child: Image.asset('assets/images/addata.png')),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => adddata()));
                            },
                          ),
                          MaterialButton(
                            child: Container(
                                width: 135,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.white, // set border color
                                      width: 7.0), // set border width
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(
                                          10.0)), // set rounded corner radius
                                ),
                                child: Image.asset('assets/images/men.png')),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Men()));
                            },
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                margin: EdgeInsets.only(top: 5),
                                color: Colors.white,
                                width: 160,
                                child: Center(child: Text('เพิ่มข้อมูล'))),
                            Container(
                                margin: EdgeInsets.only(top: 5),
                                color: Colors.white,
                                width: 160,
                                child: Center(child: Text('พ่อพันธุ์'))),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 20),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              MaterialButton(
                                child: Container(
                                    width: 135,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color:
                                              Colors.white, // set border color
                                          width: 7.0), // set border width
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(
                                              10.0)), // set rounded corner radius
                                    ),
                                    child:
                                        Image.asset('assets/images/women.png')),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Women()));
                                },
                              ),
                              MaterialButton(
                                child: Container(
                                    width: 135,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color:
                                              Colors.white, // set border color
                                          width: 7.0), // set border width
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(
                                              10.0)), // set rounded corner radius
                                    ),
                                    child:
                                        Image.asset('assets/images/wagyu.png')),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Wagyu()));
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                margin: EdgeInsets.only(top: 5),
                                color: Colors.white,
                                width: 160,
                                child: Center(child: Text('แม่พันธุ์'))),
                            Container(
                                margin: EdgeInsets.only(top: 5),
                                color: Colors.white,
                                width: 160,
                                child: Center(child: Text('วัวขุน'))),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MaterialButton(
                            child: Container(
                                width: 135,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.white, // set border color
                                      width: 7.0), // set border width
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(
                                          10.0)), // set rounded corner radius
                                ),
                                child: Image.asset('assets/images/nof.png')),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => nof()));
                            },
                          ),
                          MaterialButton(
                            child: Container(
                                width: 135,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.white, // set border color
                                      width: 7.0), // set border width
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(
                                          10.0)), // set rounded corner radius
                                ),
                                child:
                                    Image.asset('assets/images/Setting.png')),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Setting()));
                            },
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                margin: EdgeInsets.only(top: 5),
                                color: Colors.white,
                                width: 160,
                                child: Center(child: Text('การแจ้งเตือน'))),
                            Container(
                                margin: EdgeInsets.only(top: 5),
                                color: Colors.white,
                                width: 160,
                                child: Center(child: Text('ตั้งค่า'))),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}
