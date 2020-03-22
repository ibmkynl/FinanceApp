import 'package:financeapp/Models/DataModel.dart';
import 'package:financeapp/Repos/DataRepo.dart';
import 'package:financeapp/Widgets/DetailBarChartWidget.dart';
import 'package:financeapp/Widgets/DetailChartWidget.dart';
import 'package:financeapp/Widgets/DetailResultWidget.dart';
import 'package:financeapp/Widgets/DetailTextWidget.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';

import '../constants.dart';

class DataDetailPage extends StatefulWidget {
  final DataModel dataModel;

  DataDetailPage({
    this.dataModel,
  });

  @override
  _DataDetailPageState createState() => _DataDetailPageState();
}

class _DataDetailPageState extends State<DataDetailPage> {
  DataRepo dataRepo = new DataRepo();
  String time = "1hour";
  int counter = 24;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FlutterMoneyFormatter price = new FlutterMoneyFormatter(
        amount: widget.dataModel.price,
        settings: MoneyFormatterSettings(
            symbol: 'USD',
            fractionDigits: widget.dataModel.price < 10 ? 5 : 2));
    FlutterMoneyFormatter marketCap = new FlutterMoneyFormatter(
        amount:
            widget.dataModel.marketCap != null ? widget.dataModel.marketCap : 0,
        settings: MoneyFormatterSettings(symbol: 'USD', fractionDigits: 0));
    FlutterMoneyFormatter volume = new FlutterMoneyFormatter(
        amount: widget.dataModel.volume.toDouble(),
        settings: MoneyFormatterSettings(symbol: 'USD', fractionDigits: 0));
    FlutterMoneyFormatter avgVolume = new FlutterMoneyFormatter(
        amount: widget.dataModel.avgVolume.toDouble(),
        settings: MoneyFormatterSettings(symbol: 'USD', fractionDigits: 0));
    DateTime timestamp = new DateTime.fromMillisecondsSinceEpoch(
        widget.dataModel.timestamp * 1000);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kAppBarColor,
        elevation: 0,
        title: Text(widget.dataModel.symbol),
        centerTitle: true,
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          if (orientation == Orientation.portrait) {
            return Column(
              children: <Widget>[
                Container(
                  color: kAppBarColor,
                  padding: EdgeInsets.all(size.height * 0.01),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: size.width * 0.45,
                            child: Text(
                              widget.dataModel.name,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: size.height * 0.03),
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              Text(
                                timestamp.day.toString() +
                                    "/" +
                                    timestamp.month.toString() +
                                    "/" +
                                    timestamp.year.toString() +
                                    " ",
                                style: TextStyle(color: Colors.white),
                              ),
                              Text(
                                timestamp.hour.toString() +
                                    ":" +
                                    timestamp.minute.toString(),
                                style: TextStyle(color: Colors.white),
                              )
                            ],
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Icon(
                                widget.dataModel.changePer < 0
                                    ? Icons.arrow_downward
                                    : Icons.arrow_upward,
                                color: widget.dataModel.change < 0
                                    ? Colors.red
                                    : Colors.green,
                              ),
                              Text(
                                '\u0024' + price.output.nonSymbol.toString(),
                                style: TextStyle(
                                    fontSize: size.height * 0.04,
                                    color: kSelectedLabelColor),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Text(
                                (widget.dataModel.change < 0 ? "-" : "+") +
                                    (widget.dataModel.change < 0
                                        ? (widget.dataModel.change * -1)
                                            .toStringAsFixed(
                                                widget.dataModel.change * -1 < 0
                                                    ? 5
                                                    : 3)
                                            .toString()
                                        : widget.dataModel.change
                                            .toStringAsFixed(
                                                widget.dataModel.change < 0
                                                    ? 5
                                                    : 3)
                                            .toString()),
                                style: TextStyle(
                                    fontSize: size.height * 0.025,
                                    color: widget.dataModel.change < 0
                                        ? Colors.red
                                        : Colors.green),
                              ),
                              Text(
                                (widget.dataModel.changePer < 0 ? "(-" : "(+") +
                                    "%" +
                                    (widget.dataModel.changePer < 0
                                        ? (widget.dataModel.changePer * -1)
                                            .toStringAsFixed(3)
                                            .toString()
                                        : widget.dataModel.changePer
                                            .toStringAsFixed(3)
                                            .toString()) +
                                    ")",
                                style: TextStyle(
                                    color: widget.dataModel.changePer < 0
                                        ? Colors.red
                                        : Colors.green,
                                    fontSize: size.height * 0.02),
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  color: kAppBarColor,
                  padding: EdgeInsets.symmetric(
                      vertical: size.height * 0.03,
                      horizontal: size.height * 0.01),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                detailTextWidget(text: "Pre close: "),
                                detailResultWidget(
                                  text: widget.dataModel.preClose.toString(),
                                )
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                detailTextWidget(text: "Open: "),
                                detailResultWidget(
                                  text: widget.dataModel.open.toString(),
                                )
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                detailTextWidget(text: "Today: "),
                                detailResultWidget(
                                  text: widget.dataModel.dayLow.toStringAsFixed(
                                          widget.dataModel.dayLow < 10
                                              ? 6
                                              : 2) +
                                      "-" +
                                      widget.dataModel.dayHigh.toStringAsFixed(
                                          widget.dataModel.dayHigh < 10
                                              ? 6
                                              : 2),
                                )
                              ],
                            ),
                            widget.dataModel.marketCap != null
                                ? Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      detailTextWidget(text: "Year: "),
                                      detailResultWidget(
                                          text: widget.dataModel.yearLow
                                                  .toStringAsFixed(
                                                      widget.dataModel.yearLow <
                                                              10
                                                          ? 5
                                                          : 2) +
                                              "-" +
                                              widget.dataModel.yearHigh
                                                  .toStringAsFixed(widget
                                                              .dataModel
                                                              .yearHigh <
                                                          10
                                                      ? 5
                                                      : 2))
                                    ],
                                  )
                                : Container(),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.02,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            widget.dataModel.marketCap != null
                                ? Container()
                                : Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      detailTextWidget(text: "Year: "),
                                      detailResultWidget(
                                          text: widget.dataModel.yearLow
                                                  .toStringAsFixed(
                                                      widget.dataModel.yearLow <
                                                              10
                                                          ? 5
                                                          : 2) +
                                              "-" +
                                              widget.dataModel.yearHigh
                                                  .toStringAsFixed(widget
                                                              .dataModel
                                                              .yearHigh <
                                                          10
                                                      ? 5
                                                      : 2))
                                    ],
                                  ),
                            widget.dataModel.marketCap != null
                                ? Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      detailTextWidget(text: "Market cap: "),
                                      detailResultWidget(
                                          text: '\u0024' +
                                              marketCap
                                                  .output.compactNonSymbol),
                                    ],
                                  )
                                : Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      detailTextWidget(text: "Avg 200: "),
                                      detailResultWidget(
                                          text: widget.dataModel.priceAvg200
                                              .toStringAsFixed(
                                                  widget.dataModel.priceAvg200 <
                                                          10
                                                      ? 5
                                                      : 2))
                                    ],
                                  ),
                            widget.dataModel.marketCap != null
                                ? Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      detailTextWidget(text: "Vol/Avg Vol: "),
                                      detailResultWidget(
                                        text: '\u0024' +
                                            volume.output.compactNonSymbol
                                                .toString() +
                                            "/" +
                                            avgVolume.output.compactNonSymbol
                                                .toString(),
                                      )
                                    ],
                                  )
                                : Container(),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                detailTextWidget(text: "Avg 50: "),
                                detailResultWidget(
                                    text: widget.dataModel.priceAvg50
                                        .toStringAsFixed(
                                            widget.dataModel.priceAvg50 < 10
                                                ? 5
                                                : 2))
                              ],
                            ),
                            widget.dataModel.marketCap != null
                                ? Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      detailTextWidget(text: "Avg 200: "),
                                      detailResultWidget(
                                          text: widget.dataModel.priceAvg200
                                              .toStringAsFixed(
                                                  widget.dataModel.priceAvg200 <
                                                          10
                                                      ? 5
                                                      : 2))
                                    ],
                                  )
                                : Container()
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                widget.dataModel.marketCap == null
                    ? Container(
                        color: kAppBarColor,
                        padding: EdgeInsets.all(size.height * 0.01),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  time = "1min";
                                  counter = 60;
                                });
                              },
                              child: Text(
                                "1 min",
                                style: TextStyle(
                                    color: time == "1min"
                                        ? kSelectedLabelColor
                                        : kUnselectedLabelColor),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  time = "5min";
                                  counter = 60;
                                });
                              },
                              child: Text(
                                "5 min",
                                style: TextStyle(
                                    color: time == "5min"
                                        ? kSelectedLabelColor
                                        : kUnselectedLabelColor),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  time = "15min";
                                  counter = 24;
                                });
                              },
                              child: Text(
                                "15 min",
                                style: TextStyle(
                                    color: time == "15min"
                                        ? kSelectedLabelColor
                                        : kUnselectedLabelColor),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  time = "30min";
                                  counter = 24;
                                });
                              },
                              child: Text(
                                "30 min",
                                style: TextStyle(
                                    color: time == "30min"
                                        ? kSelectedLabelColor
                                        : kUnselectedLabelColor),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  time = "1hour";
                                  counter = 24;
                                });
                              },
                              child: Text(
                                "1 hour",
                                style: TextStyle(
                                    color: time == "1hour"
                                        ? kSelectedLabelColor
                                        : kUnselectedLabelColor),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(),
                Expanded(
                  child: Container(
                      width: size.width,
                      height: size.height * 0.6,
                      child: FutureBuilder(
                        future: dataRepo.getChartData(
                            widget.dataModel.symbol, time),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot == null) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (snapshot.data != null) {
                            ChartModel chartModel = snapshot.data;
                            int a = 0, maxVol = 0;
                            double biggest = 0,
                                lowest = widget.dataModel.dayLow;
                            List<FlSpot> chartData = [];
                            List<BarChartGroupData> barGroups = [];
                            chartModel.chartData.forEach((value) {
                              //This is because data from geCrypto() is not matching with getChartData so need to find which value is lowest and which is biggest with this.
                              if (value['close'] < lowest)
                                lowest = value['close'];
                              if (value['close'] > biggest)
                                biggest = value['close'];
                              if (value['volume'] > maxVol)
                                maxVol = value['volume'];
                              //this if needed because api doesn't allow to pick specific date. This will take and create last 24 hour of change chart
                              if (a < counter) {
                                chartData
                                    .add(FlSpot(a.toDouble(), value['close']));
                                barGroups.add(BarChartGroupData(
                                  x: a,
                                  barRods: [
                                    BarChartRodData(
                                        width: counter < 30 ? 10 : 3,
                                        y: value['volume'] * 1.0,
                                        color: kSelectedLabelColor,
                                        borderRadius: BorderRadius.circular(0))
                                  ],
                                ));
                                a++;
                              }
                            });
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                detailChartWidget(
                                    minX: 0.0,
                                    maxX: chartData.length - 1.toDouble(),
                                    minY: lowest,
                                    maxY: biggest * 1,
                                    horizontalInterval:
                                        (biggest - lowest) * 0.1,
                                    size: size,
                                    chartData: chartData),
                                widget.dataModel.marketCap != null
                                    ? Padding(
                                        padding:
                                            EdgeInsets.all(size.height * 0.01),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: <Widget>[
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  time = "1min";
                                                  counter = 60;
                                                });
                                              },
                                              child: Text(
                                                "1 min",
                                                style: TextStyle(
                                                    color: time == "1min"
                                                        ? kSelectedLabelColor
                                                        : kUnselectedLabelColor),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  time = "5min";
                                                  counter = 60;
                                                });
                                              },
                                              child: Text(
                                                "5 min",
                                                style: TextStyle(
                                                    color: time == "5min"
                                                        ? kSelectedLabelColor
                                                        : kUnselectedLabelColor),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  time = "15min";
                                                  counter = 24;
                                                });
                                              },
                                              child: Text(
                                                "15 min",
                                                style: TextStyle(
                                                    color: time == "15min"
                                                        ? kSelectedLabelColor
                                                        : kUnselectedLabelColor),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  time = "30min";
                                                  counter = 24;
                                                });
                                              },
                                              child: Text(
                                                "30 min",
                                                style: TextStyle(
                                                    color: time == "30min"
                                                        ? kSelectedLabelColor
                                                        : kUnselectedLabelColor),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  time = "1hour";
                                                  counter = 24;
                                                });
                                              },
                                              child: Text(
                                                "1 hour",
                                                style: TextStyle(
                                                    color: time == "1hour"
                                                        ? kSelectedLabelColor
                                                        : kUnselectedLabelColor),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    : Container(),
                                Container(
                                  height: size.height * 0.15,
                                  padding: EdgeInsets.all(size.height * 0.01),
                                  child: detailBarChartWidget(
                                      barGroups: barGroups,
                                      maxY: maxVol.toDouble(),
                                      horizontalInterval: 10.0),
                                )
                              ],
                            );
                          } else {
                            return Container();
                          }
                        },
                      )),
                ),
              ],
            );
          } else {
            return Padding(
              padding: EdgeInsets.all(size.height * 0.01),
              child: Container(
                width: size.width,
                height: size.height,
                color: Colors.blue,
              ),
            );
          }
        },
      ),
    );
  }
}
