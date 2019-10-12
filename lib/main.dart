// Step 5: Add a lazily loading infinite scrolling ListView.
// Also, add a heart icon so users can favorite word pairings.
// Save the word pairings in the State class.
// Make the hearts tappable and save the favorites list in the
// State class.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/backen_api.dart';
import 'package:flutter_app/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var login = LoginPage();
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MainApp(),
      routes: {
//        "/": (BuildContext context) => MainApp(),
        "/login": (context) => login,
      },
    );
  }
}

class MainApp extends StatelessWidget {
  Function update;

  @override
  Widget build(BuildContext context) {
    var manPage = MainPage(context);
    update = manPage.update;
    return manPage;
  }
}

// ignore: must_be_immutable
class MainPage extends StatefulWidget {
  BuildContext _context;
  Function update;

  MainPage(BuildContext context) {
    _context = context;
  }

  @override
  State<StatefulWidget> createState() {
    this._checkToken();
    var state = MainPageState();
    update = state.loadData;
    return state;
  }

  _checkToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    if (token == null) {
//      MainPageState.loginPage(_context);
      MainPageState.loginPageWithCallback(_context, update);
    }
  }
}

class MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  List<String> _titles = ["服药提醒", "消息中心", "健康资讯", "个人中心"];
  List<Widget> _cells = [];
  String _phone;
  List<dynamic> _reminders = [];
  List<dynamic> _otherRecords = [];

  MainPageState() {
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        title: Text(_titles[_currentIndex]),
      ),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: ImageIcon(AssetImage('icons/ic_reminder.png')),
              title: Text(_titles.first)),
          BottomNavigationBarItem(
              icon: ImageIcon(AssetImage('icons/ic_message.png')),
              title: Text(_titles[1])),
          BottomNavigationBarItem(
              icon: ImageIcon(AssetImage('icons/ic_article.png')),
              title: Text(_titles[2])),
          BottomNavigationBarItem(
              icon: ImageIcon(AssetImage('icons/ic_user.png')),
              title: Text(_titles.last))
        ],
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
//        body: body
      body: ListView(children: _cells),
    );
  }

  void loadData() {
    BackendApi.basic(context, (data) {
      setState(() {
        var d = data["data"];
        _phone = d["phone"];
        _reminders = d["reminders"];
        _otherRecords = d["other_records"];
        _cells = _mapToWidgets();
      });
    }, (error) {
      print("获取数据错误");
    });
  }

  List<Widget> _mapToWidgets() {
    return _reminders.map((reminder) {
      String record = reminder["record"];
      Color color = Colors.blue;
      String msg = "今日待服药";
      int t;
      if (record != null) {
        String last = record.split(' ').last;
        t = int.parse(last);
      }
      if (t == null) {
        msg = "今日待服药";
      } else if (t < 0) {
        t = -t;
        msg = "今日提前$t分钟服药";
      } else if (t > 0) {
        msg = "今日延后$t分钟服药";
      } else if (t == 0) {
        msg = "今日准点服药";
        color = Colors.green;
      }
      String therapy = reminder["therapy"][0];
      return RemindCell(color, t == null ? 0 : 1, reminder["time"], msg,
          reminder["photo"], therapy.replaceFirst(" ", " x "));
    }).toList();
  }

  static loginPage(BuildContext context) {
    Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (BuildContext context, Animation<double> animation,
                  Animation<double> secondaryAnimation) =>
              LoginPage(),
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            return SlideTransition(
              position: animation
                  .drive(Tween(begin: Offset(0.0, 1.0), end: Offset.zero)),
              child: child,
            );
          },
        ));
  }

  static loginPageWithCallback(BuildContext context, Function success) {
    var page = LoginPage();
    Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (BuildContext context, Animation<double> animation,
                  Animation<double> secondaryAnimation) =>
              page,
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            return SlideTransition(
              position: animation
                  .drive(Tween(begin: Offset(0.0, 1.0), end: Offset.zero)),
              child: child,
            );
          },
        )).then((result) {
      print("login result $result");
      if (result == "loginSuccess") {
        success();
      }
    });
  }
}

