import 'package:optiparser/storage/initialise_objectbox.dart';
import 'package:optiparser/storage/models/transaction.dart';

// Transaction? getTransactionById(int id) {
//   return objectbox.transactionBox.get(id);
// }

Future<Transaction?> getTransactionById(int id) async {
  return objectbox.transactionBox.get(id);
}
