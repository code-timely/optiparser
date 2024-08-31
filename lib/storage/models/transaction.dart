import 'package:objectbox/objectbox.dart';

@Entity()
class Transaction{
  @Id(assignable: true)
  int id;

  String title;
  String merchantName;
  double amount;
  DateTime date;
  String invoiceId;
  bool isExpense;
  String imagePath;
  String? notes;

  Transaction({
    this.id = 0,
    required this.title,
    required this.merchantName,
    required this.amount,
    required this.date,
    required this.invoiceId,
    required this.isExpense,
    required this.imagePath,
    this.notes
  });
}