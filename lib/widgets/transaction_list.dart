import 'package:expense_tracker/models/transaction.dart';
import 'package:expense_tracker/pages/add/edit_page.dart';
import 'package:expense_tracker/widgets/transaction_card.dart';
import 'package:flutter/material.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> listTransaction;
  final Function onPressed;

  const TransactionList(
      {super.key, required this.listTransaction, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        itemCount: listTransaction.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      builder: (BuildContext context) {
                        return Padding(
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom),
                          child: SizedBox(
                            height: 550,
                            width: double.infinity,
                            child: EditPage(
                              selectedData: listTransaction[index],
                              onPressed: onPressed,
                            ),
                          ),
                        );
                      });
                },
                child: TransactionCard(
                  transaction: listTransaction[index],
                ),
              ));
        });
  }
}
