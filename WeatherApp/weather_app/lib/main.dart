import 'package:flutter/material.dart';

import './weather_block.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: const MyHomePage(title: 'Weather App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int activeFields = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // activeFields without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      activeFields++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[700],
      appBar: AppBar(
        title: Text(widget.title,style: TextStyle(color: Colors.amber[800])),
        centerTitle: true,
        backgroundColor: Colors.grey[850],
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.menu),
          color: Colors.amber[800],
        ),
        actions: [IconButton(
          icon: Icon(Icons.search),
          onPressed: () {},
          color: Colors.amber[800],
        )],
      ),
      body:  Column(
       crossAxisAlignment: CrossAxisAlignment.center,
       children: [
         WeatherBlock(Icons.wb_sunny_rounded, 'Szczecin', '26.3℃')
         
       ]
        
      ),
       // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
