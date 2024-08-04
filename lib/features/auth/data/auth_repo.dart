import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tasks_list/core/network/remote/end_points.dart';
import 'package:tasks_list/features/auth/domain/models/login_model.dart';
import 'package:tasks_list/features/auth/domain/models/register_model.dart';

import '../../../core/consts/app_const.dart';

class AuthRepo {
  Future<LoginModel> login(
      {required String email, required String password}) async {
    print(email);
    print(password);

    http.Response response =
    await http.post(Uri.parse(AppConst.baseUrl+loginUrl), headers: <String, String>{
      'Accept': 'application/json',
    }, body: {
      "email": email,
      "password": password
    });
    print("state code: ${response.statusCode}");
    print(response.body);
    return LoginModel.fromJson(jsonDecode(response.body));

    // if (response.statusCode == 200) {
    //   log(response.body);
    //   return LoginModel.fromJson(jsonDecode(response.body));
    // } else
    //   throw Exception(response.body);
  }

  Future< RegisterModel>register({required String emailAddress, required String password,required String name,required String passwordConfirmation}) async {
    http.Response request = await http.post(
      Uri.parse(AppConst.baseUrl + registerUrl),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(
          <String, String>{'email': emailAddress, 'password': password,'name':name,'password_confirmation':passwordConfirmation}),
    );
    print(request.body);
    if (request.statusCode == 201)
      return RegisterModel.fromJson(jsonDecode(request.body));
    else
      {
        print (RegisterModel.fromJson(jsonDecode(request.body)).message);
        throw Exception(RegisterModel.fromJson(jsonDecode(request.body)));
      }
    //throw Exception(request.body);

  }


}
