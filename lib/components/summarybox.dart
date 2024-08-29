import 'package:flutter/material.dart';

class Summarybox extends StatefulWidget {
  final String title;
  final String amount;
  final Color color;

  const Summarybox({
    super.key,
    required this.title,
    required this.amount,
    required this.color,
  });

  @override
  State<Summarybox> createState() => _SummaryboxState();
}

class _SummaryboxState extends State<Summarybox> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          widget.title,
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: widget.color,
          ),
        ),
        const SizedBox(height: 5.0),
        Text(
          widget.amount,
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: widget.color,
          ),
        ),
      ],
    );
  }
}