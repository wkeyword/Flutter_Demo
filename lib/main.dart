import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(
      title: 'Startup Name Generator',
      theme: new ThemeData(primaryColor: Colors.white),
      home: new RandomWords(),
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new RandomWordsState();
  }
}

class RandomWordsState extends State<RandomWords> {
  final _ramdomWord = <WordPair>[];
  final _saved = new Set<WordPair>();
  final _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('分类数据'),
        actions: <Widget>[
          new IconButton(icon: new Icon(Icons.list), onPressed: _pushSaved)
        ],
      ),
      body: _buildSuggestions(),
    );
  }

  Widget _buildSuggestions() {
    return new ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i) {
        if (i.isOdd) {
          return new Divider();
        }
        final index = i ~/ 2;

        if (index >= _ramdomWord.length) {
          _ramdomWord.addAll(generateWordPairs().take(10));
        }

        return _buildRow(_ramdomWord[index]);
      },
    );
  }

  Widget _buildRow(WordPair pari) {
    final alreadySaved = _saved.contains(pari);
    return new ListTile(
      title: new Text(
        pari.asPascalCase,
        style: _biggerFont,
      ),
      trailing: new Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _saved.remove(pari);
          } else {
            _saved.add(pari);
          }
        });
      },
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      final tiles = _saved.map((pari) {
        return new ListTile(
          title: new Text(
            pari.asPascalCase,
            style: _biggerFont,
          ),
        );
      });

      final divided = ListTile.divideTiles(context: context, tiles: tiles).toList();

      return new Scaffold(
          appBar: new AppBar(
            title: new Text('Saved Suggestion'),
          ),
          body: new ListView(children: divided),
      );

    }));
  }
}
