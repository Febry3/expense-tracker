import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:expense_tracker/constanta.dart';
import 'package:expense_tracker/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const List<String> listOption = ["Food", "Fashion", "Electronic", "Other"];

class EditPage extends StatefulWidget {
  final Transaction selectedData;
  final Function onPressed;
  const EditPage(
      {super.key, required this.selectedData, required this.onPressed});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
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

  Future<void> editTransaction(
      int id, num amount, String note, String type) async {
    bool isSuccess = await Transaction.editTransaction(id, amount, note, type);

    if (!isSuccess && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
        "Failed to save transaction",
        style: GoogleFonts.openSans(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: Colors.white,
        ),
      )));
    }
  }

  Future<void> deleteTransaction(int id) async {
    bool isSuccess = await Transaction.deleteTransaction(id);

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
  void initState() {
    // TODO: implement initState
    super.initState();
    amountController.text = _formatter.formatDouble(widget.selectedData.amount);
    noteController.text = widget.selectedData.note;
    dropdownValue = widget.selectedData.type;
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
            onTap: () {
              editTransaction(
                  widget.selectedData.id,
                  _formatter.getUnformattedValue(),
                  noteController.text,
                  dropdownValue!);
              Navigator.pop(context);
              widget.onPressed();
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
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              deleteTransaction(widget.selectedData.id);
              Navigator.pop(context);
              widget.onPressed();
            },
            child: Container(
              width: MediaQuery.sizeOf(context).width / 2 - 30,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Center(
                child: Text(
                  "Delete",
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
