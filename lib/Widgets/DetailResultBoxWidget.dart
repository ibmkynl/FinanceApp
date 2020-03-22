import 'package:flutter/material.dart';

import '../constants.dart';

Widget detailResultBoxWidget(text, size) {
  return Container(
    width: size.width * 0.4,
    height: size.height * 0.041,
    padding: EdgeInsets.all(size.height * 0.01),
    decoration: BoxDecoration(
        color: kBodyColor,
        border: Border(
          bottom: BorderSide(color: kUnselectedLabelColor),
        )),
    child: Text(
      text,
      textAlign: TextAlign.end,
      style: TextStyle(
        color: Colors.white,
      ),
    ),
  );
}
