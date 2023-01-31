import 'dart:io';
import 'package:bdmeeting/home/user/addNewMeeting.dart';
import 'package:bdmeeting/home/user/testpage.dart';
import 'package:flutter/foundation.dart';
import 'package:bdmeeting/home/drawer/drawer.dart';
import 'package:bdmeeting/home/user/revival.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/constant/app_color.dart';
import '../../utils/constant/appfont.dart';
import '../../utils/constant/widgets.dart';
import 'completedList.dart';
import 'meetingList.dart';

class UserHome extends StatefulWidget {
  const UserHome({Key? key}) : super(key: key);

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  late SharedPreferences? sf;
  String username = '';
  bool isWeb = false;
  void initState() {
    initial();
    super.initState();
  }
  initial() async {
    sf = await SharedPreferences.getInstance();
    setState(() {
      username = sf!.getString('username')??"";
      if(defaultTargetPlatform == TargetPlatform.macOS || defaultTargetPlatform == TargetPlatform.windows){
        isWeb = true;
      }

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: username == ""? null : HomeDrawer(),//SideDrawer(),
      appBar :AppBar(
        backgroundColor: AppColor.appbgColor,
          elevation: 0,
        ),
        body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          child: Stack(
            alignment: AlignmentDirectional.topCenter,
            children: [
              Positioned(
                //top:  0,
                child: ClipPath(
                  child: Container(
                    height: MediaQuery.of(context).size.height / 2,
                    color: AppColor.appbgColor,
                  ),
                  clipper: CustomClipPath(),
                ),
              ),
              Positioned(top: 50, child: Widgets.applogo()),
              Positioned(top: 150, left: isWeb ? 100 : 20, child: Text(
                  Widgets.greeting()+"\n"+(username==""?"User":username),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
              )),
              Positioned(
                top: MediaQuery.of(context).size.height / 2 - 150,
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16.0),
                      child: Container(
                        margin: const EdgeInsets.all(3.0),
                        width:  isWeb
                            ? MediaQuery.of(context).size.width/2
                        : MediaQuery.of(context).size.width - 50,
                        decoration: BoxDecoration(
                            color: Colors.white,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              child: Container(
                                width: MediaQuery.of(context).size.width - 50,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow: [BoxShadow(blurRadius: 1,color: Colors.grey,offset: Offset(1,1))]
                                ),
                                child: ListTile(
                                  leading: Widgets.newMeetings(),
                                  title: Text("Add New Meetings",
                                      style: Font.heading()
                                       ),
                                  subtitle: Text("Make your own lead with surgeon.",
                                      style: Font.normal14()),
                                  trailing: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      foregroundColor: Colors.black,
                                      child: Icon(Icons.arrow_forward)),
                                ),
                              ),
                              onTap: (){
                                Navigator.pushNamed(context, '/addNewMeeting');
                              },
                            ),
                            SizedBox(height: 20),
                            InkWell(
                              child: Container(
                                width: MediaQuery.of(context).size.width - 50,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow: [BoxShadow(blurRadius: 1,color: Colors.grey,offset: Offset(1,1))]
                                ),
                                child: ListTile(
                                  leading: Widgets.schduleMeetings(),
                                  title: Text("Schedule Meetings",
                                      style: Font.heading()),
                                  subtitle: Text("List of scheduled meetings",
                                      style: Font.normal14()),
                                  trailing: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      foregroundColor: Colors.black,
                                      child: Icon(Icons.arrow_forward)),
                                ),
                              ),
                              onTap: (){
                                Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            MeetingList(
                                                from : "USER",
                                                fieldworker :username
                                            )));
                              },
                            ),
                            SizedBox(height: 20),
                            InkWell(
                              child: Container(
                                width: MediaQuery.of(context).size.width - 50,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow: [BoxShadow(blurRadius: 1,color: Colors.grey,offset: Offset(1,1))]
                                ),
                                child: ListTile(
                                  leading: Widgets.reviewM(),
                                  title: Text("Revival Meetings",
                                      style: Font.heading()),
                                  subtitle: Text("Tap again to surgeon",
                                      style: Font.normal14()),
                                  trailing: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      foregroundColor: Colors.black,
                                      child: Icon(Icons.arrow_forward)),
                                ),
                              ),
                              onTap: (){
                                Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            RevivalList(
                                                from : "USER",
                                                fieldworker :username
                                            )));
                                },
                            ),
                            SizedBox(height: 20),
                            InkWell(
                              child: Container(
                                width: MediaQuery.of(context).size.width - 50,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow: [BoxShadow(blurRadius: 1,color: Colors.grey,offset: Offset(1,1))]
                                ),
                                child: ListTile(
                                  leading: Widgets.completedMeeting(),
                                  title: Text("Complete Meetings",
                                      style: Font.heading()),
                                  subtitle: Text("List of completed meetings",
                                      style: Font.normal14()),
                                  trailing: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      foregroundColor: Colors.black,
                                      child: Icon(Icons.arrow_forward)),
                                ),
                              ),
                              onTap: (){
                                Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            CompletedList(
                                                from : "USER",
                                                fieldworker :username
                                            )));
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
