import 'dart:convert';

import 'package:bdmeeting/startup/loginmodel.dart';
import 'package:http/http.dart' as http;

import '../utils/constant/app_url.dart';

Future<LoginModel> login({
  required String name, password,
}) async {
  Map<dynamic, dynamic> body = {
    'user_name' : name,
    'password' : password
  };

  http.Response response = await http.post(
    Uri.parse(AppUrl.login),
    body: body,
  );

  if (response.statusCode == 200) {
      return LoginModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load');
  }
}

Future<LoginModel> signup({
  required String name, password, mobile
}) async {
  Map<String, dynamic> body = {
    'username' : name,
    'password' : password,
    'phone' : mobile
  };

  http.Response response = await http.post(
    Uri.parse(AppUrl.register),
    body: body,
  );

  if (response.statusCode == 200) {
    return LoginModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load');
  }
}
