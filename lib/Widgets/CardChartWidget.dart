import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

Widget pagesChartWidget(minX, maxX, minY, maxY, size, chartData) {
  return LineChart(LineChartData(
    lineTouchData: const LineTouchData(enabled: false),
    gridData: FlGridData(
      show: false,
    ),
    titlesData: FlTitlesData(
      show: false,
    ),
    borderData: FlBorderData(
      show: false,
    ),
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
        belowBarData: BarAreaData(
          gradientFrom: Offset(0, 0),
          gradientTo: Offset(0, 1),
          colors: [kBodyColor, kAppBarColor],
          show: true,
        ),
      ),
    ],
  ));
}
