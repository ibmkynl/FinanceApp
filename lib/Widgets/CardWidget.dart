import 'package:financeapp/Models/DataModel.dart';
import 'package:financeapp/Pages/DataDetail_page.dart';
import 'package:financeapp/Repos/DataRepo.dart';
import 'package:financeapp/Widgets/CardChartWidget.dart';
import 'package:financeapp/constants.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';

Widget cardWidget(DataModel dataModel, size, context) {
  DataRepo dataRepo = new DataRepo();
  FlutterMoneyFormatter price = new FlutterMoneyFormatter(
      amount: dataModel.price,
      settings: MoneyFormatterSettings(
          symbol: 'USD', fractionDigits: dataModel.price < 1 ? 5 : 2));

  return GestureDetector(
    onTap: () {
      pageScroll(
          pageName: DataDetailPage(
            dataModel: dataModel,
          ),
          context: context);
    },
    child: Padding(
      padding: EdgeInsets.symmetric(
          vertical: size.height * 0.005, horizontal: size.height * 0.01),
      child: Container(
        color: kAppBarColor,
        padding: EdgeInsets.all(size.height * 0.01),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              dataModel.symbol,
              style: TextStyle(
                  fontSize: size.height * 0.025, color: kSelectedLabelColor),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                    height: size.height * 0.08,
                    width: size.width * 0.5,
                    child: FutureBuilder(
                      future: dataRepo.getChartData(dataModel.symbol, "1hour"),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot == null) {
                          return Container();
                        }
                        if (snapshot.data != null) {
                          ChartModel chartModel = snapshot.data;
                          int a = 0;
                          double biggest = 0, lowest = dataModel.dayLow;
                          List<FlSpot> chartData = [];
                          chartModel.chartData.forEach((value) {
                            //This is because data from geCrypto() is not matching with getChartData so need to find which value is lowest and which is biggest with this.
                            if (value['close'] < lowest)
                              lowest = value['close'];
                            if (value['close'] > biggest)
                              biggest = value['close'];

                            //this if needed because api doesn't allow to pick specific date. This will take and create last 24 hour of change chart
                            if (a < 24) {
                              chartData
                                  .add(FlSpot(a.toDouble(), value['close']));

                              a++;
                            }
                          });
                          //Not all coins have
                          return pagesChartWidget(
                              0.0,
                              chartData.length - 1.toDouble(),
                              lowest,
                              biggest,
                              size,
                              chartData);
                        } else {
                          return Container();
                        }
                      },
                    )),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      (dataModel.changePer < 0 ? "-" : "+") +
                          "%" +
                          (dataModel.changePer < 0
                              ? (dataModel.changePer * -1)
                                  .toStringAsFixed(3)
                                  .toString()
                              : dataModel.changePer
                                  .toStringAsFixed(3)
                                  .toString()),
                      style: TextStyle(
                          color: dataModel.changePer < 0
                              ? Colors.red
                              : Colors.green,
                          fontSize: size.height * 0.02),
                    ),
                    Text(
                      (dataModel.change < 0 ? "-" : "+") +
                          (dataModel.change < 0
                              ? (dataModel.change * -1)
                                  .toStringAsFixed(
                                      dataModel.change * -1 < 0 ? 6 : 3)
                                  .toString()
                              : dataModel.change
                                  .toStringAsFixed(dataModel.change < 0 ? 6 : 3)
                                  .toString()),
                      style: TextStyle(
                          fontSize: size.height * 0.025,
                          color:
                              dataModel.change < 0 ? Colors.red : Colors.green),
                    ),
                    Text(
                      '\u0024' + price.output.nonSymbol.toString(),
                      style: TextStyle(
                          fontSize: size.height * 0.03,
                          color: kSelectedLabelColor),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    ),
  );
}
/**/
