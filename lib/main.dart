// Step 5: Add a lazily loading infinite scrolling ListView.
// Also, add a heart icon so users can favorite word pairings.
// Save the word pairings in the State class.
// Make the hearts tappable and save the favorites list in the
// State class.

import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
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
      shrinkWrap: true,
      children: <Widget>[imageRow, titleRow, buttonRow, contentRow],
    );

    final app = MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
//home: new Center(child: new Text('Hello World'),),
      home: Scaffold(body: body),
    );

    return app;
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
