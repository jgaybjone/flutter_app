import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var head = Container(
        padding: EdgeInsets.fromLTRB(0, 60, 0, 60),
        child: Center(
          child: Image.asset(
            'images/portrait.png',
            height: 80,
            width: 80,
          ),
        ));

    var mobile = Container(
      padding: EdgeInsets.fromLTRB(40, 0, 40, 10),
      child: Center(
        child: TextField(
            decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(10, 6, 10, 6),
          icon: ImageIcon(AssetImage('icons/phone.png'), color: Colors.blue),
          hintText: '手机号',
        )),
      ),
    );
    var password = Container(
      padding: EdgeInsets.fromLTRB(40, 10, 40, 20),
      child: Center(
        child: TextField(
            decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(10, 6, 10, 6),
                icon: ImageIcon(AssetImage('icons/password.png'), color: Colors.blue),
                hintText: '登录密码')),
      ),
    );

    var loginBtn = Container(
      padding: EdgeInsets.fromLTRB(40, 20, 40, 0),
      child: RaisedButton(
        onPressed: () {
          print('触碰了登录按钮');
        },
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
        padding: EdgeInsets.fromLTRB(10, 6, 10, 6),
        color: Colors.blue,
        textColor: Colors.white,
        child: Text('注册'),
      ),
    );

    final rows = ListView(
      children: <Widget>[head, mobile, password, loginBtn, registBtn],
    );

    return Scaffold(body: rows);
  }
}
