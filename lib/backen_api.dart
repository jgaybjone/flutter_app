import 'dart:convert';

import 'package:http/http.dart' as http;

class BackendApi {
  static final isProd = const bool.fromEnvironment('dart.vm.product');

  static final baseUrl = isProd
      ? "https://api.chenhuimed.com/app"
      : "https://api.chenhuimed.com/app";

  static final authCodeUrl = baseUrl + "/authcode";
  static final patientLoginUrl = baseUrl + "/patientlogin";

  BackendApi() {
    print("Prod ? : $isProd, base url is $baseUrl");
  }

  static responseBodyHandler(
      http.Response response, Function successHandler, Function errorHandler) {
    var body = jsonDecode(response.body);
    if (body["error"] == 0) {
      successHandler(body);
    } else {
      errorHandler(body);
    }
  }

  // 获取手机验证码
  static getAuthCode(String phone, int type, Function successHandler,
      Function errorHandler) async {
    var resp = await http.get(authCodeUrl + "?type=$type&sign= &phone=$phone");
    responseBodyHandler(resp, successHandler, errorHandler);
  }

  //手机号码登录
  static patientLogin(String phone, String pwd, Function successHandler,
      Function errorHandler) async {
    var resp = await http.post(patientLoginUrl,
        headers: {"content-type": "application/x-www-form-urlencoded"},
        body: {"phone": phone, "pwd": pwd, "userid": ""});
    responseBodyHandler(resp, successHandler, errorHandler);
  }
}
