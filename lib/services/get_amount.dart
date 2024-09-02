import 'package:optiparser/objectbox.g.dart';
import 'package:optiparser/storage/initialise_objectbox.dart';
import 'package:optiparser/storage/models/transaction.dart';

Map<String, double> getAmount() {
  double income = 0;
  double expenses = 0;
  double balance = 0;
  Box<Transaction> transactionBox;
  transactionBox = objectbox.transactionBox;
  // Query all transactions and sum income and expenses
  for (var transaction in transactionBox.getAll()) {
    if (!transaction.isExpense) {
      income += transaction.amount;
    } else {
      expenses += transaction.amount;
    }
  }
  balance = income - expenses;

  return {
    'income': income,
    'expenses': expenses,
    'balance': balance,
  };
}
