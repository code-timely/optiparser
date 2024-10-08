import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePicker extends StatefulWidget {
  final Function updateDateValue;

  const DatePicker({Key? key, required this.updateDateValue}) : super(key: key);

  @override
  _DatePickerState createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  DateTime _selectedDate = DateTime.now();

  void _chooseDate() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(Duration(days: 365)),
      lastDate: DateTime.now(),
    ).then((value) {
      if (value == null) {
        return;
      }
      setState(() {
        _selectedDate = value;
        widget.updateDateValue(value);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start, // Align items to the start
      children: [
        RichText(
          text: TextSpan(
            style: TextStyle(
              color: Colors.black.withOpacity(0.6),
              fontWeight: FontWeight.w500,
            ),
            children: [
              TextSpan(
                text: "Date : ",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.w900,
                ),
              ),
              TextSpan(
                  text: DateFormat.yMd().format(_selectedDate),
                  style: TextStyle(
                    fontSize: 20,
                  )),
            ],
          ),
        ),
        IconButton(
          onPressed: _chooseDate,
          icon: Icon(Icons.edit, color: Colors.black),
        ),
      ],
    );
  }
}
