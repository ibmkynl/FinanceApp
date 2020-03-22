import 'package:financeapp/Models/StockModel.dart';
import 'package:financeapp/Repos/StockMarketRepo.dart';
import 'package:financeapp/Widgets/DetailBoxWidget.dart';
import 'package:financeapp/Widgets/DetailResultBoxWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';

import '../constants.dart';

class KeyMetricsPage extends StatefulWidget {
  final String symbol;

  KeyMetricsPage({
    this.symbol,
  });

  @override
  _KeyMetricsPageState createState() => _KeyMetricsPageState();
}

class _KeyMetricsPageState extends State<KeyMetricsPage> {
  getFormat(double value) {
    FlutterMoneyFormatter result = new FlutterMoneyFormatter(
        amount: value,
        settings: MoneyFormatterSettings(symbol: 'USD', fractionDigits: 0));

    return '\u0024' + result.output.nonSymbol;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Row(
        children: <Widget>[
          Container(
            width: size.width * 0.4,
            height: size.height * 1.028,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: size.height * 0.4,
                  padding: EdgeInsets.all(size.height * 0.01),
                  decoration: BoxDecoration(
                      color: kBodyColor,
                      border: Border(
                        right: BorderSide(color: kSelectedLabelColor),
                        bottom: BorderSide(color: kSelectedLabelColor),
                      )),
                  child: Text(
                    "Date",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
                detailBoxWidget("Revenue per Share", size),
                detailBoxWidget("Net Income per Share", size),
                detailBoxWidget("Operating Cash Flow per Share", size),
                detailBoxWidget("Free Cash Flow per Share", size),
                detailBoxWidget("Cash per Share", size),
                detailBoxWidget("Book Value per Share", size),
                detailBoxWidget("Tangible Book Value per Share", size),
                detailBoxWidget("Shareholders Equity per Share", size),
                detailBoxWidget("Market Cap", size),
                detailBoxWidget("Enterprise Value", size),
                detailBoxWidget("PE ratio", size),
                detailBoxWidget("Price to Sales Ratio", size),
                detailBoxWidget("POCF ratio", size),
                detailBoxWidget("PFCF ratio", size),
                detailBoxWidget("PB ratio", size),
                detailBoxWidget("PTB ratio", size),
                detailBoxWidget("EV to Sales", size),
                detailBoxWidget("Enterprise Value over EBITDA", size),
                detailBoxWidget("EV to Free cash flow", size),
                detailBoxWidget("Earnings Yield", size),
                detailBoxWidget("Free Cash Flow Yield", size),
                detailBoxWidget("Debt to Equity", size),
                detailBoxWidget("Debt to Assets", size),
                detailBoxWidget("Interest Coverage", size),
              ],
            ),
          ),
          FutureBuilder(
              future: StockMarketRepo().getMetrics(name: widget.symbol),
              builder: (context, snap) {
                if (!snap.hasData) {
                  return Container();
                } else {
                  KeyMetricListModel keyList = snap.data;
                  return Container(
                    width: size.width * 0.6,
                    height: size.height * 1.028,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: keyList.metricList.length,
                        itemBuilder: (BuildContext context, int index) {
                          KeyMetricModel keyModel = keyList.metricList[index];
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                width: size.width * 0.4,
                                padding: EdgeInsets.all(size.height * 0.01),
                                decoration: BoxDecoration(
                                    color: kBodyColor,
                                    border: Border(
                                      bottom: BorderSide(
                                          color: kSelectedLabelColor),
                                    )),
                                child: Text(
                                  keyModel.date,
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              detailResultBoxWidget(
                                  keyModel.revenuePerShare, size),
                              detailResultBoxWidget(
                                  keyModel.netIncomePerShare, size),
                              detailResultBoxWidget(
                                  keyModel.operatingFlowPerShare, size),
                              detailResultBoxWidget(
                                  keyModel.freeCashPerShare, size),
                              detailResultBoxWidget(
                                  keyModel.cashPerShare, size),
                              detailResultBoxWidget(
                                  keyModel.bValuePerShare, size),
                              detailResultBoxWidget(
                                  keyModel.tValuePerShare, size),
                              detailResultBoxWidget(
                                  keyModel.sEquityPerShare, size),
                              detailResultBoxWidget(
                                  getFormat(double.parse(keyModel.marketCap)),
                                  size),
                              detailResultBoxWidget(
                                  getFormat(
                                      double.parse(keyModel.enterpriseValue)),
                                  size),
                              detailResultBoxWidget(keyModel.peRatio, size),
                              detailResultBoxWidget(
                                  keyModel.priceSalesRatio, size),
                              detailResultBoxWidget(keyModel.pocf, size),
                              detailResultBoxWidget(keyModel.pfcf, size),
                              detailResultBoxWidget(keyModel.pb, size),
                              detailResultBoxWidget(keyModel.ptb, size),
                              detailResultBoxWidget(keyModel.ev, size),
                              detailResultBoxWidget(
                                  keyModel.evOverEbitda, size),
                              detailResultBoxWidget(keyModel.evCashFLow, size),
                              detailResultBoxWidget(
                                  keyModel.earningsYield, size),
                              detailResultBoxWidget(
                                  keyModel.freeCashFlowYield, size),
                              detailResultBoxWidget(keyModel.deptEquity, size),
                              detailResultBoxWidget(keyModel.deptAssets, size),
                              detailResultBoxWidget(
                                  keyModel.interestCoverage, size),
                            ],
                          );
                        }),
                  );
                }
              }),
        ],
      ),
    );
  }
}
