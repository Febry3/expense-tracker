import 'package:expense_tracker/constanta.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({super.key});

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  TextEditingController fromDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Future<void> selectFromDate() async {
      DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
      );

      if (picked != null) {
        setState(() {
          var string = picked.toString().split("-");
          fromDateController.text =
              "${string[2].split(" ")[0]}-${string[1]}-${string[0]}";
        });
      }
    }

    Future<void> selectToDate() async {
      DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
      );

      if (picked != null) {
        setState(() {
          var string = picked.toString().split("-");
          toDateController.text =
              "${string[2].split(" ")[0]}-${string[1]}-${string[0]}";
        });
      }
    }

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: ListView(
            children: [
              const SizedBox(
                height: 20,
              ),
              Text(
                "Transaction",
                style: GoogleFonts.openSans(
                    fontSize: 24,
                    fontWeight: FontWeight.normal,
                    color: ColorConstant.primary),
              ),
              const SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 170,
                    height: 80,
                    child: TextField(
                      controller: fromDateController,
                      onTap: () {
                        selectFromDate();
                      },
                      readOnly: true,
                      decoration: const InputDecoration(
                        labelText: "From",
                        filled: true,
                        prefixIcon: Icon(Icons.calendar_month_rounded),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: ColorConstant.primary),
                        ),
                      ),
                    ),
                  ),
                  const Icon(
                    Icons.arrow_right_alt_rounded,
                    size: 32,
                  ),
                  SizedBox(
                    width: 170,
                    height: 80,
                    child: TextField(
                      controller: toDateController,
                      onTap: () {
                        selectToDate();
                      },
                      readOnly: true,
                      decoration: const InputDecoration(
                        labelText: "To",
                        filled: true,
                        prefixIcon: Icon(Icons.calendar_month_rounded),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: ColorConstant.primary),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 18,
              ),
              Text(
                "Transaction List",
                style: GoogleFonts.openSans(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: ColorConstant.primary),
              ),
              const SizedBox(
                height: 12,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
