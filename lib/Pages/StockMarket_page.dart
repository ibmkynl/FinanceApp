import 'package:financeapp/Models/StockModel.dart';
import 'package:financeapp/Repos/StockMarketRepo.dart';
import 'package:financeapp/Widgets/StockCardWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class StockMarketPage extends StatefulWidget {
  final future;

  StockMarketPage({
    this.future,
  });

  @override
  _StockMarketPageState createState() => _StockMarketPageState();
}

class _StockMarketPageState extends State<StockMarketPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FutureBuilder(
        future: widget.future,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Column(
              children: <Widget>[LinearProgressIndicator()],
            );
          }
          if (snapshot.data != null) {
            StockList stockList = snapshot.data;
            return AnimationLimiter(
              child: ListView.builder(
                  itemCount: stockList.stockList.length,
                  itemBuilder: (BuildContext context, int index) {
                    StockModel stockModel = stockList.stockList[index];

                    return AnimationConfiguration.staggeredList(
                        position: index,
                        duration: const Duration(milliseconds: 375),
                        child: SlideAnimation(
                          verticalOffset: 50.0,
                          child: FadeInAnimation(
                              child: stockCardWidget(
                                  stock: stockModel,
                                  size: size,
                                  context: context)),
                        ));
                  }),
            );
          } else {
            return Container();
          }
        });
  }
}
