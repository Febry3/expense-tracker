import 'package:expense_tracker/constanta.dart';
import 'package:expense_tracker/models/transaction.dart';
import 'package:expense_tracker/widgets/transaction_list.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TransactionPage extends StatefulWidget {
  final List<Transaction> listTransaction;

  const TransactionPage({super.key, required this.listTransaction});

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  TextEditingController fromDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();
  bool isSearch = false;
  List<Transaction> searchedList = [];

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

  Future<void> getSearchedData(String from, String to) async {
    List<Transaction> data = await Transaction.getTransactionByDate(from, to);

    setState(() {
      searchedList = data;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                    height: 60,
                    child: TextField(
                      controller: fromDateController,
                      onTapOutside: (event) => FocusScope.of(context).unfocus(),
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
                    height: 60,
                    child: TextField(
                      onTapOutside: (event) => FocusScope.of(context).unfocus(),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      fromDateController.text = "";
                      toDateController.text = "";
                      setState(() {
                        isSearch = false;
                      });
                    },
                    child: Container(
                      width: MediaQuery.sizeOf(context).width / 2 - 28,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        border:
                            Border.all(color: ColorConstant.primary, width: 2),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.close_sharp,
                            color: ColorConstant.primary,
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(
                            "Reset",
                            style: GoogleFonts.openSans(
                                fontSize: 18,
                                fontWeight: FontWeight.normal,
                                color: ColorConstant.primary),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isSearch = true;
                      });

                      getSearchedData(
                          fromDateController.text, toDateController.text);
                    },
                    child: Container(
                      width: MediaQuery.sizeOf(context).width / 2 - 28,
                      height: 40,
                      decoration: BoxDecoration(
                          color: ColorConstant.primary,
                          borderRadius: BorderRadius.circular(30)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.search,
                            color: Colors.white,
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(
                            "Search",
                            style: GoogleFonts.openSans(
                                fontSize: 18,
                                fontWeight: FontWeight.normal,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  )
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
              TransactionList(
                  listTransaction:
                      isSearch ? searchedList : widget.listTransaction)
            ],
          ),
        ),
      ),
    );
  }
}
