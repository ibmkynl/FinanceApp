import 'package:financeapp/Models/NewsModel.dart';
import 'package:financeapp/Models/StockModel.dart';
import 'package:financeapp/Repos/NewsRepo.dart';
import 'package:financeapp/Repos/StockMarketRepo.dart';
import 'package:financeapp/Widgets/DetailResultWidget.dart';
import 'package:financeapp/Widgets/DetailTextWidget.dart';
import 'package:financeapp/Widgets/PhotoWidget.dart';
import 'package:financeapp/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:link_previewer/link_previewer.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoPage extends StatefulWidget {
  final String symbol;

  InfoPage({
    this.symbol,
  });

  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: <Widget>[
          Container(
            color: kAppBarColor,
            child: FutureBuilder(
                future: StockMarketRepo().getStockInfo(name: widget.symbol),
                builder: (context, snapshot) {
                  StockInfoModel infoModel = snapshot.data;
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    FlutterMoneyFormatter avgVol = new FlutterMoneyFormatter(
                        amount: double.parse(infoModel.avgVol),
                        settings: MoneyFormatterSettings(
                            symbol: 'USD',
                            fractionDigits:
                                double.parse(infoModel.avgVol) < 10 ? 5 : 2));
                    FlutterMoneyFormatter marketCap = new FlutterMoneyFormatter(
                        amount: double.parse(infoModel.mrtCap),
                        settings: MoneyFormatterSettings(
                            symbol: 'USD',
                            fractionDigits:
                                double.parse(infoModel.mrtCap) < 10 ? 5 : 2));

                    return Padding(
                      padding: EdgeInsets.all(size.height * 0.02),
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Container(
                                    width: size.height * 0.06,
                                    child: PhotoWidget(
                                      photoLink: infoModel.imageUrl,
                                    ),
                                  ),
                                  SizedBox(
                                    width: size.width * 0.03,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        widget.symbol,
                                        style: TextStyle(
                                            fontSize: size.height * 0.03,
                                            color: kSelectedLabelColor),
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          await _launchURL(infoModel.website);
                                        },
                                        child: Row(
                                          children: <Widget>[
                                            Text(
                                              infoModel.website.substring(
                                                  7, infoModel.website.length),
                                              style: TextStyle(
                                                  color: kSelectedLabelColor),
                                            ),
                                            Icon(
                                              Icons.open_in_browser,
                                              size: size.height * 0.02,
                                              color: Colors.grey,
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Text(
                                    '\u0024' + infoModel.price.toString(),
                                    style: TextStyle(
                                        fontSize: size.height * 0.03,
                                        color: kSelectedLabelColor),
                                  ),
                                  Text(
                                    infoModel.change.toString() +
                                        " " +
                                        infoModel.changePer,
                                    style: TextStyle(
                                        color: infoModel.changePer
                                                    .substring(1, 2) ==
                                                "-"
                                            ? Colors.red
                                            : Colors.green),
                                  )
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          infoModel.ceo != ""
                              ? Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    detailTextWidget(text: "Ceo: "),
                                    detailResultWidget(text: infoModel.ceo)
                                  ],
                                )
                              : Container(),
                          infoModel.sector != ""
                              ? Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    detailTextWidget(text: "Sector: "),
                                    detailResultWidget(text: infoModel.sector)
                                  ],
                                )
                              : Container(),
                          infoModel.exchange != ""
                              ? Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    detailTextWidget(text: "Exchange: "),
                                    detailResultWidget(text: infoModel.exchange)
                                  ],
                                )
                              : Container(),
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          Text(
                            "    " + infoModel.desc,
                            style: TextStyle(
                              color: kSelectedLabelColor,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: <Widget>[
                                        detailTextWidget(text: "Market cap: "),
                                        detailResultWidget(
                                            text: '\u0024' +
                                                marketCap
                                                    .output.compactNonSymbol)
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: <Widget>[
                                        detailTextWidget(text: "Avg vol: "),
                                        detailResultWidget(
                                            text: '\u0024' +
                                                avgVol.output.compactNonSymbol)
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: size.width * 0.02,
                              ),
                              Expanded(
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: <Widget>[
                                        detailTextWidget(text: "Last div: "),
                                        detailResultWidget(
                                            text: infoModel.lastDiv)
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: <Widget>[
                                        detailTextWidget(text: "Range: "),
                                        detailResultWidget(
                                            text: infoModel.range)
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          Text(
                            "News",
                            style: TextStyle(
                                color: kSelectedLabelColor,
                                fontSize: size.height * 0.04),
                          ),
                        ],
                      ),
                    );
                  }
                }),
          ),
          FutureBuilder(
            future: NewsRepo().getNews(name: widget.symbol),
            builder: (context, snapshot) {
              NewsList news = snapshot.data;
              if (!snapshot.hasData) {
                return Text("News loading..");
              } else {
                return AnimationLimiter(
                  child: Container(
                    height: news.newsList.length * size.height * 0.08 * 2,
                    child: ListView.builder(
                        itemCount: news.newsList.length,
                        itemBuilder: (BuildContext context, int index) {
                          NewsModel newsModel = news.newsList[index];
                          return AnimationConfiguration.staggeredList(
                              position: index,
                              duration: const Duration(milliseconds: 375),
                              child: SlideAnimation(
                                verticalOffset: 50.0,
                                child: FadeInAnimation(
                                  child: Padding(
                                    padding: EdgeInsets.all(size.height * 0.02),
                                    child: LinkPreviewer(
                                      backgroundColor: Colors.white12,
                                      borderColor: kSelectedLabelColor,
                                      defaultPlaceholderColor: kBodyColor,
                                      link: newsModel.url,
                                      direction: ContentDirection.horizontal,
                                    ),
                                  ),
                                ),
                              ));
                        }),
                  ),
                );
              }
            },
          )
        ],
      ),
    );
  }
}
