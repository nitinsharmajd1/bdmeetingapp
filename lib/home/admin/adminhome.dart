import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/constant/app_color.dart';
import '../../utils/constant/appfont.dart';
import '../../utils/constant/widgets.dart';
import '../drawer/drawer.dart';
import 'bdlist.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({Key? key}) : super(key: key);

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  late SharedPreferences? sf;
  String username = '';
  void initState() {
    initial();
    super.initState();
  }
  initial() async {
    sf = await SharedPreferences.getInstance();
    setState(() {
      username = sf!.getString('username')??"";
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: HomeDrawer(),//SideDrawer(),
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
              Positioned(
                top: MediaQuery.of(context).size.height / 3.5,
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16.0),
                      child: Container(
                        margin: const EdgeInsets.all(3.0),
                        width: Widgets.isWeb()
                            ? MediaQuery.of(context).size.width/2
                        : MediaQuery.of(context).size.width - 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
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
                                  subtitle: Text("List of all schedule meetings",
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
                                            Bdlist(
                                              status : "Schedule",
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
                                            Bdlist(
                                              status : "Revival",
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
                                  subtitle: Text("List of all completed meetings",
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
                                            Bdlist(
                                                status : "Completed",
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
                                  leading: Widgets.surgeonApproval(),
                                  title: Text("Active Surgeon",
                                      style: Font.heading()),
                                  subtitle: Text("List of all Active Surgeons",
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
                                            Bdlist(
                                              status : "Active",
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
