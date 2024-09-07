import 'package:expense_tracker/constanta.dart';
import 'package:expense_tracker/models/transaction.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BarGraph extends StatelessWidget {
  final List<WeeklyTransaction> weeklyData;
  const BarGraph({super.key, required this.weeklyData});

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        barTouchData: BarTouchData(
          touchTooltipData: BarTouchTooltipData(
            tooltipRoundedRadius: 20,
          ),
        ),
        borderData: FlBorderData(
          show: false,
        ),
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: findMax(weeklyData) / 4,
        ),
        titlesData: FlTitlesData(
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          bottomTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: true, reservedSize: 24),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 45,
                interval: findMax(weeklyData) / 4),
          ),
        ),
        maxY: findMax(weeklyData),
        minY: 0,
        barGroups: weeklyData
            .map(
              (data) => BarChartGroupData(
                x: data.day,
                barRods: [
                  BarChartRodData(
                    toY: data.total,
                    color: ColorConstant.primary,
                    width: 23,
                    borderRadius: BorderRadius.circular(10),
                  )
                ],
              ),
            )
            .toList(),
      ),
    );
  }
}

double findMax(List<WeeklyTransaction> L) {
  double max = 0;
  for (WeeklyTransaction data in L) {
    if (data.total > max) {
      max = data.total;
    }
  }
  return max;
}
