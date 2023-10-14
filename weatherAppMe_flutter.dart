import 'dart:async';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.red,
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: Text(
            "Weather Forecast",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: _buildBody(),
      ),
    );
  }
}

Widget _buildBody() {
  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _textForm(),
                _cityDetail(),
                Padding(
                  padding: EdgeInsets.only(top: 40),
                  child: _temperatureDetail(),
                ),
                _extraWeatherDetail(),
                _bottomDetail(),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

TextFormField _textForm() {
  return TextFormField(
    decoration: const InputDecoration(
      icon: Icon(Icons.search, color: Colors.white),
      hintText: 'Enter City Name',
      hintStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
    ),
  );
}

Column _cityDetail() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Padding(
        padding: EdgeInsets.only(top: 16),
        child: Text(
          'Moscow, RUSSIA',
          style: TextStyle(
            color: Colors.white,
            fontSize: 32,
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.only(top: 5),
        child: Text(
          'Saturday, Oct 14, 2023',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
    ],
  );
}

Row _temperatureDetail() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.wb_sunny,
            color: Colors.white,
            size: 100,
          ),
        ],
      ),
      SizedBox(width: 16),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                '6℃',
                style: TextStyle(
                  fontSize: 72,
                  color: Colors.white,
                  fontWeight: FontWeight.w100,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                'Cloudy',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}

Row _extraWeatherDetail() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Padding(
        padding: EdgeInsets.only(right: 30, top: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.ac_unit,
              color: Colors.white,
              size: 40,
            ),
            Text(
              '     5\n km/hr',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
      Padding(
        padding: EdgeInsets.only(right: 30, top: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.ac_unit,
              color: Colors.white,
              size: 40,
            ),
            Text(
              ' 3\n %',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
      Padding(
        padding: EdgeInsets.only(right: 30, top: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.ac_unit,
              color: Colors.white,
              size: 40,
            ),
            Text(
              '20\n %',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

ListView _bottomDetail() {
  return ListView(
    scrollDirection: Axis.horizontal,
    children: [
      Container(
        width: 200,
        color: Colors.red.shade300,
      ),
      Container(
        width: 200,
        color: Colors.red.shade300,
      ),
      Container(
        width: 200,
        color: Colors.red.shade300,
      ),
    ],
  );
}
