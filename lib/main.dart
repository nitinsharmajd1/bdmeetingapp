import 'dart:async';
import 'package:bdmeeting/startup/login.dart';
import 'package:bdmeeting/startup/signup.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home/admin/adminhome.dart';
import 'home/admin/bdlist.dart';
import 'home/user/addNewMeeting.dart';
import 'home/user/completedList.dart';
import 'home/user/meetingList.dart';
import 'home/user/userhome.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BDMeeting',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      debugShowCheckedModeBanner: false,
      //home: username != "" ? (username == "Admin" ? AdminHome() : UserHome()) : LoginPage(),
      home : username == "Admin" ? AdminHome() : UserHome(),
      routes: {
        '/home' : (context) => const UserHome(),
        '/addNewMeeting' : (context) => const AddNewMeeting(),
        //'/meetinglist' : (context) => const MeetingList(),
        //'/completedMeetingList' : (context) => const CompletedList(),
        '/register' : (context) => const Register(),
        '/adminhome' : (context) => const AdminHome(),
        //'/bdlist' : (context) => const Bdlist()
      },
    );
  }
}