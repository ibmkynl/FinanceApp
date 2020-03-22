class StockList {
  List<StockModel> stockList;

  StockList({
    this.stockList,
  });

  StockList.fromJson(Map<String, dynamic> json) {
    stockList = new List<StockModel>();

    json['symbolsList'].forEach((value) {
      stockList.add(StockModel.fromJson(value));
    });
  }
}

class StockModel {
  String symbol;
  String name;
  String exchange;
  double price;

  StockModel({
    this.name,
    this.exchange,
    this.symbol,
    this.price,
  });

  StockModel.fromJson(Map<String, dynamic> json) {
    symbol = json['symbol'];
    price = json['price'];
    exchange = json['exchange'];
    name = json['name'];
  }
}

class StockInfoModel {
  double price;
  String beta;
  String avgVol;
  String mrtCap;
  String lastDiv;
  String range;
  double change;
  String changePer;
  String companyName;
  String exchange;
  String industry;
  String website;
  String desc;
  String ceo;
  String sector;
  String imageUrl;

  StockInfoModel({
    this.exchange,
    this.price,
    this.changePer,
    this.change,
    this.desc,
    this.avgVol,
    this.beta,
    this.companyName,
    this.ceo,
    this.imageUrl,
    this.industry,
    this.lastDiv,
    this.mrtCap,
    this.range,
    this.sector,
    this.website,
  });

  StockInfoModel.fromJson(Map<String, dynamic> json) {
    price = json['profile']['price'];
    companyName = json['profile']['companyName'];
    beta = json['profile']['beta'];
    avgVol = json['profile']['volAvg'];
    mrtCap = json['profile']['mktCap'];
    lastDiv = json['profile']['lastDiv'];
    range = json['profile']['range'];
    change = json['profile']['changes'];
    changePer = json['profile']['changesPercentage'];
    exchange = json['profile']['exchange'];
    industry = json['profile']['industry'];
    website = json['profile']['website'];
    desc = json['profile']['description'];
    ceo = json['profile']['ceo'];
    sector = json['profile']['sector'];
    imageUrl = json['profile']['image'];
  }
}

class IncomeListModel {
  List<IncomeModel> incomeList;

  IncomeListModel({
    this.incomeList,
  });

  IncomeListModel.fromJson(Map<String, dynamic> json) {
    incomeList = new List<IncomeModel>();
    json['financials'].forEach((value) {
      incomeList.add(IncomeModel.fromJson(value));
    });
  }
}

class IncomeModel {
  String date;
  String revenue;
  String revenueGrowth;
  String costRevenue;
  String grossProfit;
  String rdExpense;
  String sgaExpense;
  String operatingExpense;
  String operatingIncome;
  String interestExpense;
  String earningBeforeTax;
  String incomeTaxExpense;
  String netIncome;
  String preDividends;
  String eps;
  String epsDiluted;
  String avgShsOut;
  String dividendPerShare;
  String grossMargin;
  String ebitdaMargin;
  String ebitMargin;
  String profitMargin;
  String ebitda;
  String ebit;
  String consolidatedIncome;
  String netProfitMargin;

  IncomeModel({
    this.date,
    this.revenue,
    this.revenueGrowth,
    this.costRevenue,
    this.grossProfit,
    this.rdExpense,
    this.sgaExpense,
    this.operatingExpense,
    this.operatingIncome,
    this.interestExpense,
    this.earningBeforeTax,
    this.incomeTaxExpense,
    this.netIncome,
    this.preDividends,
    this.eps,
    this.epsDiluted,
    this.avgShsOut,
    this.dividendPerShare,
    this.grossMargin,
    this.ebitdaMargin,
    this.ebitMargin,
    this.profitMargin,
    this.ebitda,
    this.ebit,
    this.consolidatedIncome,
    this.netProfitMargin,
  });

