import 'package:expense_tracker/constanta.dart';
import 'package:expense_tracker/models/transaction.dart';
import 'package:expense_tracker/widgets/analytic_widget.dart';
import 'package:expense_tracker/widgets/transaction_list.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  final List<Transaction> listTransaction;
  final List<WeeklyTransaction> weeklyTransaction;
  const HomePage(
      {super.key,
      required this.listTransaction,
      required this.weeklyTransaction});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                "Hello, Budi",
                style: GoogleFonts.openSans(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: ColorConstant.primary),
              ),
              const SizedBox(
                height: 25,
              ),
              Center(
                child: Column(
                  children: [
                    Text(
                      "This week spending",
                      style: GoogleFonts.openSans(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: ColorConstant.secondary),
                    ),
                    Text(
                      "Rp200.000",
                      style: GoogleFonts.openSans(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: ColorConstant.primary),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              AnalyticHome(
                weeklyData: widget.weeklyTransaction,
              ),
              const SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Recent Transactions",
                    style: GoogleFonts.openSans(
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                        color: ColorConstant.primary),
                  ),
                  TextButton(
                      onPressed: () {},
                      child: Row(
                        children: [
                          Text(
                            "See All",
                            style: GoogleFonts.openSans(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: ColorConstant.primary),
                          ),
                          const Icon(Icons.chevron_right),
                        ],
                      ))
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              TransactionList(listTransaction: widget.listTransaction)
            ],
          ),
        ),
      ),
    );
  }
}
