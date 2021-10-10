import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Widget nextDay(DateTime day, IconData icon , Color c, String temperature){
  return Container(
    margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
    height: 45.0,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children:[
        Text(DateFormat(DateFormat.ABBR_WEEKDAY).format(day),style:TextStyle(fontSize: 10, color: Colors.grey[100])),
        SizedBox( height: 5.0,),
        Icon(
          icon,
          size: 10.0,
          color: c,
        ),
        SizedBox( height: 5.0,),
        Text(temperature,style:TextStyle(fontSize: 10, color: Colors.grey[100]))
      ]

    ),
  );
}