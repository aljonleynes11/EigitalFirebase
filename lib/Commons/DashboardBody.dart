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
  final Color textColor;
  final Color bgColor;
  final Color buttonColor;

  DashboardBody({
    @required this.news,
    this.textColor,
    this.bgColor,
    this.buttonColor,
  });

  @override
  _DashboardBodyState createState() => _DashboardBodyState();
}

class _DashboardBodyState extends State<DashboardBody> {
  toArticle() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ReadArticle(
          article: widget.news,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Container(
          // decoration: BoxDecoration(
          //   borderRadius: BorderRadius.circular(30),
          //
          // ),
          color: (widget.bgColor != null) ? widget.bgColor : Colors.black54,
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            children: [
              AutoSizeText(widget.news.source.name,
                  style: TextStyle(
                      color: (widget.textColor != null)
                          ? widget.textColor
                          : Colors.grey)),
              AutoSizeText(
                  (widget.news.isInMinute == false)
                      ? widget.news.comparedHours.toString() + ' hour(s) ago'
                      : widget.news.comparedHours.toString(),
                  style: TextStyle(
                      color: (widget.textColor != null)
                          ? widget.textColor
                          : Colors.grey)),
              CustomSpacer(height: 0.01),
              Container(
                  height: dh(context) * 0.3,
                  width: dw(context) * 1,
                  child: Image.network(widget.news.urlToImage.toString())),
              CustomSpacer(height: 0.01),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: AutoSizeText(widget.news.title,
                    style: TextStyle(
                        color: (widget.textColor != null)
                            ? widget.textColor
                            : Colors.grey)),
              ),
              CustomSpacer(height: 0.02),
              InkWell(
                onTap: () => Router(myContext: context).toArticle(widget.news),
                child: Container(
                    height: dh(context) * 0.07,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 130, vertical: 10),
                    width: dw(context) * 1,
                    color: (widget.buttonColor != null)
                        ? widget.buttonColor
                        : Colors.blue,
                    child: Center(
                      child: Text("Read More"),
                    )),
              ),
              //  onPressed: () => goToArticle(widget.news),
            ],
          )),
    );
  }
}
