import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/constant/app_color.dart';
import '../../utils/constant/app_url.dart';
import '../../utils/constant/appfont.dart';
import '../../utils/constant/widgets.dart';
import 'ActiveSurgeonModel.dart';
import 'package:http/http.dart' as http;

class ActiveSurgeon extends StatefulWidget {
  const ActiveSurgeon({Key? key, required this.from, required this.fieldworker}) : super(key: key);
final String from;
final String fieldworker;
  @override
  State<ActiveSurgeon> createState() => _ActiveSurgeonState();
}

class _ActiveSurgeonState extends State<ActiveSurgeon> {
  @override
  StreamController<ActiveSurgeonModel> _mlcontroller = StreamController();
  bool isLoading = false;
  late SharedPreferences? sf;
  String username = '';

  initState() {
    getMeetingList();
    super.initState();
  }
  void dispose() {
    _mlcontroller.close();
    super.dispose();
  }

  Future<void> getMeetingList() async {
    String url = AppUrl.activeSurgeonList;
    Map<String, String> body = {
      'addedby': widget.fieldworker,
    };
    http.Response response = await http.post(
      Uri.parse(url),
      body: body,
    );
    final databody = json.decode(response.body);
    ActiveSurgeonModel dataModel = ActiveSurgeonModel.fromJson(databody);
    return _mlcontroller.sink.add(dataModel);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Widgets.appBarWidget(widget.fieldworker),
      body: MeetingListUI(),
    );
  }
  Widget MeetingListUI() {
    return StreamBuilder<ActiveSurgeonModel>(
        stream: _mlcontroller.stream,
        builder: (context, snapshot) {
          int? count = snapshot.data?.datalist?.length;
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else {
            ActiveSurgeonModel datalist = snapshot.data!;
            if(datalist.datalist != null){
              return ListView.builder(
                  itemCount: count,
                  itemBuilder: (BuildContext context, int index) {
                    int cntInd = count! - (index+1);
                    var data = datalist.datalist
                        ?.map((e) => e.toJson())
                        .toList()[cntInd];
                    String mou = data!["mou"]??"";
                    String add = data["address"]??"";
                    return isLoading ?
                    BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 0.5,sigmaY: 0.5),
                      child: Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: CircleAvatar(
                            minRadius: 10,
                            backgroundColor: Colors.transparent,
                            child: CircularProgressIndicator()
                        ),
                      ),
                    )
                        :
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        child: Container(
                          // height: 60,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              border: Border.all(color: AppColor.clGray)),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              data["surgeon_name"]??"",
                                              style: Font.font600B17blue()
                                          ),
                                          Text(
                                              data["surgeon_catagory"]??"",
                                              style: Font.font500M12Black()
                                          ),
                                          Text(
                                              data["phone_no"]??"",
                                              style: Font.font400R9gray()
                                          ),
                                          SizedBox(height: 10),
                                          Text(
                                              "MOU:-$mou"+"%",
                                              style: Font.heading()
                                          ),
                                          SizedBox(height: 10,),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                              "Date and Time",
                                              style: Font.font500M12Black()
                                          ),
                                          Text(
                                              data["date"]??"",
                                              style: Font.font600B11()
                                          ),
                                          Text(
                                              data["time"]??"",
                                              style: Font.font400R9gray()
                                          ),
                                          SizedBox(height: 15,),
                                          Text(
                                              data["status"]??"",
                                              style: TextStyle(
                                                  color: AppColor.clGreen
                                              )
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                    "Address: "+(data["address"]??""),
                                    style: Font.font500M12()
                                ),
                                SizedBox(height: 5),
                                Text(
                                    "Remark:-"+(data["remarks"]??""),
                                    style: Font.font500M12()
                                ),
                                Divider(),
                                Text(
                                    "Live Location:-"+(data["location"]??""),
                                    style: Font.font500M12()
                                ),
                                SizedBox(height: 10,),
                                /*
                                widget.from == "ADMIN" ?  Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    ElevatedButton(
                                        onPressed: (){
                                          activateSurgeon(
                                            id : data["id"],
                                          ).then((value) {
                                            ActiveModel meetingResponce = value as ActiveModel;
                                            if (meetingResponce.status == 1) {
                                              setState(() {
                                                isLoading = false;
                                              });
                                              Future.delayed(Duration(seconds: 10));
                                              Navigator.of(context).pushAndRemoveUntil(
                                                MaterialPageRoute(
                                                    builder: (BuildContext context) => AdminHome()),
                                                    (Route route) => false,
                                              );

                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                  content: Text(
                                                    meetingResponce.message ?? "",
                                                  )));
                                            } else {
                                              setState(() {
                                                isLoading = false;
                                              });
                                              print(meetingResponce.message);
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                  content: Text(
                                                    meetingResponce.message ?? "",
                                                  )));
                                            }

                                          });
                                        }, child: Text("Active")),
                                    ElevatedButton(
                                        onPressed: (){
                                          int rcount = int.parse(data["revivalCount"]) + 1;
                                          updateRevival(
                                              id : data["id"],
                                              revivalCount : rcount.toString()
                                          ).then((value) {
                                            RevivalUpdateModel meetingResponce = value;
                                            if (meetingResponce.status == 1) {
                                              setState(() {
                                                isLoading = false;
                                              });
                                              Future.delayed(Duration(seconds: 10));
                                              Navigator.of(context).pushAndRemoveUntil(
                                                MaterialPageRoute(
                                                    builder: (BuildContext context) => AdminHome()),
                                                    (Route route) => false,
                                              );

                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                  content: Text(
                                                    meetingResponce.message ?? "",
                                                  )));
                                            } else {
                                              setState(() {
                                                isLoading = false;
                                              });
                                              print(meetingResponce.message);
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                  content: Text(
                                                    meetingResponce.message ?? "",
                                                  )));
                                            }
                                          });
                                        }, child: Text("Revival")),
                                  ],
                                )
                                    :
                                SizedBox()*/
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  });
            } else {
              return Center(child: Text("No Record Found"));
            }
          }
        });
  }
}
