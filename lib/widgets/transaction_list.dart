import 'package:expense_tracker/models/transaction.dart';
import 'package:expense_tracker/widgets/transaction_card.dart';
import 'package:flutter/material.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> listTransaction;

  const TransactionList({super.key, required this.listTransaction});

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
                  print(index);
                },
                child: TransactionCard(
                  transaction: listTransaction[index],
                ),
              ));
        });
  }
}
