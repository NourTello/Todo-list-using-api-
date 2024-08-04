
class AppConst {
  static const String baseUrl = 'http://192.168.186.156:8000/api/';
 // static const String baseUrl = 'http://127.0.0.1:8000/api/';
  static String? token;
  static int versionNumber=1;

  static Map<String, String> httpHeaders() {
    return {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    };
  }

}
