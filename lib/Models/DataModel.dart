class DataListModel {
  List<DataModel> dataList;
  DataListModel({
    this.dataList,
  });

  DataListModel.fromJson(List<dynamic> json) {
    dataList = new List<DataModel>();
    json.forEach((value) {
      //this if check the name because some of coins doesn't have and therefore their chart data cannot found.
      if (value["name"] != null) {
        dataList.add(DataModel.fromJson(value));
      }
    });
  }
}

class DataModel {
  String name;
  String symbol;
  double price;
  double changePer;
  double change;
  double dayLow;
  double dayHigh;
  double yearLow;
  double yearHigh;
  double marketCap;
  double priceAvg50;
  double priceAvg200;
  int volume;
  int avgVolume;
  double open;
  double preClose;
  double pe;
  double eps;
  int shares;
  int timestamp;

  DataModel({
    this.pe,
    this.eps,
    this.shares,
    this.avgVolume,
    this.change,
    this.changePer,
    this.dayHigh,
    this.dayLow,
    this.marketCap,
    this.name,
    this.open,
    this.preClose,
    this.price,
    this.priceAvg200,
    this.priceAvg50,
    this.symbol,
    this.timestamp,
    this.volume,
    this.yearHigh,
    this.yearLow,
  });

  DataModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    symbol = json['symbol'];
    price = json['price'];
    changePer = json['changesPercentage'];
    change = json['change'];
    dayLow = json['dayLow'];
    dayHigh = json['dayHigh'];
    yearLow = json['yearLow'];
    yearHigh = json['yearHigh'];
    marketCap = json['marketCap'];
    priceAvg50 = json['priceAvg50'];
    priceAvg200 = json['priceAvg200'];
    volume = json['volume'];
    avgVolume = json['avgVolume'];
    open = json['open'];
    preClose = json['previousClose'];
    timestamp = json['timestamp'];
    pe = json['pe'];
    eps = json['eps'];
    shares = json['sharesOutstanding'];
  }
}

class ChartModel {
  List<Map<String, dynamic>> chartData = [];

  ChartModel({
    this.chartData,
  });

  ChartModel.fromJson(List<dynamic> json) {
    json.forEach((value) {
      chartData.add(value);
    });
  }
}
