import 'package:EigitalFacebook/Helpers/Responsive.dart';
import 'package:flutter/material.dart';

class CustomSpacer extends StatelessWidget {
  final double height;

  CustomSpacer({this.height});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: dh(context) * height,
    );
  }
}
