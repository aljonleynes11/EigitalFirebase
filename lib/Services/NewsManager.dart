import 'package:EigitalFacebook/Model/News.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class NewsManager {
  News newsList;
  Future getNews() async {
    Response response = await get(
        'http://newsapi.org/v2/top-headlines?country=ph&apiKey=73de1ee2c0a34020a303e7429c4c80aa');
    if (response.statusCode == 200) {
      String data = response.body;
      return newsFromJson(data);
    } else {
      print(response.statusCode);
    }
  }

  filterNews(News filteredNewsList) {
    filteredNewsList.articles.forEach((news) {
      final now = DateTime.now();
      news.comparedHours = now.difference(news.publishedAt).inHours;
      if (news.comparedHours.toString() == '0') {
        news.comparedHours =
            now.difference(news.publishedAt).inMinutes.toString() +
                'minutes ago';
        news.isInMinute = true;
      }
      if (news.urlToImage == null) {
        news.urlToImage =
            'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/600px-No_image_available.svg.png';
      }
    });
    return filteredNewsList;
  }
}
