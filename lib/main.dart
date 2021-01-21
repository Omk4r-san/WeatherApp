import 'package:flutter/material.dart';
import 'package:weatherapp/home.dart';

void main() => runApp(MaterialApp(
      title: "weather App",
      home: Home(),
      theme: ThemeData(
          fontFamily: 'lucida',
          brightness: Brightness.dark,
          textTheme: TextTheme(headline6: TextStyle(color: Colors.black))),
      debugShowCheckedModeBanner: false,
    ));
