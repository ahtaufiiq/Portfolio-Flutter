import 'dart:async';

import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int present = 0;
  int perPage = 15;
  int counter = 0;

  final originalItems = List<String>.generate(10000, (i) => "Item $i");
  var items = ["kata"];

  late Timer searchOnStoppedTyping;

  _onChangeHandler(value) {
    const duration = Duration(
        milliseconds:
            1500); // set the duration that you want call search() after that.
    setState(() => searchOnStoppedTyping =
        new Timer(duration, () => print("Tes"))); // clear timer
  }

  @override
  void initState() {
    super.initState();
    searchOnStoppedTyping =
        Timer(Duration(seconds: 3), () => {print("testing lagi")});
    setState(() {
      items.addAll(originalItems.getRange(present, present + perPage));
      present = present + perPage;
    });
  }

  void loadMore() {
    setState(() {
      counter++;
      print(counter);
      searchOnStoppedTyping =
          Timer(Duration(seconds: 3), () => {print("testing lagi")});
      items.addAll(originalItems.getRange(present, present + perPage));
      present = present + perPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: SafeArea(
        child: NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scrollInfo) {
            if (scrollInfo.metrics.pixels >
                scrollInfo.metrics.maxScrollExtent - 20 && !searchOnStoppedTyping.isActive) {
              loadMore();
            }
            return false;
          },
          child: ListView.builder(
            itemCount: (present <= originalItems.length)
                ? items.length + 1
                : items.length,
            itemBuilder: (context, index) {
              return (index == items.length)
                  ? Container(
                      color: Colors.greenAccent,
                      child: TextButton(
                        child: Text("Load More"),
                        onPressed: () {
                          loadMore();
                        },
                      ),
                    )
                  : ListTile(
                      title: Text('${items[index]}'),
                    );
            },
          ),
        ),
      ),
    );
  }
}
