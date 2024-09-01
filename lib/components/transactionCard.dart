import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionCard extends StatelessWidget {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final bool expense;

  TransactionCard({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
    required this.expense,
  });

  String getImage() {
    if (expense) {
      return 'expeness'; // Image for expense
    } else {
      return 'income'; // Image for income
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, top: 13),
      height: size.height * 0.112,
      width: size.width,
      decoration: BoxDecoration(
        color: expense
            ? Colors.red[100]
            : Colors.green[100], // Background color based on expense flag
        borderRadius: BorderRadius.circular(23),
        border: Border.all(color: Colors.grey[400]!.withOpacity(0.6)),
      ),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(left: 10, right: 10), // Reduced left margin
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
                "assets/" + getImage() + ".png",
                fit: BoxFit.scaleDown,
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.topRight,
              child: Container(
                margin: EdgeInsets.only(top: 5),
                padding: EdgeInsets.only(right: 10, top: 5, bottom: 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Text(
                          DateFormat('d MMM yyyy').format(date),
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "\$${amount.toStringAsFixed(2)}",
                        softWrap: false,
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                          color: Colors.redAccent[400],
                          fontWeight: FontWeight.w900,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Expanded(
                      child: Text(
                        title,
                        overflow: TextOverflow.fade,
                        softWrap: false,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
