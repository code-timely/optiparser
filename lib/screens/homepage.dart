import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:optiparser/constants.dart';
import 'package:optiparser/services/get_amount.dart';
import 'package:optiparser/services/get_transactions.dart';
import 'package:optiparser/components/dasboard.dart';
import 'package:optiparser/components/transactionCard.dart';
import 'package:optiparser/components/lastT_seeAll.dart';
import 'package:optiparser/components/img_service.dart';
import 'package:optiparser/components/transaction_details.dart';
import 'package:optiparser/storage/initialise_objectbox.dart'; // Import objectbox package
import 'package:optiparser/storage/models/transaction.dart';

import 'package:optiparser/ui/one_curveClipper.dart';
import 'package:optiparser/ui/two_curvesClipper.dart';

import 'package:optiparser/components/bottom_bar.dart';

final log = Logger();

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Transaction> transaction;
  late Map<String, double> amount;
  bool isBottomNavBarVisible = false; // State variable for visibility

  @override
  void initState() {
    super.initState();
    amount = getAmount();
    transaction = getTransactions();
  }

  void createTransaction() async {
    ImgService imgService = ImgService();

    var data = await imgService.showOptions(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddTransaction(
          initialData: data,
        ),
      ),
    ).then((_) => {
          setState(() {
            amount = getAmount();
            transaction = getTransactions();
          })
        });
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: const Align(
        alignment: Alignment.centerLeft,
        child: Text(
          "Welcome Back!",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
            color: Colors.white,
            fontFamily: 'Proxima Nova',
            textBaseline: TextBaseline.alphabetic,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    bool isPortrait = orientation == Orientation.portrait;

    Size size = MediaQuery.of(context).size;
    final realHeight = MediaQuery.of(context).size.height -
        buildAppBar(context).preferredSize.height -
        MediaQuery.of(context).padding.top;
    final realWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: buildAppBar(context),
      body: isPortrait
          ? Column(
              children: [
                // Big Container with Summary
                Container(
                  height: realHeight * 0.46,
                  width: realWidth,
                  child: Stack(
                    children: [
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        child: ClipPath(
                          clipper: OneCurve(),
                          child: Container(
                              height: size.height * 0.34,
                              color: kOneCurveColor),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        child: ClipPath(
                          clipper: TwoCurves(),
                          child: Container(
                            height: size.height * 0.15,
                            color: kTwoCurvesColor,
                          ),
                        ),
                      ),
                      Dashboard(
                        income: amount['income'] ?? 0.0,
                        expenses: amount['expenses'] ?? 0.0,
                        balance: amount['balance'] ?? 0.0,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: realHeight * 0.025,
                ),
                // to see all last transactions
                LastTseeAll(),
                // Recent Transactions Section
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(top: realHeight * 0.01),
                    width: double.infinity,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment:
                            objectbox.transactionBox.getAll().length <= 2
                                ? MainAxisAlignment.start
                                : MainAxisAlignment.spaceEvenly,
                        children: transaction
                            .getRange(0,
                                transaction.length < 3 ? transaction.length : 3)
                            .map<Widget>((tx) {
                          return TransactionCard(
                            transactionId: tx.id,
                            onTransactionUpdated: () => {
                              setState(() {
                                amount = getAmount();
                                transaction = getTransactions();
                              })
                            },
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ],
            )
          : Stack(children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: ClipPath(
                  clipper: OneCurve(),
                  child: Container(
                      height: size.height * 0.45, color: kOneCurveColor),
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: ClipPath(
                  clipper: TwoCurves(),
                  child: Container(
                    height: size.height * 0.25,
                    color: kTwoCurvesColor,
                  ),
                ),
              ),
              Dashboard(
                income: amount['income'] ?? 0.0,
                expenses: amount['expenses'] ?? 0.0,
                balance: amount['balance'] ?? 0.0,
              ),
              Positioned(
                top: size.height * 0.01,
                bottom: size.height * 0.1,
                left: size.width / 2,
                child: Container(
                  margin: EdgeInsets.only(top: realHeight * 0.1),
                  width: size.width / 2,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment:
                          objectbox.transactionBox.getAll().length <= 2
                              ? MainAxisAlignment.start
                              : MainAxisAlignment.spaceEvenly,
                      children: transaction
                          .getRange(0,
                              transaction.length < 3 ? transaction.length : 3)
                          .map<Widget>((tx) {
                        return TransactionCard(
                          transactionId: tx.id,
                          onTransactionUpdated: () => {
                            setState(() {
                              amount = getAmount();
                              transaction = getTransactions();
                            })
                          },
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ]),
      bottomNavigationBar: buildBottomNavBar(context),
      floatingActionButton: FloatingActionButton(
        onPressed: createTransaction,
        shape: const CircleBorder(),
        backgroundColor: Colors.blueAccent,
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
