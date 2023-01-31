import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../startup/login.dart';
import '../../../../utils/constant/app_color.dart';
import '../../../../utils/constant/widgets.dart';

class FinalDeletion extends StatefulWidget {
  const FinalDeletion({Key? key}) : super(key: key);

  @override
  State<FinalDeletion> createState() => _FinalDeletionState();
}

class _FinalDeletionState extends State<FinalDeletion> {
  late SharedPreferences logindata;
  void initState() {
    initial();
    super.initState();
  }
  initial() async {
    logindata = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Widgets.appBarWidget(" Account Deletion"),
      body : Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10,),
                Text("You are about to delete your account",
                    style: TextStyle(
                        fontSize: 18,
                        color: AppColor.primaryColor,
                        fontWeight: FontWeight.bold
                    )),

                SizedBox(height: 15,),
                Text("All the data associated with it (including  your profile,"
                    " new meetings, schduled meetings, completed meetings) will be"
                    " permanently deleted within 7 days. This infomation"
                    " cannot be recovered once the account is deleted.",
                style: TextStyle(
                  fontSize: 16,
                  wordSpacing: 3
                ),
                ),
                SizedBox(height: 10,),
              ],
            ),
          ),
          SizedBox(height: 10),
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
                backgroundColor: MaterialStateProperty.all(Colors.red),
              ),
              child: SizedBox(
                  width: MediaQuery.of(context).size.width - 150,
                  child: Center(child: Text("Delete my account now",
                    style: TextStyle(
                        fontSize: 18
                    ),)))),
          SizedBox(height: 40,),
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
      )
    );
  }
}
