import 'package:EigitalFacebook/Helpers/CustomSpacer.dart';
import 'package:EigitalFacebook/Model/News.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:link_text/link_text.dart';

class ReadArticle extends StatelessWidget {
  final Article article;
  final Color color;
  ReadArticle({@required this.article, @required this.color});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(''),
          backgroundColor: Colors.black54,
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: articlePage(),
          ),
        ));
  }

  articlePage() {
    return Card(
      child: Container(
        decoration: BoxDecoration(color: color),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            AutoSizeText(article.comparedHours.toString() + ' hour(s) ago'),
            CustomSpacer(
              height: 0.04,
            ),
            Text(
              article.title,
              style: TextStyle(fontSize: 25),
              textAlign: TextAlign.center,
            ),
            CustomSpacer(
              height: 0.04,
            ),
            Image.network(article.urlToImage),
            CustomSpacer(
              height: 0.04,
            ),
            Text(
              (article.description != null) ? article.description : '',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.left,
            ),
            CustomSpacer(
              height: 0.04,
            ),
            LinkText(
              text: 'Read more : ' + article.url,
              textAlign: TextAlign.left,
            ),
            CustomSpacer(
              height: 0.04,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  (article.source.name != null)
                      ? 'By ' + article.source.name
                      : '',
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
