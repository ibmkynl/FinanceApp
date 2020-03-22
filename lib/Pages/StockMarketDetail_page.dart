import 'package:financeapp/DetailPages/Graph_page.dart';
import 'package:financeapp/DetailPages/Income_page.dart';
import 'package:financeapp/DetailPages/Info_page.dart';
import 'package:financeapp/DetailPages/KeyMetrics_page.dart';
import 'package:financeapp/Models/StockModel.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class StockMarketDetailPage extends StatefulWidget {
  final StockModel stock;

  StockMarketDetailPage({
    this.stock,
  });
  @override
  _StockMarketDetailPageState createState() => _StockMarketDetailPageState();
}

class _StockMarketDetailPageState extends State<StockMarketDetailPage> {
  @override
  Widget build(BuildContext context) {
    List<Widget> _pages = [
      InfoPage(symbol: widget.stock.symbol),
      GraphPage(
        symbol: widget.stock.symbol,
      ),
      IncomePage(
        symbol: widget.stock.symbol,
      ),
      KeyMetricsPage(
        symbol: widget.stock.symbol,
      )
    ];
    return DefaultTabController(
      length: _pages.length,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kAppBarColor,
          title: Text(widget.stock.name),
          centerTitle: true,
          elevation: 0,
          bottom: TabBar(
            isScrollable: true,
            indicatorColor: Colors.transparent,
            unselectedLabelColor: kUnselectedLabelColor,
            labelColor: kSelectedLabelColor,
            tabs: <Widget>[
              Tab(text: "Info"),
              Tab(text: "Graphs"),
              Tab(text: "Income"),
              Tab(text: "Key metrics"),
            ],
          ),
        ),
        body: TabBarView(children: _pages),
      ),
    );
  }
}
