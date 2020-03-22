import 'package:financeapp/Models/DataModel.dart';
import 'package:financeapp/Widgets/CardWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class DataPage extends StatefulWidget {
  final future;

  DataPage({Key key, this.future}) : super(key: key);

  @override
  _DataPageState createState() => _DataPageState();
}

class _DataPageState extends State<DataPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FutureBuilder(
        future: widget.future,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Column(
              children: <Widget>[LinearProgressIndicator()],
            );
          }
          if (snapshot.data != null) {
            DataListModel dataListModel = snapshot.data;
            return AnimationLimiter(
              child: ListView.builder(
                  itemCount: dataListModel.dataList.length,
                  itemBuilder: (BuildContext context, int index) {
                    DataModel dataModel = dataListModel.dataList[index];
                    return AnimationConfiguration.staggeredList(
                        position: index,
                        duration: const Duration(milliseconds: 375),
                        child: SlideAnimation(
                          verticalOffset: 50.0,
                          child: FadeInAnimation(
                              child: cardWidget(dataModel, size, context)),
                        ));
                  }),
            );
          } else {
            return Container();
          }
        });
  }
}
