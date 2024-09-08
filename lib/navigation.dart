import 'package:expense_tracker/constanta.dart';
import 'package:expense_tracker/custom_icon_icons.dart';
import 'package:expense_tracker/models/transaction.dart';
import 'package:expense_tracker/pages/add/add_page.dart';
import 'package:expense_tracker/pages/analytic/analytic_page.dart';
import 'package:expense_tracker/pages/home/home_page.dart';
import 'package:expense_tracker/pages/profile/profile_page.dart';
import 'package:expense_tracker/pages/transaction/transaction_page.dart';
import 'package:flutter/material.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int _selectedIndex = 0;
  List<Transaction> listTransaction = [];
  List<WeeklyTransaction> weeklyData = [];

  Future<void> getData() async {
    var tempTransaction = await Transaction.getAllTransaction();
    var tempWeeklyData = await WeeklyTransaction.getWeeklyTransaction();
    setState(() {
      listTransaction = tempTransaction;
      weeklyData = tempWeeklyData;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 25),
        child: FloatingActionButton(
          shape: const CircleBorder(),
          backgroundColor: ColorConstant.primary,
          onPressed: () {
            showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (BuildContext context) {
                  return Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: SizedBox(
                      height: 500,
                      width: double.infinity,
                      child: AddPage(onSave: () {
                        setState(() {
                          getData();
                        });
                      }),
                    ),
                  );
                });
          },
          tooltip: 'Add Transaction',
          elevation: 4.0,
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: NavigationBar(
          backgroundColor: const Color.fromARGB(255, 255, 252, 252),
          onDestinationSelected: (value) {
            setState(() {
              _selectedIndex = value;
            });
          },
          selectedIndex: _selectedIndex,
          indicatorColor: const Color.fromARGB(87, 106, 126, 159),
          destinations: const [
            NavigationDestination(
              icon: Icon(
                Icons.home_rounded,
                size: 32,
                color: ColorConstant.primary,
              ),
              label: '',
            ),
            NavigationDestination(
              icon: Icon(
                CustomIcon.transactionicon,
                color: ColorConstant.primary,
              ),
              label: '',
            ),
            Text(''),
            NavigationDestination(
              icon: Icon(
                Icons.bar_chart_rounded,
                size: 32,
                color: ColorConstant.primary,
              ),
              label: '',
            ),
            NavigationDestination(
              icon: Icon(
                Icons.person_2_rounded,
                size: 32,
                color: ColorConstant.primary,
              ),
              label: '',
            ),
          ]),
      body: SafeArea(
        child: IndexedStack(
          index: _selectedIndex,
          children: [
            HomePage(
              listTransaction: listTransaction,
              weeklyTransaction: weeklyData,
            ),
            TransactionPage(
              listTransaction: listTransaction,
            ),
            const SizedBox(),
            AnalyticPage(
              weeklyData: weeklyData,
            ),
            const ProfilePage()
          ],
        ),
      ),
    );
  }
}
