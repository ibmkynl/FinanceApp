import 'package:financeapp/Pages/StockMarketDetail_page.dart';
import 'package:financeapp/constants.dart';
import 'package:flutter/material.dart';

Widget stockCardWidget({stock, size, context}) {
  return GestureDetector(
    onTap: () {
      pageScroll(
          pageName: StockMarketDetailPage(
            stock: stock,
          ),
          context: context);
    },
    child: Padding(
      padding: EdgeInsets.symmetric(
          vertical: size.height * 0.005, horizontal: size.height * 0.01),
      child: Container(
        color: kAppBarColor,
        padding: EdgeInsets.all(size.height * 0.01),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  stock.symbol,
                  style: TextStyle(
                      color: kSelectedLabelColor,
                      fontSize: size.height * 0.025),
                ),
                Container(
                    width: size.width * 0.4,
                    child: Text(stock.name,
                        maxLines: 1, style: TextStyle(color: Colors.grey)))
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(
                  '\u0024' + stock.price.toString(),
                  style: TextStyle(
                      color: kSelectedLabelColor,
                      fontSize: size.height * 0.025),
                ),
                Text(
                  stock.exchange,
                  style: TextStyle(color: Colors.grey),
                )
              ],
            )
          ],
        ),
      ),
    ),
  );
}
