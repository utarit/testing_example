import 'dart:convert';

import 'package:testing_example/api_key.dart';
import 'package:http/http.dart' as http;

class Weather {
  String city;
  double temp;
  String description;
  int cod;
  String error;

  Weather({this.city, this.temp, this.description, this.cod, this.error});

  factory Weather.fromJson(Map<String, dynamic> data) {
    if (data["cod"] == 200) {
      return Weather(
          city: data["name"],
          temp: data["main"]["temp"] - 273.15,
          description: data["weather"][0]["description"],
          cod: data["cod"]);
    } else {
      return Weather(cod: int.tryParse(data["cod"]), error: data["message"]);
    }
  }

  static getWeatherInfo(String city) async {
    String url =
        "http://api.openweathermap.org/data/2.5/weather?q=$city&appid=$api_key";
    var response = await http.get(url);
    return Weather.fromJson(json.decode(response.body));

    // print(response.statusCode);
    // if (response.statusCode == 200) {
    //   return Weather.fromJson(json.decode(response.body));
    // } else {
    //   return Weather.fromJson(json.decode(response.body));
    // }
  }

  @override
  String toString() {
    return "$city is ${temp.toStringAsFixed(2)} celcius and it's $description";
  }
}
