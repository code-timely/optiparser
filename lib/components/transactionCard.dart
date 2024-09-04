import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:optiparser/components/transaction_details.dart';
import 'package:optiparser/services/get_transaction_by_id.dart';
import 'package:optiparser/storage/models/transaction.dart';

class TransactionCard extends StatefulWidget {
  final int transactionId;
  final Function onTransactionUpdated;

  TransactionCard(
      {required this.transactionId, required this.onTransactionUpdated});

  @override
  State<TransactionCard> createState() => _TransactionCardState();
}

class _TransactionCardState extends State<TransactionCard> {
  Future<Transaction?> getTransaction() async {
    return getTransactionById(widget.transactionId);
  }

  String getImage(Transaction transaction) {
    if (transaction.isExpense) {
      return 'expeness'; // Image for expense
    } else {
      return 'income'; // Image for income
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // Get the current orientation
    Orientation orientation = MediaQuery.of(context).orientation;
    // Check if the orientation is portrait
    bool isPortrait = orientation == Orientation.portrait;

    return FutureBuilder<Transaction?>(
      future: getTransaction(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData) {
          return Center(child: Text('Transaction not found'));
        } else {
          final transaction = snapshot.data!;

          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddTransaction(
                    initialData: transaction.toMap(),
                    transactionId: transaction.id,
                  ),
                ),
              ).then((_) => {widget.onTransactionUpdated()});
            },
            child: Container(
              margin: EdgeInsets.only(left: 20, right: 20, top: 13),
              height: isPortrait ? size.height * 0.117 : size.height * 0.25,
              width: size.width,
              decoration: BoxDecoration(
                color: transaction.isExpense
                    ? Colors.red[100]
                    : Colors
                        .green[100], // Background color based on expense flag
                borderRadius: BorderRadius.circular(23),
                border: Border.all(color: Colors.grey[400]!.withOpacity(0.6)),
              ),
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        left: 10, right: 10), // Reduced left margin
                    height: size.height * 0.081,
                    width: size.height * 0.081,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 3,
                          blurRadius: 13,
                          offset: Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Container(
                      child: Image.asset(
                        "assets/" + getImage(transaction) + ".png",
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        margin: EdgeInsets.only(top: 5),
                        padding: EdgeInsets.only(right: 10, top: 1, bottom: 5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    "${transaction.title}",
                                    softWrap: false,
                                    overflow: TextOverflow.clip,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w900,
                                      fontSize: 22,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child: Text(
                                      DateFormat('d MMM yyyy')
                                          .format(transaction.date),
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 4),
                            Expanded(
                              child: Text(
                                "₹${transaction.amount.toStringAsFixed(2)}",
                                softWrap: false,
                                overflow: TextOverflow.clip,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            SizedBox(height: 4),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
