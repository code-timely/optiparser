import 'package:flutter/material.dart';
import 'package:optiparser/components/date_picker.dart';
import 'package:optiparser/constants.dart';
import 'package:optiparser/storage/initialise_objectbox.dart';
import 'package:optiparser/storage/models/transaction.dart';
import 'package:intl/intl.dart';

class AddTransaction extends StatefulWidget {
  final Function addTransaction;
  final Map<String, dynamic> initialData;

  AddTransaction(this.addTransaction, {required this.initialData});

  @override
  _AddTransactionState createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  late String _titleValue;
  late DateTime _dateValue;
  late String _vendorsName;
  late String _invoiceId;
  late String _buyerName;
  late bool _isExpeness;
  double _amountValue = 0.0;

  @override
  void initState() {
    super.initState();
    DateFormat dateFormat = DateFormat("dd/MM/yyyy");
    _vendorsName = widget.initialData['vendors_name'] ?? '';
    _amountValue = widget.initialData['total_amount'] ?? 0.0;
    try {
      _dateValue = dateFormat.parse(widget.initialData['date']);
    } catch (e) {
      _dateValue = DateTime.now();
    }
  }

  void setDate(DateTime newDate) {
    setState(() {
      _dateValue = newDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildText("Title :"),
              TextField(
                onChanged: (value) => _titleValue = value,
                cursorColor: Theme.of(context).primaryColor,
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Write your title here',
                ),
                style: kTextFieldTextStyle.copyWith(fontSize: 20),
              ),
              const SizedBox(height: 20),
              const SizedBox(height: 20),
              buildText("Amount :"),
              TextField(
                onChanged: (value) => _amountValue = double.parse(value),
                cursorColor: Theme.of(context).primaryColor,
                keyboardType: TextInputType.number,
                decoration: kTextFieldDecoration,
                style: kTextFieldTextStyle.copyWith(fontSize: 20),
              ),
              const SizedBox(height: 10),
              DatePicker(updateDateValue: setDate),
            ],
          ),
        ),
      ),
      bottomNavigationBar: buildInkWell(context),
    );
  }

  Text buildText(String name) {
    return Text(
      name,
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
    );
  }

  InkWell buildInkWell(BuildContext context) {
    return InkWell(
      onTap: () {
        // input String type, double amount
        // Access the transaction box
        final box = objectbox.transactionBox;

        // Create a new Transaction object
        final newTransaction = Transaction(
            title: _titleValue,
            merchantName: _vendorsName,
            amount: _amountValue,
            date: _dateValue,
            invoiceId: _invoiceId,
            isExpense: true,
            imagePath: "",
            notes: "");

        // Add the transaction to the ObjectBox store
        box.put(newTransaction);
        Navigator.pop(context);
      },
      child: Container(
        margin: EdgeInsets.all(16.0),
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.6),
              blurRadius: 4,
              offset: Offset(0, 0),
              spreadRadius: 2,
            ),
          ],
        ),
        child: Center(
          child: Text(
            "Save",
            style: TextStyle(
                color: Colors.white, fontSize: 22, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      leading: InkWell(
        onTap: () => Navigator.pop(context),
        child: Icon(Icons.close, color: Colors.black),
      ),
      title: Text(
        "Add Transaction",
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
      backgroundColor: Colors.white,
      elevation: 0,
    );
  }
}
