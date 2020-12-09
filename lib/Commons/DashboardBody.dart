import 'package:EigitalFacebook/Helpers/CustomSpacer.dart';
import 'package:EigitalFacebook/Helpers/Responsive.dart';
import 'package:EigitalFacebook/Model/News.dart';
import 'package:EigitalFacebook/Model/Weather.dart';
import 'package:EigitalFacebook/Router.dart';
import 'package:EigitalFacebook/Screens/Dashboard.dart';
import 'package:EigitalFacebook/Screens/ReadArticle.dart';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class DashboardBody extends StatefulWidget {
  final Article news;
  bool isEven;

  DashboardBody({
    @required this.news,
    this.isEven,
  });

  @override
  _DashboardBodyState createState() => _DashboardBodyState();
}

class _DashboardBodyState extends State<DashboardBody> {
  _toArticle(article) {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => ReadArticle(
    //       article: widget.news,
    //     ),
    //   ),
    // );
    Router(myContext: context).toArticle(article);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _toArticle(widget.news),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        height: dh(context) * 0.4,
        width: dw(context) * 1,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                  widget.news.urlToImage,
                ),
                fit: BoxFit.fill,
                colorFilter: ColorFilter.mode(
                    Colors.red.withOpacity(1), BlendMode.dstATop))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              height: dh(context) * 0.15,
              decoration: BoxDecoration(
                  color: (widget.isEven == false)
                      ? Colors.black.withBlue(60).withOpacity(0.7)
                      : Colors.black.withRed(60).withOpacity(0.7),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(20))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                      child: Text(
                          (widget.news.isInMinute == false)
                              ? widget.news.comparedHours.toString() +
                                  ' hour(s) ago - ' +
                                  widget.news.source.name
                              : widget.news.comparedHours.toString() +
                                  ' - ' +
                                  widget.news.source.name,
                          style: TextStyle(fontSize: 12))),
                  Text(widget.news.title, style: TextStyle(color: Colors.white))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
