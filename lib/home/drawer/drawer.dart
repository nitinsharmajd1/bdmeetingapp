import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:bdmeeting/home/drawer/view/aboutlist.dart';
import 'package:bdmeeting/home/drawer/view/helpandsupport.dart';
import 'package:bdmeeting/home/drawer/view/setting/settings.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import '../../startup/login.dart';
import '../../utils/constant/app_color.dart';
import '../../utils/constant/appfont.dart';
import 'model/profileImageUpdate.dart';

class HomeDrawer extends StatefulWidget {
  const HomeDrawer({Key? key}) : super(key: key);

  @override
  _HomeDrawerState createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  late SharedPreferences logindata;
  String accountName = "";
  String accountEmail = "";
  String userspecility = "Business Development Manager";
  String mobileNo= "";

  @override
  void initState() {
    initial();
    super.initState();
  }

  initial() async {
    logindata = await SharedPreferences.getInstance();
    setState(() {
      accountName = logindata.getString('username')!;
      //mobileNo = logindata.getString("mobile")!;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.transparent,
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [AppColor.grd2,AppColor.grd1]),
            ),
            accountName: Text(accountName, style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            )),
            accountEmail: Text(userspecility),
          ),
          ListTile(
            leading: Icon(Icons.quiz_outlined,
                color: Colors.black, size: 30),
            title: Text('About'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => AboutList()));
            },
          ),
          ListTile(
            leading: Icon(Icons.help_outline,
                color: Colors.black, size: 30
            ),
            title: const Text('Help and Support'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => HelpAndSupport()));
            },
          ),
          ListTile(
            leading: Icon(Icons.settings_applications,
                color: Colors.black, size: 30
            ),
            title: const Text('Settings'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => Settings()));
            },
          ),
          /*
          ListTile(
            leading: Icon(Icons.share_outlined, color: Colors.black, size: 30),
            title: const Text('Share'),
            onTap: () async{
              final box = context.findRenderObject() as RenderBox?;
              await Share.share("https://play.google.com/store/apps/details?id=com.carelan.carelanapp",
                  subject: "Carelan HealthCare Pvt. Ltd.",
                  sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size
              );
            },
          ),*/
          ListTile(
            leading: Icon(Icons.logout, color: Colors.black, size: 30),
            title: const Text('Logout'),
            onTap: () async {
              return showDialog<void>(
                context: context,
                barrierDismissible: false, // user must tap button!
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Are you sure?'),
                    content: SingleChildScrollView(
                      child: ListBody(
                        children: <Widget>[
                          Text('You want to Logout.'),
                        ],
                      ),
                    ),
                    actions: <Widget>[
                      FlatButton(
                        child: Text('No'),
                        onPressed: () {
                          Navigator.of(context).pop(); // Dismiss the Dialog
                        },
                      ),
                      FlatButton(
                        child: Text('Yes'),
                        onPressed: () async {
                          logindata.remove('username');
                          await Future.delayed(Duration(seconds: 1));
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (BuildContext context) => LoginPage()),
                            (Route route) => false,
                          );
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

}

class MyClip extends CustomClipper<Rect> {
  Rect getClip(Size size) {
    return Rect.fromCenter(height: 55, width: 55, center: Offset(27.0, 27.0));
  }

  bool shouldReclip(oldClipper) {
    return false;
  }
}
