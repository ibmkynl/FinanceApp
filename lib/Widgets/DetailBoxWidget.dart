import 'package:financeapp/constants.dart';
import 'package:flutter/material.dart';

Widget detailBoxWidget(text, size) {
  return Container(
    width: size.height * 0.4,
    height: size.height * 0.041,
    padding: EdgeInsets.all(size.height * 0.01),
    decoration: BoxDecoration(
        color: kAppBarColor,
        border: Border(
          right: BorderSide(color: kSelectedLabelColor),
          bottom: BorderSide(color: kUnselectedLabelColor),
        )),
    child: Text(
      text,
      style: TextStyle(
        color: Colors.white,
      ),
    ),
  );
}
