import 'package:flutter/material.dart';
import 'package:logger/web.dart';
import 'package:optiparser/components/bar_chart.dart';
import 'package:optiparser/components/bottom_bar.dart';
import 'package:optiparser/screens/homepage.dart';

import 'package:optiparser/services/get_amount.dart';
import 'package:optiparser/services/get_transactions.dart';
import 'package:optiparser/storage/models/transaction.dart';

import 'package:optiparser/screens/searchpage.dart';

final log = Logger();

class AnalysisPage extends StatefulWidget {
  const AnalysisPage({super.key});

  @override
  State<AnalysisPage> createState() => _AnalysisPageState();
}

class _AnalysisPageState extends State<AnalysisPage> {
  late List<Transaction> transaction;
  late Map<String, double> amount;

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      automaticallyImplyLeading: false,
      elevation: 0,
      title: const Align(
        alignment: Alignment.centerLeft,
        child: Text(
          "Transaction Analysis",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
            color: Colors.black,
            fontFamily: 'Proxima Nova',
            textBaseline: TextBaseline.alphabetic,
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    amount = getAmount();
    transaction = getTransactions();
  }

  @override
  Widget build(BuildContext context) {
    final realHeight = MediaQuery.of(context).size.height -
        buildAppBar(context).preferredSize.height -
        MediaQuery.of(context).padding.top;
    final realWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: buildAppBar(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 100, 20, 60),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TheBarChart(listOftransactions: transaction),
            ],
          ),
        ),
      ),
      bottomNavigationBar: buildBottomNavBar(context),
    );
  }
}
