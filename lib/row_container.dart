import 'package:flutter/material.dart';

class RowContainer extends StatelessWidget {
  final String temp;
  final IconData logo;
  final String attribute;
  const RowContainer({
    Key key,
    this.temp,
    this.logo,
    this.attribute,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.grey, borderRadius: BorderRadius.circular(15)),
        height: MediaQuery.of(context).size.height / 6,
        width: MediaQuery.of(context).size.width / 3,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                logo,
                size: 40,
              ),
              Column(children: [
                Text(attribute,
                    style: TextStyle(color: Colors.white, fontSize: 25)),
                Text(
                  temp != null ? temp : "Loading",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                )
              ]),
            ],
          ),
        ));
  }
}
