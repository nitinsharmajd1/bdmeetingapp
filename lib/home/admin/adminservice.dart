// updateRevival
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:bdmeeting/home/admin/revivalUpdatemodel.dart';
import '../../utils/constant/app_url.dart';
import 'activeupdatemodal.dart';

Future<RevivalUpdateModel> updateRevival({
  required String id, revivalCount,
}) async {
  Map<dynamic, dynamic> body = {
    "id" : id,
    "isRevival" : "N",
    "revivalCount" : revivalCount,
    "from" : "ADMIN"
  };

  http.Response response = await http.post(
    Uri.parse(AppUrl.revivalUpdate),
    body: body,
  );

  if (response.statusCode == 200) {
    return RevivalUpdateModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load');
  }
}

Future<ActiveModel> activateSurgeon({
  required String id,
}) async {
  Map<dynamic, dynamic> body = {
    "id" : id,
  };

  http.Response response = await http.post(
    Uri.parse(AppUrl.updateActive),
    body: body,
  );

  if (response.statusCode == 200) {
    return ActiveModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load');
  }
}