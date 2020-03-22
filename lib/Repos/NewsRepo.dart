import 'dart:convert';

import 'package:financeapp/constants.dart';
import 'package:financeapp/Models/NewsModel.dart' as NewsModel;
import 'package:http/http.dart' as http;

class NewsRepo {
  Future getNews({name}) async {
    String link =
        "https://api.unibit.ai/v2/company/news?tickers=$name&size=5&accessKey=$uniAlphaKey";

    var res = await http.get(link);
    var content = res.body;

    try {
      NewsModel.NewsList newsList =
          NewsModel.NewsList.fromJson(jsonDecode(content), name);
      return newsList;
    } catch (error) {
      print(error);
    }
  }
}
