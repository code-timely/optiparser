import 'package:optiparser/storage/models/transaction.dart';
import "package:logger/logger.dart";
import 'package:optiparser/objectbox.g.dart';
import 'package:optiparser/storage/initialise_objectbox.dart';

final logger = Logger();

List<Transaction> getFilteredTransactions({
  required String searchText,
  required bool expense,
  required bool income,
  required double? min_amount,
  required double? max_amount,
  required DateTime? dateFrom,
  required DateTime? dateTo,

}) {

  logger.i("db filtering transactions");

  logger.i("$searchText\t$expense$dateFrom\t$dateTo\t$min_amount\t$max_amount");

  final adjustedDateTo = dateTo != null ? dateTo.add(const Duration(days: 1)).subtract(const Duration(seconds: 1)) : null;

  final queryBuilder = objectbox.transactionBox.query(
    (Transaction_.title.contains(searchText, caseSensitive: false) |
      Transaction_.merchantName.contains(searchText, caseSensitive: false)|
      Transaction_.invoiceId.contains(searchText,caseSensitive: false)) &
    (dateFrom != null ? Transaction_.date.greaterOrEqual(dateFrom.millisecondsSinceEpoch) : Transaction_.date.greaterThan(0)) &
    (adjustedDateTo != null ? Transaction_.date.lessOrEqual(adjustedDateTo.millisecondsSinceEpoch) : Transaction_.date.lessThan(DateTime.now().millisecondsSinceEpoch)) &
    (expense ? Transaction_.isExpense.equals(true) :Transaction_.isExpense.equals(true) | Transaction_.isExpense.equals(false))&
    (income ? Transaction_.isExpense.equals(false) :Transaction_.isExpense.equals(true) | Transaction_.isExpense.equals(false)) &
    (min_amount!=null?Transaction_.amount.greaterOrEqual(min_amount) :Transaction_.isExpense.equals(true) | Transaction_.isExpense.equals(false)) &
    (max_amount!=null?Transaction_.amount.greaterOrEqual(max_amount):Transaction_.isExpense.equals(true) | Transaction_.isExpense.equals(false))
  ).order(Transaction_.id);

  final query = queryBuilder.build();
  final transactions = query.find();

  query.close();

  return transactions;
}
