import 'dart:convert';
import 'dart:core';

import 'package:http/http.dart' as http;
import 'package:tasks_list/core/consts/app_const.dart';
import 'package:tasks_list/core/network/remote/end_points.dart';
import 'package:tasks_list/features/tasks/domain/model/tasks_model.dart';

class TasksRepo {
  Future<bool> addTask(
      {required String title,
      required String description,
      required String longDescription}) async {
    var request = await http.post(Uri.parse(AppConst.baseUrl + tasksUrl),
        headers: AppConst.httpHeaders(),
        body: (<String, String>{
          'title': title,
          'description': description,
          'longDescription': longDescription
        }));
    if (request.statusCode == 201) return true;
    print(request.body);
    return false;
  }

  Future<TasksModel> getTasks({required int pageNumber}) async {
    var request = await http.get(
        Uri.parse(AppConst.baseUrl + tasksUrl + pageNumber.toString()),
        headers: AppConst.httpHeaders());
    print(request.body);
    var response = TasksModel.fromJson(jsonDecode(request.body));
    if (request.statusCode == 200) response.success = true;

    return response;
  }

  Future<bool> completeTask(int id) async {
    var request = await http.put(
        Uri.parse(AppConst.baseUrl + completeTaskUrl(id)),
        headers: AppConst.httpHeaders());
    if (request.statusCode == 200) return true;
    return false;
  }

  Future<bool> editTask(
      {required int id,
      required String title,
      required String description,
      required String longDescription}) async {
    var request = await http.put(Uri.parse(AppConst.baseUrl + taskUrl(id)),
        headers: AppConst.httpHeaders(),
        body: (<String, String>{
          'title': title,
          'description': description,
          'longDescription': longDescription
        }));
    print(request.body);
    if (request.statusCode == 200) return true;
    return false;
  }

  Future<bool> deleteTask(int id) async {
    var request = await http.delete(Uri.parse(AppConst.baseUrl + taskUrl(id)),
        headers: AppConst.httpHeaders());
    if (request.statusCode == 200) {
      return true;
    }
    return false;
  }

  Future<TasksModel> getFilteredTasks(
      {required String title,
      required String description,
      required String longDescription,
      required String dateOp,
      required String date}) async {
    var request = await http.get(
        Uri.parse(AppConst.baseUrl + filterTasksUrl(title: title, description: description, longDescription: longDescription, dateOp: dateOp, date: date)),
        headers: AppConst.httpHeaders());
    print(request.body);
    print(request.statusCode);

    var response = TasksModel.fromJson(jsonDecode(request.body));
    print(response);
    if (request.statusCode == 200) response.success = true;

    return response;
  }
}
