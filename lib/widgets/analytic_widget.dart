import 'package:expense_tracker/constanta.dart';
import 'package:expense_tracker/models/transaction.dart';
import 'package:expense_tracker/widgets/bar_graph.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AnalyticHome extends StatelessWidget {
  final List<WeeklyTransaction> weeklyData;
  const AnalyticHome({super.key, required this.weeklyData});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 289,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey, //color of shadow
            spreadRadius: -2, //spread radius
            blurRadius: 4, // blur radius
            offset: Offset(0, 1), // changes position of shadow
          ),
        ],
      ),
      child: weeklyData.isEmpty
          ? const SizedBox(
              height: 80.0,
              width: 80.0,
              child: Center(child: CircularProgressIndicator()),
            )
          : Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 14, horizontal: 14.5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Analytic",
                    style: GoogleFonts.openSans(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: ColorConstant.primary),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Divider(
                    color: ColorConstant.secondary,
                  ),
                  const SizedBox(
                    height: 29,
                  ),
                  SizedBox(
                    height: 180,
                    child: BarGraph(
                      weeklyData: weeklyData,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
