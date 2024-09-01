import 'package:flutter/material.dart';
import 'package:optiparser/storage/models/transaction.dart';
import 'package:optiparser/screens/searchpage.dart';
// import 'package:responsive_flutter/responsive_flutter.dart';

class LastTseeAll extends StatelessWidget {
  const LastTseeAll({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // crossAxisAlignment: CrossAxisAlignment.baseline,
        children: [
          Text(
            "Last Transactions",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              // fontSize: ResponsiveFlutter.of(context).fontSize(2.3),
              fontSize: 23,
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SearchPage()),
              );
            },
            child: Text(
              "See All",
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.w500,
                // fontSize: ResponsiveFlutter.of(context).fontSize(1.725),
                fontSize: 17.25,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
