import 'dart:async';
import 'dart:convert';

import 'package:bdmeeting/home/admin/bdmlistmodel.dart';
import 'package:bdmeeting/home/user/completedList.dart';
import 'package:bdmeeting/utils/constant/widgets.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../utils/constant/app_color.dart';
import '../../utils/constant/app_url.dart';
import '../../utils/constant/appfont.dart';
import '../user/meetingList.dart';
import '../user/revival.dart';
import 'activeSurgeon.dart';

class Bdlist extends StatefulWidget {
  const Bdlist({Key? key, required  this.status}) : super(key: key);
  final String status;
  @override
  State<Bdlist> createState() => _BdlistState();
}

class _BdlistState extends State<Bdlist> {

  final StreamController<BDMListModel> _bdlistctrl = StreamController();

  initState() {
    getMeetingList();
    super.initState();
  }

  void dispose() {
    _bdlistctrl.close();
    super.dispose();
  }

  Future<void> getMeetingList() async {
    String url = AppUrl.getFieldWorkerList;
    Map<String, String> body = {
    };
    http.Response response = await http.post(
      Uri.parse(url),
      body: body,
    );
    final databody = json.decode(response.body);
    BDMListModel dataModel = BDMListModel.fromJson(databody);
    return _bdlistctrl.sink.add(dataModel);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Widgets.appBarWidget("BD Team"),
      body: StreamBuilder<BDMListModel>(
        stream: _bdlistctrl.stream,
        builder: (context, snapshot) {
          int? count = snapshot.data?.datalist?.length;
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else {
            BDMListModel datalist = snapshot.data!;
            if(datalist.datalist != null) {
              return ListView.builder(
                  itemCount: count,
                  itemBuilder: (BuildContext context, int index) {
                    var data = datalist.datalist
                        ?.map((e) => e.toJson())
                        .toList()[index];
                    if(data!["status"] == "1"){
                    return Padding(
                      padding: Widgets.isWeb()
                        ? const EdgeInsets.only(left: 100, right: 100, top : 20)
                      : const EdgeInsets.all(8.0),
                      child: InkWell(
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              border: Border.all(color: AppColor.clGray)
                          ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(data["username"],
                                style: Font.font600B17blue()),
                              )),
                        onTap: (){
                          if(widget.status == "Revival"){

                            Navigator.of(context).push(
                                MaterialPageRoute(
                                     builder: (context) =>
                                        RevivalList(
                                            from : "ADMIN",
                                            fieldworker :data["username"]
                                        )));
                          } else if(widget.status == "Active") {
                            Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ActiveSurgeon(
                                            from : "ADMIN",
                                            fieldworker :data["username"],
                                        )));
                          } else if(widget.status == "Completed"){
                            Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        CompletedList(
                                            from : "ADMIN",
                                            fieldworker :data["username"]
                                        )));
                          } else {
                            Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        MeetingList(
                                            from : "ADMIN",
                                            fieldworker :data["username"]
                                        )));
                          }

                        },
                      ),
                    );
                    } else {
                       return SizedBox();
                    }
                  }
              );
            } else {
              return Center(child: Text("No Record Found"));
            }
          }
        }
      ),
    );
  }
}
