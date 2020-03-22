class NewsList {
  List<NewsModel> newsList;
  NewsList({
    this.newsList,
  });
  NewsList.fromJson(Map<String, dynamic> json, companyName) {
    newsList = new List<NewsModel>();

    json['result_data']['$companyName'].forEach((value) {
      newsList.add(NewsModel.fromJson(value));
    });
  }
}

class NewsModel {
  String author;
  String desc;
  String source;
  String timestamp;
  String title;
  String url;

  NewsModel({
    this.desc,
    this.timestamp,
    this.url,
    this.author,
    this.source,
    this.title,
  });

  NewsModel.fromJson(Map<String, dynamic> json) {
    author = json['author'];
    desc = json['description'];
    url = json['url'];
    title = json['title'];
    source = json['source'];
    timestamp = json['published'];
  }
}
