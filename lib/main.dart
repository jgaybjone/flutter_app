// Step 5: Add a lazily loading infinite scrolling ListView.
// Also, add a heart icon so users can favorite word pairings.
// Save the word pairings in the State class.
// Make the hearts tappable and save the favorites list in the
// State class.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var login = Login();
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
  @override
  Widget build(BuildContext context) {
    var manPage = MainPage(context);
    return manPage;
  }
}

// ignore: must_be_immutable
class MainPage extends StatefulWidget {
  BuildContext _context;

  MainPage(BuildContext context) {
    _context = context;
  }

  @override
  State<StatefulWidget> createState() {
    this._checkToken();
    return MainPageState();
  }

  _checkToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    if (token == null) {
      await MainPageState.loginPage(_context);
    } else {
      await prefs.setString("token", "xiaojiling");
    }
  }
}

class MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  List<String> _titles = ["服药提醒", "消息中心", "健康资讯", "个人中心"];

  @override
  Widget build(BuildContext context) {
    final titleRow = Container(
      padding: const EdgeInsets.all(32),
      child: new Row(
        children: <Widget>[
          new Expanded(
              child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Container(
                padding: EdgeInsets.only(bottom: 8),
                child: new Text(
                  'Oeschinen Lake Campground',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                'Kandersteg, Switzerland',
                style: TextStyle(color: Colors.grey[500]),
              )
            ],
          )),
          FavoriteWidget()
//          Icon(
//            Icons.star,
//            color: Colors.red[500],
//          ),
//          Text('41')
        ],
      ),
    );

    Color color = Theme.of(context).primaryColor;

    final buttonRow = Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          new Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.call,
                color: color,
              ),
              Container(
                margin: const EdgeInsets.only(top: 8),
                child: Text(
                  'CALL',
                  style: TextStyle(fontSize: 12, color: color),
                ),
              )
            ],
          ),
          new Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.near_me,
                color: color,
              ),
              Container(
                margin: const EdgeInsets.only(top: 8),
                child: Text(
                  'ROUTE',
                  style: TextStyle(fontSize: 12, color: color),
                ),
              )
            ],
          ),
          new Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.share,
                color: color,
              ),
              Container(
                margin: const EdgeInsets.only(top: 8),
                child: Text(
                  'SHARE',
                  style: TextStyle(fontSize: 12, color: color),
                ),
              )
            ],
          )
        ],
      ),
    );

    final contentRow = Container(
      padding: EdgeInsets.all(32.0),
      child: Text('''
Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese Alps. Situated 1,578 meters above sea level, it is one of the larger Alpine Lakes. A gondola ride from Kandersteg, followed by a half-hour walk through pastures and pine forest, leads you to the lake, which warms to 20 degrees Celsius in the summer. Activities enjoyed here include rowing, and riding the summer toboggan run.
        '''),
    );

    final imageRow = ListView(
      shrinkWrap: true,
      children: <Widget>[
        Image.asset(
          'images/lake.jpeg',
          height: 240.0,
          fit: BoxFit.fill,
        ),
      ],
    );

    var body = ListView(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: <Widget>[imageRow, titleRow, buttonRow, contentRow],
    );
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
      body: ListView(
        children: <Widget>[
          RemindCell(Colors.red, 0),
          RemindCell(Colors.blue, 1),
          RemindCell(Colors.grey, 0),
          RemindCell(Colors.brown, 0),
          RemindCell(Colors.brown, 0),
          RemindCell(Colors.indigo, 1),
          RemindCell(Colors.indigo, 1),
          RemindCell(Colors.indigo, 1),
          RemindCell(Colors.brown, 0),
          RemindCell(Colors.brown, 0),
          RemindCell(Colors.blue, 1),
          RemindCell(Colors.blue, 1),
          RemindCell(Colors.blue, 1),
          RemindCell(Colors.blue, 1),
          RemindCell(Colors.blue, 1),
          RemindCell(Colors.blue, 1),
          RemindCell(Colors.blue, 1),
          RemindCell(Colors.blue, 1),
          RemindCell(Colors.blue, 1),
          Container(
            height: 10,
            color: Colors.transparent,
          )
        ],
      ),
    );
  }

  static loginPage(BuildContext context) {
    Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (BuildContext context, Animation<double> animation,
                  Animation<double> secondaryAnimation) =>
              Login(),
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
}

class FavoriteWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FavoriteWidgetState();
  }
}

class _FavoriteWidgetState extends State<FavoriteWidget> {
  bool _isFavorite = true;
  int _favoriteCount = 41;
  StatelessWidget _loginWidget = Login();

  void _toggleFavorite() {
    setState(() {
      if (_isFavorite) {
        _favoriteCount -= 1;
        _isFavorite = false;
      } else {
        _favoriteCount += 1;
        _isFavorite = true;
      }
    });
//    Navigator.pushNamed(context, "/login");
    Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (BuildContext context, Animation<double> animation,
                  Animation<double> secondaryAnimation) =>
              _loginWidget,
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

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(0.0),
          child: IconButton(
            icon: Icon(_isFavorite ? Icons.star : Icons.star_border),
            color: Colors.red[500],
            onPressed: _toggleFavorite,
          ),
        ),
        SizedBox(
          width: 18,
          child: Container(
            child: Text('$_favoriteCount'),
          ),
        )
      ],
    );
  }
}

class RemindCell extends StatefulWidget {
  RemindCell(Color subTitleFontColor, int type) {
    this._subTitleFontColor = subTitleFontColor;
    this._type = type;
  }

  var _subTitleFontColor = Colors.blue;

  /**
   * 0 服药按钮，1 删除按钮
   */
  var _type = 0;

  @override
  State<StatefulWidget> createState() {
    return RemindCellState(_subTitleFontColor, _type);
  }
}

class RemindCellState extends State<RemindCell> {
  RemindCellState(Color subTitleFontColor, int type) {
    this._subTitleFontColor = subTitleFontColor;
    this._type = type;
  }

  var _subTitleFontColor = Colors.blue;

  /**
   * 0 服药按钮，1 删除按钮
   */
  var _type = 0;

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
                child: Image.asset(
                  'images/medicine.png',
                  height: 40.0,
                  fit: BoxFit.contain,
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                padding: EdgeInsets.fromLTRB(10, 4, 10, 4),
                decoration: BoxDecoration(
                  image:
                      DecorationImage(image: AssetImage("images/bg_time.png")),
                ),
                child: Text(
                  "07:41",
                  style: TextStyle(color: Colors.blue),
                ),
              ),
              Expanded(
                child: SizedBox(height: 10),
              ),
              Container(
                margin: EdgeInsets.only(right: 10),
                child: Text("是不是 x 1"),
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
                    "今日待服药",
                    style: TextStyle(fontSize: 15, color: _subTitleFontColor),
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
