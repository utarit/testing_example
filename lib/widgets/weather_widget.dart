import 'package:flutter/material.dart';
import 'package:testing_example/models/weather.dart';

class WeatherWidget extends StatelessWidget {
  final Weather weather;

  const WeatherWidget({Key key, this.weather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (weather.cod == 200) {
      return Container(
        width: 500,
        child: ListTile(
          title: Text(weather.city),
          subtitle: Text(weather.description),
          trailing: Text(weather.temp.toStringAsFixed(2) + " °C"),
        ),
      );
    } else {
      return Container(
        child: Text(weather.error),
      );
    }
  }
}
