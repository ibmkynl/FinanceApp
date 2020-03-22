import 'package:financeapp/Pages/PageChanger_page.dart';
import 'package:flutter/material.dart';
import 'package:financeapp/constants.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: kBodyColor),
      debugShowCheckedModeBanner: false,
      home: Container(
        child: PageChanger(),
      ),
    );
  }
}
