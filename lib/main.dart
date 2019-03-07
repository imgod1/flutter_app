import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final wordPair = WordPair.random();
    return new MaterialApp(
      title: "Hello Flutter Title",
      theme: new ThemeData(
          primaryColor: Colors.pink, secondaryHeaderColor: Colors.grey),
      home: new RandomWords(),
    );
  }
}
//当前app的主页面
class RandomWords extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new RandomWordsState();
  }
}

//主页面里面的主视图
class RandomWordsState extends State<RandomWords> {
  final _randomWordsArray = <WordPair>[];
  final _saved = new Set<WordPair>();
  final _bigFont = const TextStyle(fontSize: 18.0);

  Widget _randomWordsWidget() {
    return new ListView.builder(
        padding: const EdgeInsets.all(10.0),
        itemBuilder: (context, i) {
          if (i.isOdd) {
            return new Divider();
          }

          final index = i ~/ 2;
          if (index >= _randomWordsArray.length) {
            _randomWordsArray.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_randomWordsArray[index]);
        });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
//    final wordPair = WordPair.random();
//    return new Text(wordPair.asPascalCase);
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("ListView_appbar"),
        actions: <Widget>[
          new IconButton(icon: new Icon(Icons.list), onPressed: pushSaved)
        ],
      ),
      body: _randomWordsWidget(),
    );
  }

  //appbar里面的点击跳转的点击事件
  void pushSaved() {
    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      final tiles = _saved.map((pair) {
        return new ListTile(
          title: new Text(
            pair.asPascalCase,
            style: _bigFont,
          ),
        );
      });

      final divied =
          ListTile.divideTiles(tiles: tiles, context: context).toList();

      return new Scaffold(
        appBar: new AppBar(
          title: new Text("Saved Words"),
        ),
        body: new ListView(children: divied),
      );
    }));
  }

  //listview的每一项
  Widget _buildRow(WordPair pair) {
    final isSaved = _saved.contains(pair);
    return new ListTile(
      title: new Text(
        pair.asPascalCase,
        style: _bigFont,
      ),
      trailing: new Icon(
        isSaved ? Icons.favorite : Icons.favorite_border,
        color: isSaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (isSaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      },
    );
  }
}
