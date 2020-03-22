import 'package:flutter/material.dart';

const String uniAlphaKey = "Your-Api-Key";
const kUnselectedLabelColor = Color(0xFF616267);
const kSelectedLabelColor = Color(0xFF00A273);
const kAppBarColor = Color(0xFF202125);
const kBodyColor = Color(0xFF2c2d33);

void pageScroll({Widget pageName, context}) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) {
        return pageName;
      },
    ),
  );
}
