import 'package:flutter/material.dart';
import 'package:logger/web.dart';

import 'package:optiparser/services/get_amount.dart';
import 'package:optiparser/services/get_transactions.dart';

import 'package:optiparser/components/dasboard.dart';
import 'package:optiparser/components/transactionCard.dart';
import 'package:optiparser/components/lastT_seeAll.dart';
import 'package:optiparser/components/img_service.dart';
import 'package:optiparser/components/transaction_details.dart';

import 'package:optiparser/storage/initialise_objectbox.dart'; // Import dio package
import 'package:optiparser/storage/models/transaction.dart';

import 'package:optiparser/screens/searchpage.dart';

final log = Logger();

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Transaction> transaction;
  late Map<String, double> amount;

  // Function to create and add a transaction
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
      body: Column(
        children: [
          // Big Container with Summary
          Container(
            height: realHeight * 0.46,
            width: realWidth,
            child: Dashboard(
              income: amount['income'] ?? 0.0,
              expenses: amount['expenses'] ?? 0.0,
              balance: amount['balance'] ?? 0.0,
            ),
          ),
          SizedBox(
            height: realHeight * 0.025,
          ),
          // to to all last transactions
          LastTseeAll(),
          // Recent Transactions Section
          Expanded(
            child: Container(
              margin: EdgeInsets.only(top: realHeight * 0.01),
              // padding: EdgeInsets.only(bottom: realHeight * 0.125),
              width: double.infinity,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment:
                      objectbox.transactionBox.getAll().length <= 2
                          ? MainAxisAlignment.start
                          : MainAxisAlignment.spaceEvenly,
                  children: transaction
                      .getRange(
                          0, transaction.length < 3 ? transaction.length : 3)
                      .map((tx) {
                    return TransactionCard(
                      transactionId: tx.id,
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 10.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(Icons.home),
              color: Colors.blueAccent,
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SearchPage()),
                );
              },
            ),
            const SizedBox(width: 50), // Space for the floating action button
            IconButton(
              icon: const Icon(Icons.list),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.arrow_forward),
              onPressed: () {},
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createTransaction,
        shape: const CircleBorder(),
        backgroundColor: Colors.blueAccent, // Highlight color
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
