import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter/rendering.dart';
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
  var city = "Mumbai";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.transparent,
        appBar: new AppBar(
          backgroundColor: Colors.transparent,
          title: TextField(
            decoration: new InputDecoration(
                icon: Icon(Icons.search), hintText: "Serach any city"),
            onSubmitted: (String query) {
              setState(() {
                city = query;
              });
            },
          ),
        ),
        body: futureBuilder());
  }

  Widget futureBuilder() {
    return FutureBuilder(
        future: Api().getweatherfromAPI(city),
        builder: (BuildContext context, AsyncSnapshot<GetWeather> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Center(child: LinearProgressIndicator());
            case ConnectionState.active:
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            case ConnectionState.done:
              if (snapshot.hasError)
                return Center(child: Text('Error: ${snapshot.error}'));
              return resultWidget(snapshot.data);
          }
          return null;
        });
  }

  Widget resultWidget(data) {
    return Stack(
      children: [
        Container(
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/background.png"),
                  fit: BoxFit.cover)),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height / 2,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(bottom: 10.0),
                        child: Text(data.name,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.w600)),
                      ),
                      Text(
                        data.main.temp.toString() + "\u00B0",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 40.0,
                            fontWeight: FontWeight.w600),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                        child: Text(data.weather[0].description.toString(),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w600)),
                      )
                    ],
                  ),
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        RowContainer(
                          attribute: "Temp",
                          temp: data.main.temp.toString() + "\u00B0",
                          logo: Icons.thermostat_sharp,
                        ),
                        RowContainer(
                          attribute: "Humidity",
                          temp: data.main.humidity.toString(),
                          logo: Icons.cloud,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        RowContainer(
                          attribute: "Weather",
                          temp: data.weather[0].description.toString(),
                          logo: Icons.waves,
                        ),
                        RowContainer(
                          attribute: "Windspeed",
                          temp: data.wind.speed.toString(),
                          logo: Icons.speed,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
