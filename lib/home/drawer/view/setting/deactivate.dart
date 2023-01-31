import 'package:bdmeeting/utils/constant/app_color.dart';
import 'package:bdmeeting/utils/constant/appfont.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../startup/login.dart';
import '../../../../utils/constant/widgets.dart';

class Deactivate extends StatefulWidget {
  const Deactivate({Key? key}) : super(key: key);

  @override
  State<Deactivate> createState() => _DeactivateState();
}

class _DeactivateState extends State<Deactivate> {
  late SharedPreferences logindata;
  String accountName = "";
  void initState() {
    initial();
    super.initState();
  }
  initial() async {
    logindata = await SharedPreferences.getInstance();
    setState(() {
      accountName = logindata.getString('username')!;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Widgets.appBarWidget("Deactivation"),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text("If you want to temporarily deactivate your BDMeeting app account, "
                "your scheduled and completed meetings will be removed. However, you will be able to get back "
                "the meetings once your account is reactivated."
                " You can only deactivate your account from BDMeeting mobile app.",
            style: TextStyle(
              fontSize: 16,

            ),),
          ),
          ElevatedButton(onPressed: () async {
            logindata.remove('username');
            await Future.delayed(Duration(seconds: 1));
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (BuildContext context) => LoginPage()),
                  (Route route) => false,
            );
          },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(AppColor.clOrange),
              ),
              child: SizedBox(
              width: 200,
              child: Center(child: Text("Deactivate Account",
              style: TextStyle(
                fontSize: 18
              ),)))),
          SizedBox(height: 20,),
          ElevatedButton(onPressed: (){
            Navigator.pop(context);
          },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(AppColor.appbgColor),
              ),
              child: SizedBox(
                  width: 200,
                  child: Center(child: Text("Go Back",
                    style: TextStyle(
                        fontSize: 18,
                      color: Colors.black38
                    ),))))

        ],
      ),
    );
  }
}
