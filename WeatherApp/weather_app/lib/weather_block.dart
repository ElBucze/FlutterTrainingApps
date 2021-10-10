
import "package:flutter/material.dart";
import './next_day_block.dart';

class WeatherBlock extends StatelessWidget {
  String location;
  String temperature;
  IconData icon;
  WeatherBlock(this.icon,this.location,this.temperature,);
  

  @override
  Widget build(BuildContext context) {


    return Container(
      width: double.infinity,
      height: 120.0,
      margin: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        color: Colors.grey[850],
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(Radius.circular(20.0))
      ),
      child:
      Stack(
        children:[
       Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: 
        [Expanded(child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           crossAxisAlignment: CrossAxisAlignment.center,
           children:[
            Icon(
            icon,
            color: Colors.orange,
            size: 75.0,),
          Text(
            temperature,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20.0, fontFamily: 'Roboto',color: Colors.grey[100],),
            )])),
          Expanded(
            child:
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children:[
             Text(
              location,
              textAlign: TextAlign.center,
              style: TextStyle( fontSize: 30.0, fontFamily: 'Roboto',color: Colors.grey[100],),),
             Row(
               mainAxisAlignment: MainAxisAlignment.center,
               crossAxisAlignment: CrossAxisAlignment.center,
               children:[
              // for(var i; i<5; i++){
                  nextDay(DateTime.now().add(Duration(days: 1)),Icons.wb_sunny_rounded , Colors.orange, "24℃"),
                  nextDay(DateTime.now().add(Duration(days: 2)),Icons.wb_sunny_rounded , Colors.orange, "22℃"),
                  nextDay(DateTime.now().add(Duration(days: 3)),Icons.wb_cloudy, Colors.white, "20℃"),
                  nextDay(DateTime.now().add(Duration(days: 4)),Icons.wb_cloudy , Colors.white, "18℃"),
                  nextDay(DateTime.now().add(Duration(days: 4)),Icons.wb_sunny_rounded , Colors.orange, "20℃"),

               //}
               ])])),],),
               Positioned(
                top:-5.0,
                left: -5.0,
                child: IconButton(
                  icon: Icon(Icons.close),
                  color: Colors.grey[100],
                  onPressed: (){},))
        ]));
  }
}