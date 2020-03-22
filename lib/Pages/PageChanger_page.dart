import 'package:financeapp/Pages/Data_page.dart';
import 'package:financeapp/Pages/StockMarket_page.dart';
import 'package:financeapp/Repos/DataRepo.dart';
import 'package:financeapp/Repos/StockMarketRepo.dart';
import 'package:flutter/material.dart';
import 'package:financeapp/constants.dart';

class PageChanger extends StatefulWidget {
  PageChanger({Key key}) : super(key: key);

  @override
  _PageChangerState createState() => _PageChangerState();
}

DataRepo dataRepo = new DataRepo();

class _PageChangerState extends State<PageChanger> {
  List<Widget> _pages = [
    DataPage(
      future: dataRepo.getData(name: "crypto"),
    ),
    DataPage(
      future: dataRepo.getData(name: "forex"),
    ),
    DataPage(
      future: dataRepo.getData(name: "commodity"),
    ),
    DataPage(
      future: dataRepo.getData(name: "index"),
    ),
    StockMarketPage(
      future: StockMarketRepo().getStock(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return DefaultTabController(
        length: 5,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: kAppBarColor,
            elevation: size.height * 0.01,
            leading: Container(),
            flexibleSpace: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TabBar(
                  isScrollable: true,
                  indicatorColor: kSelectedLabelColor,
                  unselectedLabelColor: kUnselectedLabelColor,
                  labelColor: kSelectedLabelColor,
                  tabs: <Widget>[
                    Tab(text: "Crypto"),
                    Tab(text: "Forex"),
                    Tab(text: "Commodity"),
                    Tab(text: "Indexes"),
                    Tab(text: "Stock Market"),
                  ],
                )
              ],
            ),
          ),
          body: TabBarView(children: _pages),
        ));
  }
}
