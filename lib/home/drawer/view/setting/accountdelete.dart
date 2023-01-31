import 'package:bdmeeting/utils/constant/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'deletion.dart';

class AccountDelete extends StatefulWidget {
  const AccountDelete({Key? key}) : super(key: key);

  @override
  State<AccountDelete> createState() => _AccountDeleteState();
}

class _AccountDeleteState extends State<AccountDelete> {
  @override
  var datalist = [
    'I don’t want to use BDMeeting app',
    'I have privacy concerns',
    'I have created a second account',
    'App is not working properly',
    'Others'
  ];
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Widgets.appBarWidget("Why would you like to delete\nyour account? "),
        body: MakeUi(datalist));
  }
}

Widget MakeUi(List<String> datalist) {
  return Padding(
    padding: const EdgeInsets.all(12.0),
    child: Container(
      child: ListView.builder(
        itemCount: datalist.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(datalist[index],
                    style: TextStyle(
                        fontSize: 16,
                        wordSpacing: 5,
                        color: Colors.black54)),
              ),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Deletion(title: datalist[index])));
            },
          );
        },
      ),
    ),
  );
}
