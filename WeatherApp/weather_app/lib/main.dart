import 'package:flutter/material.dart';
import 'dart:convert';
import './weather_block.dart';
import './weather.dart';
import 'package:http/http.dart' as http;
import 'package:weather_icons/weather_icons.dart';
import 'package:string_extensions/string_extensions.dart';
import './nav_bar.dart';
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
  String currTxt = '';
  Map<String, Weather> activeFieldsMap = {};
  
  final fieldText = TextEditingController();
  void addWeatherBox(Weather currWeather){
    setState((){
    activeFieldsMap[currWeather.city] = currWeather;
    activeFields++;
    });
    FocusScope.of(context).unfocus();
    fieldText.clear();
  }
  void removeWeatherBox(String city){
    setState((){
    activeFieldsMap.remove(city);
    activeFields++;
    });
  }

  void refresh(){
    var keysList = activeFieldsMap.keys.toList();
    keysList.forEach((key){removeWeatherBox(key);});
    keysList.forEach((key){getWeather(key);});
  }

  void removeAll(){
    var keysList = activeFieldsMap.keys.toList();
    keysList.forEach((key){removeWeatherBox(key);});
  }

  void newWeatherlocationHandler(){}
  
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
  if (result['cod']!=200) return;
  var tmp = Weather(cityName,result['main']['temp'].toStringAsFixed(1),result['weather'][0]['main']);
  
  if(activeFieldsMap.containsKey(cityName))
  {
    activeFieldsMap[cityName]!.description=tmp.description;
    activeFieldsMap[cityName]!.temp=tmp.temp;
  }
  else{
  addWeatherBox(tmp);
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
    getWeather('Oslo');
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.grey[700],
      drawer: NavBar(removeAll),
      appBar: AppBar(
        title: Text(widget.title,style: TextStyle(color: Colors.amber[800])),
        centerTitle: true,
        backgroundColor: Colors.grey[850],
        iconTheme: IconThemeData( color: Colors.amber[800]),
        // leading: IconButton(
        //   onPressed: () {},
        //   icon:const Icon(Icons.menu),
        //   color: Colors.amber[800],
        // ),
        actions: [IconButton(
          icon:const Icon(Icons.refresh),
          onPressed: refresh,
          color: Colors.amber[800],
        )],
      ),
      body:  Column(
       crossAxisAlignment: CrossAxisAlignment.center,
       children: [
         Flexible(child: ListView.builder(
           itemCount: activeFieldsMap.length,
           itemBuilder: (BuildContext context, int index){
             return WeatherBlock(descriptionToIcon(activeFieldsMap[activeFieldsMap.keys.toList()[index]]!.description), activeFieldsMap[activeFieldsMap.keys.toList()[index]]!.city, activeFieldsMap[activeFieldsMap.keys.toList()[index]]!.temp, removeWeatherBox);
           },
         ))
         //ListView.builder(
           //itemCount:activeFieldsMap.length,
           //itemBuilder: (BuildContext context, int index){
          
         ///}
         //)
         ,
         TextField(
           controller: fieldText,
           decoration: const InputDecoration(
           labelText: 'Enter city name'),
           style: TextStyle(color: Colors.grey[100]),
           onChanged: (String str){
             currTxt=str;
            
           },
           onEditingComplete: (){getWeather(currTxt.toLowerCase().capitalize());},
         ),
         IconButton(
           icon: const Icon(Icons.add_circle_outline),
           onPressed: (){getWeather(currTxt.toLowerCase().capitalize());},
           color: Colors.amber[800],
           iconSize: 30.0,
        )
         
       ]
        
      ),
       // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
