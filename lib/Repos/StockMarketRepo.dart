import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:financeapp/Models/StockModel.dart' as StockModel;

class StockMarketRepo {
  Future getStock() async {
    String link = "https://financialmodelingprep.com/api/v3/company/stock/list";
    var res = await http.get(link);
    var content = res.body;

    try {
      StockModel.StockList stockList =
          StockModel.StockList.fromJson(jsonDecode(content));
      return stockList;
    } catch (error) {
      print(error);
    }
  }

  Future getStockInfo({name}) async {
    String link =
        "https://financialmodelingprep.com/api/v3/company/profile/$name";
    var res = await http.get(link);
    var content = res.body;

    try {
      StockModel.StockInfoModel stockInfoModel =
          StockModel.StockInfoModel.fromJson(jsonDecode(content));
      return stockInfoModel;
    } catch (error) {
      print(error);
    }
  }

  Future getIncome({name}) async {
    String link =
        "https://financialmodelingprep.com/api/v3/financials/income-statement/$name?period=quarter";
    var res = await http.get(link);
    var content = res.body;

    try {
      StockModel.IncomeListModel incomeListModel =
          StockModel.IncomeListModel.fromJson(jsonDecode(content));
      return incomeListModel;
    } catch (error) {
      print(error);
    }
  }

  Future getMetrics({name}) async {
    String link =
        "https://financialmodelingprep.com/api/v3/company-key-metrics/$name?period=quarter";
    var res = await http.get(link);
    var content = res.body;

    try {
      StockModel.KeyMetricListModel keyMetricListModel =
          StockModel.KeyMetricListModel.fromJson(jsonDecode(content));
      return keyMetricListModel;
    } catch (error) {
      print(error);
    }
  }
}
