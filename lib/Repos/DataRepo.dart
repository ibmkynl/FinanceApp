import 'dart:convert';

import 'package:financeapp/Models/DataModel.dart' as DataListModel;
import 'package:http/http.dart' as http;

class DataRepo {
  Future getData({name}) async {
    print(name);
    String link;
    if (name != "crypto" &&
        name != "index" &&
        name != "commodity" &&
        name != "forex") {
      link = "https://financialmodelingprep.com/api/v3/quote/$name";
    } else {
      link = "https://financialmodelingprep.com/api/v3/quotes/$name";
    }

    var res = await http.get(link);

    var content = res.body;
    try {
      DataListModel.DataListModel dataListModel =
          DataListModel.DataListModel.fromJson(jsonDecode(content));
      return dataListModel;
    } catch (error) {
      print(error);
      return null;
    }
  }

  Future getChartData(String name, String time) async {
    String chartLink =
        "https://financialmodelingprep.com/api/v3/historical-chart/$time/$name";
    var chartRes = await http.get(chartLink);
    var chartContent = chartRes.body;

    try {
      DataListModel.ChartModel chartModel =
          DataListModel.ChartModel.fromJson(jsonDecode(chartContent));

      return chartModel;
    } catch (error) {
      print(error);
      return null;
    }
  }
}
