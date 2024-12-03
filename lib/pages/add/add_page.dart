import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:expense_tracker/constanta.dart';
import 'package:expense_tracker/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const List<String> listOption = ["Food", "Fashion", "Electronic", "Other"];

class AddPage extends StatefulWidget {
  final Function onSave;
  const AddPage({super.key, required this.onSave});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  String? dropdownValue;
  bool isOpened = true;
  TextEditingController amountController = TextEditingController();
  TextEditingController noteController = TextEditingController();

  final CurrencyTextInputFormatter _formatter =
      CurrencyTextInputFormatter.currency(
    locale: 'id',
    decimalDigits: 0,
    symbol: 'Rp',
  );

  Future<void> saveTransaction(num amount, String note, String type) async {
    bool isSuccess = await Transaction.createTransaction(amount, note, type);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
        isSuccess ? "Success to save" : "Failed to save transaction",
        style: GoogleFonts.openSans(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: Colors.white,
        ),
      )));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 40),
      child: Column(
        children: [
          Container(
            height: 32,
            width: double.infinity,
            decoration: BoxDecoration(
              color: ColorConstant.primary,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                  dropdownColor: ColorConstant.primary,
                  icon: const Icon(
                    Icons.arrow_downward_rounded,
                    color: Colors.white,
                    size: 22,
                  ),
                  isExpanded: false,
                  style: GoogleFonts.openSans(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: Colors.white,
                  ),
                  hint: Text("Select Your Transaction Type",
                      style: GoogleFonts.openSans(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.white)),
                  value: dropdownValue,
                  items: listOption.map<DropdownMenuItem<String>>((value) {
                    return DropdownMenuItem(value: value, child: Text(value));
                  }).toList(),
                  onChanged: (String? value) {
                    setState(
                      () {
                        dropdownValue = value!;
                      },
                    );
                  },
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 33,
          ),
          Text(
            "Amount",
            style: GoogleFonts.openSans(
              fontSize: 20,
              fontWeight: FontWeight.normal,
              color: ColorConstant.primary,
            ),
          ),
          const SizedBox(
            height: 28,
          ),
          TextFormField(
            controller: amountController,
            showCursor: false,
            inputFormatters: [
              _formatter,
            ],
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            style: GoogleFonts.openSans(
              fontSize: 48,
              fontWeight: FontWeight.bold,
              color: ColorConstant.primary,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Rp 0",
              hintStyle: GoogleFonts.openSans(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: ColorConstant.primary,
              ),
            ),
          ),
          const SizedBox(
            height: 33,
          ),
          TextFormField(
            controller: noteController,
            showCursor: false,
            textAlign: TextAlign.center,
            style: GoogleFonts.openSans(
              fontSize: 20,
              fontWeight: FontWeight.normal,
              color: ColorConstant.primary,
            ),
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              hintText: "Add Comment...",
              hintStyle: GoogleFonts.openSans(
                fontSize: 20,
                fontWeight: FontWeight.normal,
                color: ColorConstant.primary,
              ),
            ),
          ),
          const SizedBox(
            height: 33,
          ),
          GestureDetector(
            onTap: () async {
              saveTransaction(_formatter.getUnformattedValue(),
                  noteController.text, dropdownValue!);
              await Future.delayed(const Duration(milliseconds: 25000));
              Navigator.pop(context);
              widget.onSave();
            },
            child: Container(
              width: MediaQuery.sizeOf(context).width / 2 - 30,
              height: 50,
              decoration: BoxDecoration(
                color: ColorConstant.primary,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Center(
                child: Text(
                  "Save",
                  style: GoogleFonts.openSans(
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                      color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NumButton extends StatelessWidget {
  final String value;
  const NumButton({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 82,
      width: 82,
      decoration: const BoxDecoration(
        color: ColorConstant.secondary,
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
      child: Center(
        child: Text(
          value,
          style: GoogleFonts.openSans(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: ColorConstant.primary,
          ),
        ),
      ),
    );
  }
}