//class FavoriteWidget extends StatefulWidget {
//  @override
//  State<StatefulWidget> createState() {
//    return _FavoriteWidgetState();
//  }
//}
//
//class _FavoriteWidgetState extends State<FavoriteWidget> {
//  bool _isFavorite = true;
//  int _favoriteCount = 41;
//  Widget _loginWidget = LoginPage();
//
//  void _toggleFavorite() {
//    setState(() {
//      if (_isFavorite) {
//        _favoriteCount -= 1;
//        _isFavorite = false;
//      } else {
//        _favoriteCount += 1;
//        _isFavorite = true;
//      }
//    });
////    Navigator.pushNamed(context, "/login");
//    Navigator.push(
//        context,
//        PageRouteBuilder(
//          pageBuilder: (BuildContext context, Animation<double> animation,
//                  Animation<double> secondaryAnimation) =>
//              _loginWidget,
//          transitionsBuilder: (BuildContext context,
//              Animation<double> animation,
//              Animation<double> secondaryAnimation,
//              Widget child) {
//            return SlideTransition(
//              position: animation
//                  .drive(Tween(begin: Offset(0.0, 1.0), end: Offset.zero)),
//              child: child,
//            );
//          },
//        ));
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Row(
//      mainAxisSize: MainAxisSize.min,
//      children: <Widget>[
//        Container(
//          padding: EdgeInsets.all(0.0),
//          child: IconButton(
//            icon: Icon(_isFavorite ? Icons.star : Icons.star_border),
//            color: Colors.red[500],
//            onPressed: _toggleFavorite,
//          ),
//        ),
//        SizedBox(
//          width: 18,
//          child: Container(
//            child: Text('$_favoriteCount'),
//          ),
//        )
//      ],
//    );
//  }
//}

class RemindCell extends StatefulWidget {
  RemindCell(Color subTitleFontColor, int type, String time, String msg,
      String imgUrl, String pill) {
    this._subTitleFontColor = subTitleFontColor;
    this._type = type;
    this._time = time;
    this._msg = msg;
    this._imgUrl = imgUrl;
    this._pill = pill;
  }

  var _subTitleFontColor = Colors.blue;

  /**
   * 0 服药按钮，1 删除按钮
   */
  var _type = 0;
  String _time;
  String _msg;
  String _imgUrl;
  String _pill;

  @override
  State<StatefulWidget> createState() {
    return RemindCellState(
        _subTitleFontColor, _type, _time, _msg, _imgUrl, _pill);
  }
}

class RemindCellState extends State<RemindCell> {
  RemindCellState(Color subTitleFontColor, int type, String time, String msg,
      String imgUrl, String pill) {
    this._subTitleFontColor = subTitleFontColor;
    this._type = type;
    this._time = time;
    this._msg = msg;
    this._imgUrl = imgUrl;
    this._pill = pill;
  }

  var _subTitleFontColor = Colors.blue;

  /**
   * 0 服药按钮，1 删除按钮
   */
  var _type = 0;

  String _time;

  String _msg;

  String _imgUrl;

  String _pill;

  Widget _takingMedicine = Container(
      width: 60,
      height: 22,
      margin: EdgeInsets.only(right: 10),
      child: FlatButton(
        color: Colors.blue,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(11)),
        onPressed: () {},
        textColor: Colors.white,
        child: Text("服药"),
      ));

  Widget _deletedBtn = GestureDetector(
    onTap: () {
      print("点击了图片");
    },
    child: Image(
      image: AssetImage("icons/delete.png"),
      width: 28,
      height: 28,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(4.0))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                child: _imgUrl == null
                    ? Image.asset(
                        'images/medicine.png',
                        height: 40.0,
                        fit: BoxFit.contain,
                      )
                    : Image.network(_imgUrl, height: 40, fit: BoxFit.contain),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                padding: EdgeInsets.fromLTRB(10, 4, 10, 4),
                decoration: BoxDecoration(
                  image:
                      DecorationImage(image: AssetImage("images/bg_time.png")),
                ),
                child: Text(
                  _time,
                  style: TextStyle(color: Colors.blue),
                ),
              ),
              Expanded(
                child: SizedBox(height: 10),
              ),
              Container(
                margin: EdgeInsets.only(right: 10),
                child: Text(_pill),
              )
            ],
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
            height: 2,
            color: const Color.fromARGB(255, 242, 242, 242),
          ),
          Row(
            children: <Widget>[
              Container(
                  margin: EdgeInsets.fromLTRB(10, 0, 0, 4),
                  child: Text(
                    _msg,
                    style: TextStyle(fontSize: 14, color: _subTitleFontColor),
                  )),
              Expanded(
                  child: SizedBox(
                height: 0,
              )),
              _type == 0 ? _takingMedicine : _deletedBtn
            ],
          ),
        ],
      ),
    );
  }
}
