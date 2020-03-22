import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

Widget detailChartWidget(
    {minX, maxX, minY, maxY, horizontalInterval, size, chartData}) {
  return LineChart(LineChartData(
    lineTouchData: const LineTouchData(
        enabled: true,
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: kUnselectedLabelColor,
        ),
        handleBuiltInTouches: true),
    gridData: FlGridData(
      show: false,
      drawHorizontalLine: true,
      drawVerticalLine: false,
      horizontalInterval: horizontalInterval,
      getDrawingHorizontalLine: (value) {
        return const FlLine(color: kUnselectedLabelColor, strokeWidth: 1);
      },
      getDrawingVerticalLine: (value) {
        return const FlLine(color: kUnselectedLabelColor, strokeWidth: 1);
      },
    ),
    titlesData: FlTitlesData(
      show: false,
    ),
    borderData: FlBorderData(
        show: false,
        border: Border(
            top: BorderSide(color: kUnselectedLabelColor),
            bottom: BorderSide(color: kUnselectedLabelColor))),
    minX: minX,
    maxX: maxX,
    minY: minY,
    maxY: maxY,
    lineBarsData: [
      LineChartBarData(
        spots: chartData,
        isCurved: true,
        barWidth: 1,
        colorStops: [0.0, 1.0],
        colors: [kSelectedLabelColor, kUnselectedLabelColor],
        isStrokeCapRound: false,
        dotData: const FlDotData(
          show: false,
        ),
        aboveBarData: BarAreaData(show: true, colors: [kAppBarColor]),
        belowBarData: BarAreaData(
          colors: [kBodyColor],
          show: true,
        ),
      ),
    ],
  ));
}
