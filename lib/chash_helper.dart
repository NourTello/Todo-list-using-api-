import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasks_list/core/consts/app_const.dart';
import 'package:tasks_list/features/settings/domain/bloc/settings_cubit.dart';

class CashHelper {
  static late SharedPreferences sharedPreferences;
  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if (checkExistence(key:'token'))AppConst.token=getStringData(key: 'token');
    if (checkExistence(key:'dark_mode'))SettingsCubit.darkMode=getBooleanData(key: 'dark_mode');
    if (checkExistence(key:'english'))SettingsCubit.english=getBooleanData(key: 'english');

  }

  static Future<bool> putStringData(
      {required String key, required String value}) async {
    return await sharedPreferences.setString(key, value);
  }

  static Future<bool> putBooleanData(
      {required String key, required bool value}) async {
    return await sharedPreferences.setBool(key, value);
  }

  static String getStringData({required String key}) {
    return sharedPreferences.getString(key)!;
  }
  static bool getBooleanData({required String key}) {
    return sharedPreferences.getBool(key)!;
  }

  static bool checkExistence ({required String key})=>sharedPreferences.containsKey(key);

  static void removeData({required String key})async=>await sharedPreferences.remove(key);

}
