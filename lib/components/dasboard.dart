// import 'package:flutter/material.dart';
// import 'package:optiparser/storage/initialise_objectbox.dart';
// import 'package:optiparser/storage/models/transaction.dart';
// import 'package:optiparser/objectbox.g.dart';
// import 'package:optiparser/ui/one_curveClipper.dart';
// import 'package:optiparser/ui/two_curvesClipper.dart';
// import 'package:optiparser/constants.dart';
// import 'package:optiparser/components/balance_info.dart';

// class Dasboard extends StatefulWidget {
//   const Dasboard({super.key});

//   @override
//   State<Dasboard> createState() => _DasboardState();
// }

// class _DasboardState extends State<Dasboard> {
//   double totalIncome = 0;
//   double totalExpenses = 0;
//   late Box<Transaction> transactionBox; // Assume Transaction is the model

//   @override
//   void initState() {
//     super.initState();
//     transactionBox = objectbox.transactionBox;
//     _calculateTotals();
//   }

//   void _calculateTotals() {
//     double income = 0;
//     double expenses = 0;

//     // Query all transactions and sum income and expenses
//     for (var transaction in transactionBox.getAll()) {
//       if (!transaction.isExpense) {
//         income += transaction.amount;
//       } else if (transaction.isExpense) {
//         expenses += transaction.amount;
//       }
//     }
//     setState(() {
//       totalIncome = income;
//       totalExpenses = expenses;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     double total = totalIncome - totalExpenses;
//     Size size = MediaQuery.of(context).size;
//     return Stack(
//       children: [
//         Positioned(
//           top: 0,
//           left: 0,
//           right: 0,
//           child: ClipPath(
//             clipper: OneCurve(),
//             child: Container(height: size.height * 0.34, color: kOneCurveColor),
//           ),
//         ),
//         Positioned(
//           top: 0,
//           left: 0,
//           right: 0,
//           child: ClipPath(
//             clipper: TwoCurves(),
//             child: Container(
//               height: size.height * 0.15,
//               color: kTwoCurvesColor,
//             ),
//           ),
//         ),
//         Positioned(
//           bottom: 0,
//           left: 25,
//           width: size.width - 50,
//           child: Container(
//             height: size.height * 0.25,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 Text(
//                   "Total Ballance",
//                   style: TextStyle(
//                     color: Colors.white,
//                     // fontSize: ResponsiveFlutter.of(context).fontSize(2.3),
//                     fontSize: 23,
//                   ),
//                 ),
//                 RichText(
//                   textAlign: TextAlign.center,
//                   text: TextSpan(
//                     children: <TextSpan>[
//                       TextSpan(
//                         text: 'USD  ',
//                         style: TextStyle(
//                           color: Colors.grey,
//                           // fontSize: ResponsiveFlutter.of(context).fontSize(2),
//                           fontSize: 20,
//                         ),
//                       ),
//                       TextSpan(
//                           text: total.toStringAsFixed(2),
//                           style: TextStyle(
//                               fontSize: 51.75,
//                               // ResponsiveFlutter.of(context).fontSize(5.175),

//                               fontWeight: FontWeight.bold)),
//                     ],
//                   ),
//                 ),
//                 Container(
//                   height: size.height * 0.1,
//                   width: size.width - 100,
//                   decoration: BoxDecoration(
//                       color: Color(0xff5400BE),
//                       borderRadius: BorderRadius.circular(15)),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       ColumnInfo(
//                         iconColor: Colors.greenAccent[400]!,
//                         iconData: Icons.arrow_downward,
//                         text: "Income",
//                         value: totalIncome.toStringAsFixed(2),
//                       ),
//                       Container(
//                         height: size.height * 0.06,
//                         width: 2,
//                         color: Colors.deepPurpleAccent,
//                       ),
//                       ColumnInfo(
//                         iconColor: Colors.redAccent[400]!,
//                         iconData: Icons.arrow_upward,
//                         text: "Expenses",
//                         value: totalExpenses.toStringAsFixed(2),
//                       ),
//                     ],
//                   ),
//                 )
//               ],
//             ),
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(20),
//                 image: DecorationImage(
//                   fit: BoxFit.fill,
//                   image: AssetImage("assets/imag/bg.png"),
//                 ),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.grey.withOpacity(0.6),
//                     spreadRadius: 2,
//                     blurRadius: 5,
//                     offset: Offset(0, 3),
//                   ),
//                 ]),
//           ),
//         )
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:optiparser/ui/one_curveClipper.dart';
import 'package:optiparser/ui/two_curvesClipper.dart';
import 'package:optiparser/constants.dart';
import 'package:optiparser/components/balance_info.dart';

class Dashboard extends StatelessWidget {
  final double income;
  final double expenses;
  final double balance;

  const Dashboard({
    Key? key,
    required this.income,
    required this.expenses,
    required this.balance,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: ClipPath(
            clipper: OneCurve(),
            child: Container(height: size.height * 0.34, color: kOneCurveColor),
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
        Positioned(
          bottom: 0,
          left: 25,
          width: size.width - 50,
          child: Container(
            height: size.height * 0.25,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage("assets/imag/bg.png"),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.6),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Total Balance",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 23,
                  ),
                ),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: '₹  ',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 20,
                        ),
                      ),
                      TextSpan(
                        text: balance.toStringAsFixed(2),
                        style: TextStyle(
                          fontSize: 51.75,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: size.height * 0.1,
                  width: size.width - 100,
                  decoration: BoxDecoration(
                    color: Color(0xff5400BE),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ColumnInfo(
                        iconColor: Colors.greenAccent[400]!,
                        iconData: Icons.arrow_downward,
                        text: "Income",
                        value: income.toStringAsFixed(2),
                      ),
                      Container(
                        height: size.height * 0.06,
                        width: 2,
                        color: Colors.deepPurpleAccent,
                      ),
                      ColumnInfo(
                        iconColor: Colors.redAccent[400]!,
                        iconData: Icons.arrow_upward,
                        text: "Expenses",
                        value: expenses.toStringAsFixed(2),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
