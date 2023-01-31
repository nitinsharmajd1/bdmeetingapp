import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../utils/constant/app_url.dart';
import 'meetingModel.dart';

Future<AddMeetingModel> addMeeting({
  required String addedby, name, mobile, time, date, address, type,
}) async {
  Map<dynamic, dynamic> body = {
  "addedkey" : addedby,
  "surgeonkey" : name,
  "phonekey" : mobile,
  "date" : date,
  "time" : time,
  "catagorykey" : type,
  "categoryFlag" : "true",
  "addresskey" : address
  };

  http.Response response = await http.post(
    Uri.parse(AppUrl.addNewMeeting),
    body: body,
  );

  if (response.statusCode == 200) {
    return AddMeetingModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load');
  }
}

Future<AddMeetingModel> getMeetingData({
  required String name, mobile, time, date, type,
}) async {
  Map<dynamic, dynamic> body = {
    "addedkey" : "Rahul",
    "surgeonkey" : name,
    "phonekey" : mobile,
    "date" : date,
    "time" : time,
    "catagorykey" : type,
    "categoryFlag" : "true",
    "addresskey" : "address"
  };

  http.Response response = await http.post(
    Uri.parse(AppUrl.addNewMeeting),
    body: body,
  );

  if (response.statusCode == 200) {
    return AddMeetingModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load');
  }
}

Future<AddMeetingModel> updateMeeting({
  required String id, addedkey, name, mobile, time, date, address, caregory, remark,intrested, mou, imageString, liveLocation,
}) async {
  Map<dynamic, dynamic> body = {
    "sid" : id,
    "sadded_by" : addedkey,
    "ssurgeon_name" : name,
    "sphone_no" : mobile,
    "sdate" : date,
    "stime" : time,
    "ssurgeon_catagory" : caregory,
    "categoryFlag" : "true",
    "sinterested" : intrested,
    "smou" : mou,
    "sclinic_image" : imageString,
    "sremarks" : remark,
    "slocation" : liveLocation,
    "saddress" : address,
    "from" : "OPEN"
  };

  http.Response response = await http.post(
    Uri.parse(AppUrl.updateMeeting),
    body: body,
  );

  if (response.statusCode == 200) {
    return AddMeetingModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load');
  }
}
