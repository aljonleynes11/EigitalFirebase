import 'package:flutter/material.dart';
import 'package:EigitalFacebook/Helpers/Responsive.dart';
import 'package:EigitalFacebook/Model/Weather.dart';
import 'package:EigitalFacebook/Commons/SearchBar.dart';
import 'package:EigitalFacebook/Services/WeatherManager.dart';
import "package:EigitalFacebook/Extensions/capitalize.dart";
import 'dart:math';

class WeatherScreen extends StatefulWidget {
  Weather weather;

  WeatherScreen({@required this.weather});

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  @override
  Weather searchWeatherCity;

  TextEditingController weatherController = TextEditingController();
  Color color = Colors.tealAccent;
  Future<Weather> _searchWeather() async {
    searchWeatherCity =
        await WeatherManager().searchWeather(weatherController.text);
    widget.weather = searchWeatherCity;
    color = Colors.primaries[Random().nextInt(Colors.primaries.length)]
        .withOpacity(0.2);
    setState(() {});
  }

  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: SearchBar(
            onTrigger: () => _searchWeather(),
            controller: weatherController,
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.8, 1],
                  colors: [Colors.black54, color])),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(widget.weather.name, style: TextStyle(fontSize: 45)),
                weatherIcon(),
                Text(widget.weather.main.temp.toString() + " \u2103",
                    style: TextStyle(fontSize: 45)),
                Text(widget.weather.weather[0].description.capitalize(),
                    style: TextStyle(fontSize: 45)),
              ],
            ),
          ),
        ));
  }

  Widget weatherIcon() {
    return Container(
      child: Image.network(
          'http://openweathermap.org/img/wn/${widget.weather.weather[0].icon}@4x.png'),
    );
  }
}
