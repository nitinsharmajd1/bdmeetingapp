import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:bdmeeting/home/admin/adminhome.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/constant/app_color.dart';
import '../../utils/constant/app_url.dart';
import '../../utils/constant/appfont.dart';
import '../../utils/constant/widgets.dart';
import '../admin/activeupdatemodal.dart';
import '../admin/adminservice.dart';
import '../admin/revivalUpdatemodel.dart';
import 'meetingModel.dart';

class CompletedList extends StatefulWidget {
  const CompletedList({Key? key, required this.from, required this.fieldworker}) : super(key: key);
final String from;
final String fieldworker;
  @override
  State<CompletedList> createState() => _CompletedListState();
}

class _CompletedListState extends State<CompletedList> {
  @override
  StreamController<CompletedMeetingModel> _mlcontroller = StreamController();
  bool isLoading = true;
  late SharedPreferences? sf;
  String username = '';
  TextEditingController txtQuery = TextEditingController();
  List<Datalist1> dataList = [];
  List<Datalist1> orignalList = [];

  void search(String query) {
    if(query.isEmpty) {
      dataList = orignalList;
      setState(() {});
      return;
    }
    query = query.toLowerCase();
    //  22 nov start............
    List<Datalist1> result = [];
    for (var p in dataList) {
      var name = p.surgeonName.toString().toLowerCase();
      if(name.contains(query)){
        result.add(p);
      }
    }
    dataList = result;
    setState(() {});
  }

  initState() {
    getMeetingList();
    super.initState();
  }
  void dispose() {
    _mlcontroller.close();
    super.dispose();
  }

  Future<void> getMeetingList() async {
    try {
    String url = AppUrl.getCompletedMeeting;
    Map<String, String> body = {
      'sadded': widget.fieldworker,
      'status' : 'Completed'
    };
    http.Response response = await http.post(
      Uri.parse(url),
      body: body,
    );
    final databody = json.decode(response.body);
    CompletedMeetingModel dataModel = CompletedMeetingModel.fromJson(databody);
    //return _mlcontroller.sink.add(dataModel);
    dataList = dataModel.datalist ?? [];
    orignalList = dataModel.datalist ?? [];

    isLoading = false;
    setState(() {});
    } catch(e) {
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Widgets.appBarWidget(widget.fieldworker),
      body: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildSearch(),
            Expanded(
              child: isLoading
                  ? const Center(
                  child: CircularProgressIndicator(
                    color: AppColor.primaryColor,
                  ))
                  : MeetingListUI(),
            ),
          ]),
     /* Center(
        child: Container(
          width: Widgets.isWeb()
            ? MediaQuery.of(context).size.width/2
            : MediaQuery.of(context).size.width,
            child: MeetingListUI()),
      ),*/
    );
  }
  Widget buildSearch() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: txtQuery,
        onChanged: search,
        decoration: InputDecoration(
          hintText: "Surgeon name",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
        ),
      ),
    );
  }
  Widget MeetingListUI() {
    /*return StreamBuilder<CompletedMeetingModel>(
        stream: _mlcontroller.stream,
        builder: (context, snapshot) {
          int? count = snapshot.data?.datalist?.length;
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else {
            CompletedMeetingModel datalist = snapshot.data!;
            if(datalist.datalist != null){*/
                return ListView.builder(
        itemCount: dataList.length,
        itemBuilder: (BuildContext context, int index) {
          int cntInd = dataList.length - (index + 1);
          // var data = datalist.datalist
          //     ?.map((e) => e.toJson())
          //     .toList()[cntInd];
          Datalist1 data = dataList[cntInd];
          String mou = data.mou??"";//data["mou"]??"";
          String add = data.address??"";//data["address"]??"";
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
                                    data.surgeonName??"",//data["surgeon_name"]??"",
                                    style: Font.font600B17blue()
                                ),
                                Text(
                                    data.surgeonCatagory??"",//["surgeon_catagory"]??"",
                                    style: Font.font500M12Black()
                                ),
                                Text(
                                    data.phoneNo??"",
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
                                    data.date??"",
                                    style: Font.font600B11()
                                ),
                                Text(
                                    data.time??"",
                                    style: Font.font400R9gray()
                                ),
                                SizedBox(height: 15,),
                                Text(
                                    data.status??"",
                                    style: TextStyle(
                                        color: AppColor.clGreen
                                    )
                                ),
                                Text(
                                    data.revivalCount??"",
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
                          "Address: "+(data.address??""),
                          style: Font.font500M12()
                      ),
                      SizedBox(height: 5),
                      Text(
                          "Remark:-"+(data.remarks??""),
                          style: Font.font500M12()
                      ),
                      Divider(),
                      Text(
                          "Live Location:-"+(data.location??""),
                          style: Font.font500M12()
                      ),
                      //Image.network(data.clinicimage??""),
                      SizedBox(height: 10,),

                      widget.from == "ADMIN" ?  Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            onPressed: (){
                              activateSurgeon(
                                id : data.id??"",
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
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                      content: Text(
                                        meetingResponce.message ?? "",
                                      )));
                                }
                              });
                            }, child: Text("Active"),
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(Colors.green)
                            ),
                          ),
                          ElevatedButton(
                              onPressed: (){
                                int rcount = int.parse(data.revivalCount??"") + 1;
                                updateRevival(
                                    id : data.id??"",
                                    revivalCount : rcount.toString()
                                ).then((value) {
                                  RevivalUpdateModel meetingResponce = value;
                                  if (meetingResponce.status == 1) {
                                    setState(() {
                                      isLoading = false;
                                    });
                                    Future.delayed(Duration(seconds: 10));
                                    // build(context);
                                    initState();
                                    // Navigator.of(context).pushAndRemoveUntil(
                                    //   MaterialPageRoute(
                                    //       builder: (BuildContext context) => AdminHome()),
                                    //       (Route route) => false,
                                    // );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                        content: Text(
                                          meetingResponce.message ?? "",
                                        )));
                                  } else {
                                    setState(() {
                                      isLoading = false;
                                    });
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
                      SizedBox()
                    ],
                  ),
                ),
              ),
            ),
          );
        });
           /* } else {
              return Center(child: Text("No Record Found"));
            }
          }
        });*/
  }
}
