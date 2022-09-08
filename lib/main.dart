// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Body(),
    );
  }
}

class Body extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 50,
        itemBuilder: (context, rowNum){
          return Column(
            children: [Text("~DIY $rowNum",
            style: const TextStyle(fontSize: 20, color: Colors.cyan)),
              const Text("~Vine",
                  style: TextStyle(fontSize: 15, color: Colors.cyan)),
              Image.asset("assets/logo.png"),
              const Divider(
                color: Colors.black,
              )
              ],

          );
        }
    );
  }

}




class RandomWords extends StatefulWidget {
  const RandomWords({Key? key}) : super(key: key);

  @override
  State<RandomWords> createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final _words = <WordPair>[];
  final _saved = <WordPair>{};
  final _biggerFont = const TextStyle(fontSize: 18, color: Colors.orange);
  void _pushSaved(){
    //Navigator.of(context).push();
  }
  @override
  Widget build(BuildContext context) {
    final word = WordPair.random();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Startup Name Generator"),
        backgroundColor : Colors.teal,
        actions: [
          IconButton(onPressed: _pushSaved,
            icon: const Icon(Icons.list),
            tooltip: 'Saved Suggestions',
          ),
        ],

    ),
      body: ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i){
        if (i.isOdd) return const Divider();
        final index = i ~/ 2;
        if (index >= _words.length){
          _words.addAll(generateWordPairs().take(10));

    }

        final alreadySaved = _saved.contains(_words[index]);
        return ListTile(
          title: Text(
            _words[index].asPascalCase,
            style: _biggerFont,
          ),
              trailing: Icon(
                alreadySaved ? Icons.favorite : Icons.favorite_border,
                color: alreadySaved ? Colors.red : null,
                semanticLabel: alreadySaved ? 'Remove from saved' : 'Save',
              ),
          onTap: (){
            setState(() {
              if (alreadySaved){
                _saved.remove(_words[index]);
              }
              else {
                _saved.add(_words[index]);
              }
            });
          }
        );
    }
    )
    );
  }
}
