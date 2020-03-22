import 'package:financeapp/Models/StockModel.dart';
import 'package:financeapp/Repos/StockMarketRepo.dart';
import 'package:financeapp/Widgets/DetailBoxWidget.dart';
import 'package:financeapp/Widgets/DetailResultBoxWidget.dart';
import 'package:financeapp/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';

class IncomePage extends StatefulWidget {
  final String symbol;

  IncomePage({
    this.symbol,
  });

  @override
  _IncomePageState createState() => _IncomePageState();
}

class _IncomePageState extends State<IncomePage> {
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
            height: size.height * 1.03,
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
                detailBoxWidget("Revenue", size),
                detailBoxWidget("Revenue growth", size),
                detailBoxWidget("Cost revenue", size),
                detailBoxWidget("Gross profit", size),
                detailBoxWidget("R&D expense", size),
                detailBoxWidget("SG&A Expense", size),
                detailBoxWidget("Operating Income", size),
                detailBoxWidget("Interest Expense", size),
                detailBoxWidget("Earnings before Tax", size),
                detailBoxWidget("Income Tax Expense", size),
                detailBoxWidget("Net income", size),
                detailBoxWidget("Preferred Dividends", size),
                detailBoxWidget("EPS", size),
                detailBoxWidget("EPS diluted", size),
                detailBoxWidget("Weighted Average Shs Out", size),
                detailBoxWidget("Dividend per Share", size),
                detailBoxWidget("Gross Margin", size),
                detailBoxWidget("EBITDA Margin", size),
                detailBoxWidget("EBIT Margin", size),
                detailBoxWidget("Profit Margin", size),
                detailBoxWidget("EBITDA", size),
                detailBoxWidget("EBIT", size),
                detailBoxWidget("Consolidated Income", size),
                detailBoxWidget("Net Profit Margin", size),
              ],
            ),
          ),
          FutureBuilder(
              future: StockMarketRepo().getIncome(name: widget.symbol),
              builder: (context, snap) {
                if (!snap.hasData) {
                  return Container();
                } else {
                  IncomeListModel incomeList = snap.data;
                  return Container(
                    width: size.width * 0.6,
                    height: size.height * 1.03,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: incomeList.incomeList.length,
                        itemBuilder: (BuildContext context, int index) {
                          IncomeModel incomeModel =
                              incomeList.incomeList[index];
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
                                  incomeModel.date,
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              detailResultBoxWidget(
                                  getFormat(double.parse(incomeModel.revenue)),
                                  size),
                              detailResultBoxWidget(
                                  incomeModel.revenueGrowth, size),
                              detailResultBoxWidget(
                                  getFormat(
                                      double.parse(incomeModel.costRevenue)),
                                  size),
                              detailResultBoxWidget(
                                  getFormat(
                                      double.parse(incomeModel.grossProfit)),
                                  size),
                              detailResultBoxWidget(
                                  getFormat(
                                      double.parse(incomeModel.rdExpense)),
                                  size),
                              detailResultBoxWidget(
                                  getFormat(
                                      double.parse(incomeModel.sgaExpense)),
                                  size),
                              detailResultBoxWidget(
                                  getFormat(double.parse(
                                      incomeModel.operatingIncome)),
                                  size),
                              detailResultBoxWidget(
                                  getFormat(double.parse(
                                      incomeModel.interestExpense)),
                                  size),
                              detailResultBoxWidget(
                                  getFormat(double.parse(
                                      incomeModel.earningBeforeTax)),
                                  size),
                              detailResultBoxWidget(
                                  getFormat(double.parse(
                                      incomeModel.incomeTaxExpense)),
                                  size),
                              detailResultBoxWidget(
                                  getFormat(
                                      double.parse(incomeModel.netIncome)),
                                  size),
                              detailResultBoxWidget(
                                  incomeModel.preDividends, size),
                              detailResultBoxWidget(incomeModel.eps, size),
                              detailResultBoxWidget(
                                  incomeModel.epsDiluted, size),
                              detailResultBoxWidget(
                                  getFormat(
                                      double.parse(incomeModel.avgShsOut)),
                                  size),
                              detailResultBoxWidget(
                                  incomeModel.dividendPerShare, size),
                              detailResultBoxWidget(
                                  incomeModel.grossMargin, size),
                              detailResultBoxWidget(
                                  incomeModel.ebitdaMargin, size),
                              detailResultBoxWidget(
                                  incomeModel.ebitMargin, size),
                              detailResultBoxWidget(
                                  incomeModel.profitMargin, size),
                              detailResultBoxWidget(
                                  getFormat(double.parse(incomeModel.ebitda)),
                                  size),
                              detailResultBoxWidget(
                                  getFormat(double.parse(incomeModel.ebit)),
                                  size),
                              detailResultBoxWidget(
                                  getFormat(double.parse(
                                      incomeModel.consolidatedIncome)),
                                  size),
                              detailResultBoxWidget(
                                  incomeModel.netProfitMargin, size),
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
