import 'package:flutter/material.dart';

class Message
{
  late  String name;
  late  String  age;
  late  DateTime time;
  late String sender;

  Message({required this.name,required this.age,required this.time ,required this.sender});

   Map<String,dynamic> toMap()
   {
       return{
         'name':name,
          'age':age,
         'time':time,
         'sender':sender
       };
   }
}