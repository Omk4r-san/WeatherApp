import 'package:flutter/material.dart';
import 'package:weatherapp/home.dart';

void main() => runApp(MaterialApp(
      title: "weather App",
      home: Home(),
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      debugShowCheckedModeBanner: false,
    ));
