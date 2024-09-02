import 'package:optiparser/storage/initialise_objectbox.dart';
import 'package:optiparser/storage/models/transaction.dart';

List<Transaction> getTransactions() {
  return objectbox.transactionBox.getAll().reversed.toList();
}
