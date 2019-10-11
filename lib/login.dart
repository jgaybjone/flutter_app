import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/backen_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginState();
  }
}

class LoginState extends State<LoginPage> {
  BuildContext _context;

  //手机号的控制器
  TextEditingController phoneController = TextEditingController();

  //密码的控制器
  TextEditingController passController = TextEditingController();

  void loginSuccess(Map data) {
    var userid = data["userid"];
    var nickname = data["nickname"];
    var boxes = data["boxes"];
    String token = data["token"];
    if (token == null) {
      token = "xiaojiling";
    }
    Future<SharedPreferences> prefs = SharedPreferences.getInstance();
    prefs.then((p) {
      p.setString("token", token).then((_) => {print("save token success")});
      if (userid != null && (userid is String)) {
        p
            .setString("userid", userid)
            .then((_) => {print("save userid success")});
      }
      if (nickname != null && nickname is String) {
        p
            .setString("nickname", nickname)
            .then((_) => {print("save nickname success")});
      }
      if (boxes != null && boxes is List && !boxes.isEmpty) {
        var b = boxes[0];
        if (b is String) {
          p.setString("box", b).then((_) => {print("save box success")});
        }
      }
    });
    Navigator.pop(_context);
  }

  void login() {
    BackendApi.patientLogin(
        phoneController.text, passController.text, loginSuccess, (data) {
      showDialog(
          context: _context,
          builder: (_) => Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      color: Colors.white,
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 8),
                            child: Text('用户名或者密码错误☹️',
                                style: TextStyle(
                                    fontSize: 16,
                                    decoration: TextDecoration.none)),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 15, bottom: 8),
                            child: FlatButton(
                                onPressed: () {
                                  // 关闭 Dialog
                                  Navigator.pop(_);
                                },
                                child: Text('确定')),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ));
    });
  }

  @override
  Widget build(BuildContext context) {
    this._context = context;
    var head = Container(
        padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
        height: 200,
        child: Center(
          child: Image.asset(
            'images/portrait.png',
            height: 90,
            width: 90,
          ),
        ));

    var mobile = Container(
      padding: EdgeInsets.fromLTRB(40, 0, 40, 10),
      child: Center(
        child: TextField(
            controller: phoneController,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(10, 6, 10, 6),
              icon:
                  ImageIcon(AssetImage('icons/phone.png'), color: Colors.blue),
              hintText: '手机号',
            )),
      ),
    );
    var password = Container(
      padding: EdgeInsets.fromLTRB(40, 10, 40, 20),
      child: Center(
        child: TextField(
            controller: passController,
            obscureText: true,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(10, 6, 10, 6),
                icon: ImageIcon(AssetImage('icons/password.png'),
                    color: Colors.blue),
                hintText: '登录密码')),
      ),
    );

    var loginBtn = Container(
      padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
      child: RaisedButton(
        onPressed: login,
        padding: EdgeInsets.fromLTRB(10, 6, 10, 6),
        color: Colors.blue,
        textColor: Colors.white,
        child: Text('登录'),
      ),
    );

    var registBtn = Container(
      padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
      child: RaisedButton(
        onPressed: () {
          print('触碰了注册按钮');
          Navigator.pop(context);
        },
//        padding: EdgeInsets.fromLTRB(10, 6, 10, 6),
        color: Colors.blue,
        textColor: Colors.white,
        child: Text('注册'),
      ),
    );

    var resetPwd2 = Align(
      alignment: Alignment.bottomCenter,
      child: FlatButton(
        onPressed: () => print('点击了重置密码'),
        child: Text(
          '查找密码',
          style: TextStyle(fontSize: 14, color: Colors.blue),
        ),
      ),
    );

    var wechatLoginBtn = Center(
      child: IconButton(
          icon: ImageIcon(AssetImage('icons/wechat.png')),
          onPressed: () {
            print('微信登录');
          }),
    );

    var body = Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        head,
        Container(
          child: Column(
            children: <Widget>[mobile, password],
          ),
        ),
        Container(
          child: Row(
            children: <Widget>[
              Expanded(
                child: loginBtn,
              )
            ],
          ),
        ),
        Container(
          child: Row(
            children: <Widget>[
              Expanded(
                child: registBtn,
              )
            ],
          ),
        ),
        Expanded(
            flex: 8,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Text(
                    '微信登录',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ),
                IconButton(
                    icon: ImageIcon(AssetImage('icons/wechat.png')),
                    iconSize: 40,
                    color: Colors.grey[500],
                    onPressed: () {
                      print('微信登录');
                    }),
              ],
            )),
        Expanded(
          child: resetPwd2,
          flex: 1,
        )
      ],
    );

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: body,
    );
  }
}
