import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Model/weather.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WeatherList(),
    );
  }
}

class WeatherList extends StatefulWidget {
  @override
  _WeatherListState createState() => _WeatherListState();
}

class _WeatherListState extends State<WeatherList> {
  List<Weather> weatherData = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    final String data = await rootBundle.loadString('assets/weather_data.json');
    List<dynamic> jsonList = json.decode(data);

    List<Weather> weatherList = jsonList.map((item) => Weather.fromJson(item)).toList();
    setState(() {
      weatherData = weatherList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather Info App'),
      ),
      body: ListView.builder(
        itemCount: weatherData.length,
        itemBuilder: (context, index) {
          Weather weather = weatherData[index];
          return Card(
            child: ListTile(
              title: Text(weather.city),
              subtitle: Text('Temperature: ${weather.temperature}°C\nCondition: ${weather.condition}\nHumidity: ${weather.humidity}%\nWind Speed: ${weather.windSpeed} km/h'),
            ),
          );
        },
      ),
    );
  }
}