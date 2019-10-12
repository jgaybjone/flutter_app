import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_app/main.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class BackendApi {
  static final isProd = const bool.fromEnvironment('dart.vm.product');

  static final baseUrl = isProd
      ? "https://api.chenhuimed.com/app"
      : "https://api.chenhuimed.com/app";

  static final authCodeUrl = baseUrl + "/authcode";
  static final patientLoginUrl = baseUrl + "/patientlogin";
  static final basicUrl = baseUrl + "/basic";

  BackendApi() {
    print("Prod ? : $isProd, base url is $baseUrl");
  }

  static Map<String, String> baseHeaders() {
    var headers = Map<String, String>();
    headers["content-type"] = "application/x-www-form-urlencoded";
    var props = SharedPreferences.getInstance();
    props.then((p) {
      var token = p.getString("token");
      if (token != null) {
        headers["token"] = token;
      }
    });
    return headers;
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
        headers: baseHeaders(),
        body: {"phone": phone, "pwd": pwd, "userid": ""});
    responseBodyHandler(resp, successHandler, errorHandler);
  }

  //获取提醒和当天的服药记录
  static basic(BuildContext context, Function successHandler,
      Function errorHandler) async {
    var props = await SharedPreferences.getInstance();
    var token = props.getString("token");
    var userid = props.getString("userid");
    var box = props.getString("box");
    box = box == null ? "" : box;
    if ((token == null || userid == null) && context != null) {
      MainPageState.loginPage(context);
    }
    var resp =
        await http.get(basicUrl + "?userid=$userid&boxid=$box&token=$token");

    responseBodyHandler(resp, successHandler, errorHandler);
  }
}
