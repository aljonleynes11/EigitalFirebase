import 'dart:async';
import 'package:EigitalFacebook/Helpers/Responsive.dart';
import 'package:EigitalFacebook/Model/Weather.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class SearchBar extends StatefulWidget {
  final TextEditingController controller;
  final Function onTrigger;
  final double width;

  SearchBar({@required this.controller, @required this.onTrigger, this.width});
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 35,
        width: (widget.width != null) ? widget.width : dw(context) * 0.8,
        child: TextFormField(
          controller: widget.controller,
          style: TextStyle(
            fontSize: 15.0,
            fontFamily: 'Open-Sans-Regular',
            color: Colors.white,
          ),
          textAlign: TextAlign.justify,
          decoration: new InputDecoration(
            border: new OutlineInputBorder(
                borderRadius: const BorderRadius.all(
              const Radius.circular(20.0),
            )),
            fillColor: Colors.white10,
            filled: true,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
            suffixIcon: IconButton(
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                onPressed: widget.onTrigger),
            enabledBorder: new OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                const Radius.circular(20.0),
              ),
              borderSide: BorderSide(color: Colors.transparent, width: 1.0),
            ),
            focusedBorder: new OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                const Radius.circular(20.0),
              ),
              borderSide: BorderSide(color: Colors.transparent, width: 1.0),
            ),
            hintText: 'Search',
            hintStyle: TextStyle(
                fontSize: 15,
                color: Colors.white70,
                fontFamily: 'Open-Sans-Regular'),
          ),
          onTap: () {},
        ),
      ),
    );
  }
}
