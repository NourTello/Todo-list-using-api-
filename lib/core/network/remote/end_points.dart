import '../../consts/app_const.dart';

const String loginUrl = "user/login";
const String registerUrl = "user/register";
const String logoutUrl = "user/logout";

// const String getTaskUrl="v1/tasks";
// const String addTaskUrl="v1/tasks";
// const String completeTaskUrl="v1/tasks/1/toggle-complete";
String completeTaskUrl(int id) =>
    "v${AppConst.versionNumber}/tasks/$id/toggle-complete";
String tasksUrl = "v${AppConst.versionNumber}/tasks?page=";
String taskUrl(int id) => "v${AppConst.versionNumber}/tasks/$id";
String filterTasksUrl(
        {required String title,
        required String description,
        required String longDescription,
        required String dateOp,
        required String date}) =>
    "v${AppConst.versionNumber}/tasks?title[like]=$title&description[like]=$description&longDescription[like]=$longDescription&completedAt[$dateOp]=$date";
