import 'package:flutter/material.dart';
import 'package:EigitalFacebook/Model/Weather.dart';
import 'Screens/Auth/Login.dart';
import 'Screens/Dashboard.dart';
import 'Screens/ReadArticle.dart';
import 'Screens/WeatherScreen.dart';

class Router {
  final BuildContext myContext;

  Router({@required this.myContext});

  toDashboard(String imgUrl, String name, String media) {
    Navigator.pop(myContext);
    Navigator.push(
      myContext,
      MaterialPageRoute(
        builder: (context) =>
            DashboardScreen(imgUrl: imgUrl, name: name, media: media),
      ),
    );
  }

  toArticle(article) {
    Navigator.push(
      myContext,
      MaterialPageRoute(
        builder: (context) => ReadArticle(
          article: article,
        ),
      ),
    );
  }

  toLogin() async {
    Navigator.popAndPushNamed(myContext, '/login');
    // Navigator.pop(myContext);
    // Navigator.push(
    //   myContext,
    //   MaterialPageRoute(
    //     builder: (context) => LoginScreen(),
    //   ),
    // );
  }

  toWeather(Weather weather) async {
    Navigator.push(
      myContext,
      MaterialPageRoute(
        builder: (context) => WeatherScreen(
          weather: weather,
        ),
      ),
    );
  }
}
