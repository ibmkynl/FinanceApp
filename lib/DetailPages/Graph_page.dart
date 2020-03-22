import 'package:financeapp/Models/DataModel.dart';
import 'package:financeapp/Repos/DataRepo.dart';
import 'package:financeapp/Widgets/DetailBarChartWidget.dart';
import 'package:financeapp/Widgets/DetailChartWidget.dart';
import 'package:financeapp/Widgets/DetailResultWidget.dart';
import 'package:financeapp/Widgets/DetailTextWidget.dart';
import 'package:financeapp/constants.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';

class GraphPage extends StatefulWidget {
  final String symbol;

  GraphPage({
    this.symbol,
  });

  @override
  _GraphPageState createState() => _GraphPageState();
}

class _GraphPageState extends State<GraphPage> {
  String time = "1hour";
  int counter = 24;

  getFormat(int value) {
    FlutterMoneyFormatter result = new FlutterMoneyFormatter(
        amount: value.toDouble(),
        settings: MoneyFormatterSettings(symbol: 'USD', fractionDigits: 0));

    return result.output.nonSymbol;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(size.height * 0.01),
          height: size.height * 0.2,
          color: kAppBarColor,
          child: FutureBuilder(
              future: DataRepo().getData(name: widget.symbol),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Container();
                } else {
                  DataListModel data = snapshot.data;
                  DataModel dataModel = data.dataList.first;
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  detailTextWidget(text: "Pe: "),
                                  detailResultWidget(
                                      text: dataModel.pe != null
                                          ? dataModel.pe.toStringAsFixed(2)
                                          : "Unknown")
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  detailTextWidget(text: "Today: "),
                                  detailResultWidget(
                                      text: dataModel.dayLow.toString() +
                                          "-" +
                                          dataModel.dayHigh.toString())
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  detailTextWidget(text: "Year: "),
                                  detailResultWidget(
                                      text: dataModel.yearLow.toString() +
                                          "-" +
                                          dataModel.yearHigh.toString())
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  detailTextWidget(text: "Volume: "),
                                  detailResultWidget(
                                      text: '\u0024' +
                                          getFormat(dataModel.volume))
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  detailTextWidget(text: "Shares: "),
                                  detailResultWidget(
                                      text: getFormat(dataModel.shares))
                                ],
                              )
                            ],
                          )),
                          SizedBox(
                            width: size.width * 0.02,
                          ),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  detailTextWidget(text: "Eps: "),
                                  detailResultWidget(
                                      text: dataModel.eps.toStringAsFixed(2))
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  detailTextWidget(text: "Open: "),
                                  detailResultWidget(
                                      text: dataModel.open.toString())
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  detailTextWidget(text: "Pre close: "),
                                  detailResultWidget(
                                      text: dataModel.preClose.toString())
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  detailTextWidget(text: "Price avg50: "),
                                  detailResultWidget(
                                      text: dataModel.priceAvg50
                                          .toStringAsFixed(3))
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  detailTextWidget(text: "Price avg200: "),
                                  detailResultWidget(
                                      text: dataModel.priceAvg200
                                          .toStringAsFixed(3))
                                ],
                              ),
                            ],
                          ))
                        ],
                      ),
                      Container(
                        color: kAppBarColor,
                        padding: EdgeInsets.all(size.height * 0.01),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    ],
                  );
                }
              }),
        ),
        Container(
          height: size.height * 0.63,
          child: FutureBuilder(
            future: DataRepo().getChartData(widget.symbol, time),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Container();
              } else {
                ChartModel chartModel = snapshot.data;
                int a = 0, maxVol = 0;
                double biggest = 0, lowest;
                List<FlSpot> chartData = [];
                List<BarChartGroupData> barGroups = [];
                lowest = chartModel.chartData.first['close'];
                chartModel.chartData.forEach((value) {
                  //This is because data from geCrypto() is not matching with getChartData so need to find which value is lowest and which is biggest with this.
                  if (value['close'] < lowest) lowest = value['close'];
                  if (value['close'] > biggest) biggest = value['close'];
                  if (value['volume'] > maxVol) maxVol = value['volume'];
                  //this if needed because api doesn't allow to pick specific date. This will take and create last 24 hour of change chart
                  if (a < counter) {
                    chartData.add(FlSpot(a.toDouble(), value['close']));
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
                        horizontalInterval: (biggest - lowest) * 0.1,
                        size: size,
                        chartData: chartData),
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
              }
            },
          ),
        )
      ],
    );
  }
}
