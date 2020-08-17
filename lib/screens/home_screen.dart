import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:testing_example/models/weather.dart';
import 'package:testing_example/widgets/weather_widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController textEditingController;
  bool loading;
  Weather weather;

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController();
    loading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Find Weather Quickly"),
        centerTitle: true,
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.network(
                  "https://thumbs.dreamstime.com/t/weather-forecast-concept-climate-change-background-collage-sky-image-variety-conditions-bright-sun-blue-dark-stormy-152471755.jpg"),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                      width: 200,
                      child: TextField(
                        controller: textEditingController,
                        decoration:
                            InputDecoration(hintText: "Enter the city name"),
                      )),
                  SizedBox(
                    width: 20,
                  ),
                  RaisedButton(
                    onPressed: () async {
                      setState(() {
                        loading = true;
                      });
                      var info = await Weather.getWeatherInfo(
                          textEditingController.text);
                      setState(() {
                        weather = info;
                        loading = false;
                      });
                      textEditingController.clear();
                      // print(weather);
                    },
                    child: Text("Find Weather"),
                  )
                ],
              ),
            ),
            if (loading)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircularProgressIndicator(),
              )
            else if (weather != null)
              WeatherWidget(weather: weather)
          ],
        ),
      ),
    );
  }
}