  IncomeModel.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    revenue = json['Revenue'];
    revenueGrowth = json['Revenue Growth'];
    costRevenue = json['Cost of Revenue'];
    grossProfit = json['Gross Profit'];
    rdExpense = json['R&D Expenses'];
    sgaExpense = json['SG&A Expense'];
    operatingExpense = json['Operating Expenses'];
    operatingIncome = json['Operating Income'];
    interestExpense = json['Interest Expense'];
    earningBeforeTax = json['Earnings before Tax'];
    incomeTaxExpense = json['Income Tax Expense'];
    netIncome = json['Net Income'];
    preDividends = json['Preferred Dividends'];
    eps = json['EPS'];
    epsDiluted = json['EPS Diluted'];
    avgShsOut = json['Weighted Average Shs Out'];
    dividendPerShare = json['Dividend per Share'];
    grossMargin = json['Gross Margin'];
    ebitdaMargin = json['EBITDA Margin'];
    ebitMargin = json['EBIT Margin'];
    profitMargin = json['Profit Margin'];
    ebitda = json['EBITDA'];
    ebit = json['EBIT'];
    consolidatedIncome = json['Consolidated Income'];
    netProfitMargin = json['Net Profit Margin'];
  }
}

class KeyMetricListModel {
  List<KeyMetricModel> metricList;

  KeyMetricListModel({
    this.metricList,
  });

  KeyMetricListModel.fromJson(Map<String, dynamic> json) {
    metricList = new List<KeyMetricModel>();
    json['metrics'].forEach((value) {
      metricList.add(KeyMetricModel.fromJson(value));
    });
  }
}

class KeyMetricModel {
  String date;
  String revenuePerShare;
  String netIncomePerShare;
  String operatingFlowPerShare;
  String freeCashPerShare;
  String cashPerShare;
  String bValuePerShare;
  String tValuePerShare;
  String sEquityPerShare;
  String marketCap;
  String enterpriseValue;
  String peRatio;
  String priceSalesRatio;
  String pocf;
  String pfcf;
  String pb;
  String ptb;
  String ev;
  String evOverEbitda;
  String evCashFLow;
  String earningsYield;
  String freeCashFlowYield;
  String deptEquity;
  String deptAssets;
  String interestCoverage;

  KeyMetricModel({
    this.date,
    this.revenuePerShare,
    this.netIncomePerShare,
    this.operatingFlowPerShare,
    this.freeCashPerShare,
    this.cashPerShare,
    this.bValuePerShare,
    this.tValuePerShare,
    this.sEquityPerShare,
    this.marketCap,
    this.enterpriseValue,
    this.peRatio,
    this.priceSalesRatio,
    this.pocf,
    this.pfcf,
    this.pb,
    this.ptb,
    this.ev,
    this.evOverEbitda,
    this.evCashFLow,
    this.earningsYield,
    this.freeCashFlowYield,
    this.deptEquity,
    this.deptAssets,
    this.interestCoverage,
  });

  KeyMetricModel.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    revenuePerShare = json['Revenue per Share'];
    netIncomePerShare = json['Net Income per Share'];
    operatingFlowPerShare = json['Operating Cash Flow per Share'];
    freeCashPerShare = json['Free Cash Flow per Share'];
    cashPerShare = json['Cash per Share'];
    bValuePerShare = json['Book Value per Share'];
    tValuePerShare = json['Tangible Book Value per Share'];
    sEquityPerShare = json['Shareholders Equity per Share'];
    marketCap = json['Market Cap'];
    enterpriseValue = json['Enterprise Value'];
    peRatio = json['PE ratio'];
    priceSalesRatio = json['Price to Sales Ratio'];
    pocf = json['POCF ratio'];
    pfcf = json['PFCF ratio'];
    pb = json['PB ratio'];
    ptb = json['PTB ratio'];
    ev = json['EV to Sales'];
    evOverEbitda = json['Enterprise Value over EBITDA'];
    evCashFLow = json['EV to Free cash flow'];
    earningsYield = json['Earnings Yield'];
    freeCashFlowYield = json['Free Cash Flow Yield'];
    deptEquity = json['Debt to Equity'];
    deptAssets = json['Debt to Assets'];
    interestCoverage = json['Interest Coverage'];
  }
}
