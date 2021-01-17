import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:weatherapp/api.dart';
import 'package:weatherapp/model.dart';
import 'package:weatherapp/row_container.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  var temp;
  var description;
  var currently;
  var humidity;
  var windspeed;
  var logo;

  Future getweather() async {
    http.Response response = await http.get(
        "http://api.openweathermap.org/data/2.5/weather?q=Mumbai&units=imperial&appid=b023eeabaa92965afc2273173c8e0655");
    var result = jsonDecode(response.body);
    setState(() {
      this.temp = result['main']['temp'];
      this.description = result['weather'][0]['description'];
      this.currently = result['weather'][0]['main'];
      this.humidity = result['main']['humidity'];
      this.windspeed = result['wind']['speed'];
      this.logo =
          "https://cdn4.vectorstock.com/i/1000x1000/34/23/thermometer-sun-heat-temperature-icon-vector-22773423.jpg";
    });
  }

  @override
  void initState() {
    super.initState();
    getweather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height / 2,
            width: MediaQuery.of(context).size.width,
            color: Colors.black87,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: Text("Currently in Mumbai",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w600)),
                ),
                Text(
                  temp != null ? temp.toString() + "\u00B0" : "Loading",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 40.0,
                      fontWeight: FontWeight.w600),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Text(
                      currently != null ? currently.toString() : "Loading",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w600)),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                RowContainer(
                  attribute: "Temp",
                  temp: temp.toString(),
                  logo: Icons.thermostat_sharp,
                ),
                RowContainer(
                  attribute: "Humidity",
                  temp: humidity.toString(),
                  logo: Icons.cloud,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                RowContainer(
                  attribute: "Weather",
                  temp: currently.toString(),
                  logo: Icons.waves,
                ),
                RowContainer(
                  attribute: "Windspeed",
                  temp: windspeed.toString(),
                  logo: Icons.speed,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}