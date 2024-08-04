import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tasks_list/core/consts/app_const.dart';
import 'package:tasks_list/core/network/remote/end_points.dart';

class SettingsRepo {
  Future logout() async {
    var request = await http.post(Uri.parse(AppConst.baseUrl + logoutUrl),
        headers: AppConst.httpHeaders());
    if (request.statusCode == 201) return true;
    return false;
  }
}
