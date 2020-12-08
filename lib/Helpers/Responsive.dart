import 'package:flutter/material.dart';

Size ds(BuildContext context) {
  // debugPrint('Size = ' + MediaQuery.of(context).size.toString());
  return MediaQuery.of(context).size;
}

double dh(BuildContext context) {
  // debugPrint('Height = ' + displaySize(context).height.toString());
  return ds(context).height;
}

double dw(BuildContext context) {
  // debugPrint('Width = ' + displaySize(context).width.toString());
  return ds(context).width;
}
