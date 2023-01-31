import 'package:bdmeeting/utils/constant/app_color.dart';
import 'package:bdmeeting/utils/constant/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'accountdelete.dart';
import 'deactivate.dart';


class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Widgets.appBarWidget("Settings"),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("User Account Settings",
              style: TextStyle(
                fontSize: 18,
                color: AppColor.primaryColor,
                fontWeight: FontWeight.bold
              )),
            ),
            ListTile(
              leading: Icon(Icons.not_interested),
              title: Text("Deactivate Account"),
              subtitle: Text("Your account will be deactivated"),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => Deactivate()));
              },
            ),
            ListTile(
              leading: Icon(Icons.no_accounts_sharp),
              title: Text("Delete Account"),
              subtitle: Text("Your account will be deleted permanently"),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => AccountDelete()));
                },
            )
          ],
        ),
      ),
    );
  }
}
