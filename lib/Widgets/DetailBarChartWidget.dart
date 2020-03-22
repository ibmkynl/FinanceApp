import 'package:financeapp/constants.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

Widget detailBarChartWidget({barGroups, maxY, horizontalInterval}) {
  return BarChart(BarChartData(
    maxY: maxY,
    barTouchData: const BarTouchData(
        enabled: true,
        touchTooltipData:
            BarTouchTooltipData(tooltipBgColor: kUnselectedLabelColor)),
    titlesData: FlTitlesData(
      show: false,
    ),
    gridData: FlGridData(
      show: false,
      drawHorizontalLine: true,
      drawVerticalLine: true,
      horizontalInterval: horizontalInterval,
      getDrawingHorizontalLine: (value) {
        return const FlLine(color: kUnselectedLabelColor, strokeWidth: 1);
      },
    ),
    borderData: FlBorderData(
        show: false,
        border: Border(
            top: BorderSide(color: kUnselectedLabelColor),
            bottom: BorderSide(color: kUnselectedLabelColor))),
    groupsSpace: 5,
    barGroups: barGroups,
  ));
}
