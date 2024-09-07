import 'package:expense_tracker/constanta.dart';
import 'package:expense_tracker/models/transaction.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PieGraph extends StatelessWidget {
  final List<Transaction> weeklyData;

  PieGraph({super.key, required this.weeklyData});

  final List<Color> colorList = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.purple,
    Colors.yellow,
    Colors.cyan,
    Colors.orange,
    Colors.grey,
    Colors.deepPurple,
    Colors.blueGrey,
    Colors.pink,
    Colors.lime
  ];
  @override
  Widget build(BuildContext context) {
    return PieChart(
      PieChartData(
          centerSpaceRadius: 0,
          sections: weeklyData.map((data) {
            int i = weeklyData.indexOf(data);

            return PieChartSectionData(
              titleStyle: GoogleFonts.openSans(
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                  color: ColorConstant.primary),
              color: colorList[i],
              value: data.amount,
              title: data.type,
              radius: 140,
              titlePositionPercentageOffset: 0.65,
            );
          }).toList()),
    );
  }
}
