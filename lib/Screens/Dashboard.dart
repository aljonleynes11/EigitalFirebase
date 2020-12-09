import 'dart:async';
import 'package:EigitalFacebook/Commons/CustomDrawer.dart';
import 'package:EigitalFacebook/Commons/DashboardBody.dart';
import 'package:EigitalFacebook/Helpers/Responsive.dart';
import 'package:EigitalFacebook/Model/News.dart';
import 'package:EigitalFacebook/Model/Weather.dart';
import 'package:EigitalFacebook/Services/NewsManager.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:EigitalFacebook/Services/WeatherManager.dart';
import 'package:EigitalFacebook/Router.dart';
import 'package:EigitalFacebook/Commons/SearchBar.dart';
import 'package:http/http.dart';

class DashboardScreen extends StatefulWidget {
  final String imgUrl;
  final String name;
  final String media;

  DashboardScreen({@required this.imgUrl, @required this.name, this.media});
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

News newsList;
Weather weather;
Weather searchWeather;
TextEditingController weatherController = TextEditingController();

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    _getNews();
    _getWeather();
  }

  Future<News> _getNews() async {
    newsList = await NewsManager().getNews();
    newsList = NewsManager().filterNews(newsList);

    return newsList;
  }

  Future<LocationData> _getWeather() async {
    weather = await WeatherManager().getWeather();
  }

  Future<Weather> _searchWeather() async {
    if (weatherController.text.length <= 3) {
      print('add more character');
    } else {
      searchWeather =
          await WeatherManager().searchWeather(weatherController.text);
      weatherController.text = '';
      Router(myContext: context).toWeather(searchWeather);
      return searchWeather;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              toWeather(),
              SearchBar(
                controller: weatherController,
                onTrigger: () => _searchWeather(),
                width: dw(context) * 0.55,
              )
            ],
          ),
          backgroundColor: Colors.black54,
        ),
        drawer: viewCustomDrawer(),
        body: Center(
            child: FutureBuilder(
                future: Future.wait([_getNews(), _getWeather()]),
                builder: (context, snapshot) {
                  if (snapshot.hasData)
                    return Column(children: [
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: ListView.builder(
                              itemCount: newsList.articles.length,
                              itemBuilder: (context, index) {
                                Article news = newsList.articles[index];

                                return Column(
                                  children: [
                                    (index % 2 != 0)
                                        ? Container(
                                            child: DashboardBody(
                                            news: news,
                                            isEven: true,
                                          ))
                                        : Container(
                                            child: DashboardBody(
                                            news: news,
                                            isEven: false,
                                          ))
                                  ],
                                );
                              }),
                        ),
                      ),
                    ]);
                  else
                    return loading();
                })));
  }

  Widget viewCustomDrawer() {
    return CustomDrawer(
      imageUrl: widget.imgUrl,
      fbName: widget.name,
      media: widget.media,
    );
  }

  Widget loading() {
    return Container(
        height: dh(context) * 1,
        child: Center(child: CircularProgressIndicator()));
  }

  toWeather() {
    return Container(
      child: FlatButton(
        child: Icon(
          Icons.cloud_queue,
          color: Colors.white,
        ),
        onPressed: () => Router(myContext: context).toWeather(weather),
      ),
    );
  }
}
