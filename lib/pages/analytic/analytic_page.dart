import 'package:expense_tracker/constanta.dart';
import 'package:expense_tracker/models/transaction.dart';
import 'package:expense_tracker/widgets/analytic_widget.dart';
import 'package:expense_tracker/widgets/breakdown_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AnalyticPage extends StatefulWidget {
  final List<WeeklyTransaction> weeklyData;
  const AnalyticPage({super.key, required this.weeklyData});

  @override
  State<AnalyticPage> createState() => _AnalyticPageState();
}

class _AnalyticPageState extends State<AnalyticPage> {
  var weeklyData = [
    Transaction(1, "Makanan", "Ayam Geprek", 15000, "15 August 2024"),
    Transaction(2, "Other", "Mobil", 15000, "16 August 2024"),
    Transaction(3, "Pakaian", "Baju", 100000, "17 August 2024"),
  ];

  bool isWeeklyOn = true;
  bool isMonthlyOn = false;
  bool isYearlyOn = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Scaffold(
          body: ListView(
            children: [
              const SizedBox(
                height: 20,
              ),
              Text(
                "Analytic",
                style: GoogleFonts.openSans(
                    fontSize: 24,
                    fontWeight: FontWeight.normal,
                    color: ColorConstant.primary),
              ),
              const SizedBox(
                height: 22,
              ),
              Container(
                width: double.infinity - 15,
                height: 38,
                decoration: BoxDecoration(
                  color: ColorConstant.secondary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isWeeklyOn = true;
                            isMonthlyOn = false;
                            isYearlyOn = false;
                          });
                        },
                        child: Container(
                          width: 120,
                          height: 32,
                          decoration: BoxDecoration(
                            color: isWeeklyOn
                                ? ColorConstant.primary
                                : ColorConstant.secondary,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              "Weekly",
                              style: GoogleFonts.openSans(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isWeeklyOn = false;
                            isMonthlyOn = true;
                            isYearlyOn = false;
                          });
                        },
                        child: Container(
                          width: 120,
                          height: 32,
                          decoration: BoxDecoration(
                            color: isMonthlyOn
                                ? ColorConstant.primary
                                : ColorConstant.secondary,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              "Monthly",
                              style: GoogleFonts.openSans(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isWeeklyOn = false;
                            isMonthlyOn = false;
                            isYearlyOn = true;
                          });
                        },
                        child: Container(
                          width: 120,
                          height: 32,
                          decoration: BoxDecoration(
                            color: isYearlyOn
                                ? ColorConstant.primary
                                : ColorConstant.secondary,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              "Yearly",
                              style: GoogleFonts.openSans(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 31,
              ),
              Container(
                height: 70,
                width: double.infinity,
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
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Highest Spending",
                            style: GoogleFonts.openSans(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: ColorConstant.secondary),
                          ),
                          Text(
                            "Rp500.000",
                            style: GoogleFonts.openSans(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: ColorConstant.primary),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "Average Spending",
                            style: GoogleFonts.openSans(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: ColorConstant.secondary),
                          ),
                          Text(
                            "Rp50.000",
                            style: GoogleFonts.openSans(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: ColorConstant.primary),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 31,
              ),
              AnalyticHome(weeklyData: widget.weeklyData),
              const SizedBox(
                height: 31,
              ),
              BreakdownWidget(weeklyData: weeklyData),
              const SizedBox(
                height: 31,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
