import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                icon: ImageIcon(AssetImage('icons/password.png'),
                    color: Colors.blue),
                hintText: '登录密码')),
      ),
    );

    var loginBtn = Container(
      padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
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
