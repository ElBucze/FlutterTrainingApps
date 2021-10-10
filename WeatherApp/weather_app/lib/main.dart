import 'package:flutter/material.dart';
import 'dart:convert';
import './weather_block.dart';
import './weather.dart';
import 'package:http/http.dart' as http;
import 'package:weather_icons/weather_icons.dart';

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
  Map<String, Weather> activeFieldsMap = {};
  
  void addWeatherBox(Weather currWeather){
    setState((){
    activeFieldsMap[currWeather.city] = currWeather;
    activeFields++;
    print(currWeather);
    });
  }
  
  IconData descriptionToIcon(String desc){
    IconData i = Icons.not_interested;
    switch(desc){
      case 'Clear':{
        i = WeatherIcons.day_sunny;
      }
      break;
      case 'Clouds':{
        i = WeatherIcons.cloud;
      }
      break;
       case 'Snow':{
        i = WeatherIcons.snow;
      }
      break;
      case 'Rain':{
        i = WeatherIcons.rain;
      }
      break;
      case 'Drizzle':{
        i = WeatherIcons.sprinkle;
      }
      break;
      case 'Thunderstorm':{
        i = WeatherIcons.thunderstorm;
      }
      break;
      case 'Mist':{
        i = WeatherIcons.fog;
      }
      break;
      case 'Fog':{
        i = WeatherIcons.fog;
      }
      break;     
    }

    return i;
  }

  Future getWeather(cityName) async{
    http.Response response= await http.get(Uri.parse("http://api.openweathermap.org/data/2.5/weather?q=$cityName&units=metric&appid=b88a3c5bce2787dd5e8c0db43cd0ed5f"));
  var result = jsonDecode(response.body);
  var tmp = Weather(cityName,result['main']['temp'].toStringAsFixed(1),result['weather'][0]['main']);
  if(result['cod']==200){
  if(activeFieldsMap.containsKey(cityName))
  {
    activeFieldsMap[cityName]!.description=tmp.description;
    activeFieldsMap[cityName]!.temp=tmp.temp;
  }
  else{
  addWeatherBox(tmp);
  }
  }
  else{
    print('error');
  }
  }
  
  @override
  void initState(){
    super.initState();
    getWeather('Szczecin');
    getWeather('Warszawa');
    getWeather('Boston');
    getWeather('London');
    getWeather('Berlin');
  }


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
         Flexible(child: ListView.builder(
           itemCount: activeFieldsMap.length,
           itemBuilder: (BuildContext context, int index){
             return WeatherBlock(descriptionToIcon(activeFieldsMap[activeFieldsMap.keys.toList()[index]]!.description), activeFieldsMap[activeFieldsMap.keys.toList()[index]]!.city, activeFieldsMap[activeFieldsMap.keys.toList()[index]]!.temp);
           },
         ))
         //ListView.builder(
           //itemCount:activeFieldsMap.length,
           //itemBuilder: (BuildContext context, int index){
          
         ///}
         //)
         ,
         IconButton(
           icon: Icon(Icons.add_circle_outline),
           onPressed: (){},
           color: Colors.amber[800],
           iconSize: 30.0,
        )
         
       ]
        
      ),
       // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
