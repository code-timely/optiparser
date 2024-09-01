import 'package:flutter/material.dart';
import 'package:logger/web.dart';
import 'package:optiparser/components/dasboard.dart';
// import 'package:optiparser/components/summarybox.dart';


import 'package:optiparser/components/transactionCard.dart';

import 'package:optiparser/storage/initialise_objectbox.dart'; // Import dio package
import 'package:optiparser/screens/searchpage.dart';
import 'package:optiparser/components/lastT_seeAll.dart';
import 'package:optiparser/components/img_service.dart';
import 'package:optiparser/components/transaction_details.dart';

final log = Logger();

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Function to create and add a transaction
  void createTransaction() async {
    ImgService imgService = ImgService();
    var data = await imgService.showOptions(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddTransaction(
          (transaction) {
            // Handle transaction submission
            print(transaction);
          },
          initialData: data,
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Align(
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
    final realHeight = MediaQuery.of(context).size.height -
        buildAppBar(context).preferredSize.height -
        MediaQuery.of(context).padding.top;
    final realWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: buildAppBar(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Big Container with Summary
            Container(
                height: realHeight * 0.46, width: realWidth, child: Dasboard()),
            SizedBox(
              height: realHeight * 0.025,
            ),
            // to to all last transactions
            LastTseeAll(),
            // Recent Transactions Section
            Container(
              margin: EdgeInsets.only(top: realHeight * 0.01),
              height: realHeight * 0.45,
              padding: EdgeInsets.only(bottom: realHeight * 0.125),
              width: double.infinity,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment:
                      objectbox.transactionBox.getAll().length <= 2
                          ? MainAxisAlignment.start
                          : MainAxisAlignment.spaceEvenly,
                  children: objectbox.transactionBox
                      .getAll()
                      .reversed
                      .toList()
                      .getRange(
                          0,
                          objectbox.transactionBox.getAll().length < 3
                              ? objectbox.transactionBox.getAll().length
                              : 3)
                      .map((tx) {
                    return TransactionCard(
                      amount: tx.amount,
                      date: tx.date,
                      id: tx.id.toString(),
                      title: tx.title,
                      expense: tx.isExpense,
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 10.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(Icons.home),
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
        // onPressed: showOptions,
        onPressed: createTransaction,
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
