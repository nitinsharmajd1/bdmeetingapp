import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../utils/constant/app_color.dart';
import '../../../../utils/constant/widgets.dart';
import 'finaldeletion.dart';

class Deletion extends StatefulWidget {
  const Deletion({Key? key, required this.title}) : super(key: key);
final String title;
  @override
  State<Deletion> createState() => _DeletionState();
}

class _DeletionState extends State<Deletion> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Widgets.appBarWidget("Delete Account"),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(widget.title,
                      style: TextStyle(
                          fontSize: 18,
                          color: AppColor.primaryColor,
                          fontWeight: FontWeight.bold
                      )),
                ),
                SizedBox(height: 10,),
                Text("We're sorry that you're leaving. We'd like to know why you're"
                    " deleting your account so we might be able to fix some common"
                    " issues. You can continue deleting your account.",
                  style: TextStyle(
                      fontSize: 16,
                      wordSpacing: 3
                  ),
                ),
                SizedBox(height: 10,),
                TextField(
                  maxLines: 3,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Do you any feedback for us?"
                  ),
                ),
                SizedBox(height: 20,),

              ],
            ),
            ElevatedButton(onPressed: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FinalDeletion()));
            },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(AppColor.clOrange),
                ),
                child: SizedBox(
                    width: MediaQuery.of(context).size.width - 150,
                    child: Center(child: Text("Continue deleting account",
                      style: TextStyle(
                          fontSize: 16
                      ))))),
          ],
        ),
      ),
    );
  }
}

Widget DeleteAccoutNow(){
  return MaterialApp(
   title:  "We are about to delete your account"
  );
}