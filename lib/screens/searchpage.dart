import 'package:flutter/material.dart';
// import 'package:objectbox/objectbox.dart';
import 'package:optiparser/components/transaction_tile.dart';
import 'package:optiparser/storage/models/transaction.dart';
import 'package:intl/intl.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  String _merchantName = '';
  DateTime? _dateFrom;
  DateTime? _dateTo;
  bool _isExpense = false;
  List<Transaction> _filteredTransactions = [];

  // Assuming you have a method to fetch filtered transactions from ObjectBox
  void _filterTransactions() {
    setState(() {
      // Logic to filter transactions based on user input
      // _filteredTransactions = getFilteredTransactions(
      //   searchText: _searchController.text,
      //   merchantName: _merchantName,
      //   dateFrom: _dateFrom,
      //   dateTo: _dateTo,
      //   isExpense: _isExpense,
      // );
    });
  }

  void _showMerchantNameBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        TextEditingController _merchantNameController =
            TextEditingController(text: _merchantName);
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _merchantNameController,
                    decoration: InputDecoration(
                      labelText: 'Merchant Name',
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _merchantNameController.clear();
                        },
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _merchantName = value;
                      });
                    },
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _merchantName = _merchantNameController.text;
                        _filterTransactions();
                      });
                      Navigator.pop(context);
                    },
                    child: const Text('Apply'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _showDateBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('From Date'),
                trailing: const Icon(Icons.calendar_today),
                subtitle: _dateFrom != null
                    ? Text(DateFormat('dd/MM/yyyy').format(_dateFrom!))
                    : const Text('Select a date'),
                onTap: () async {
                  DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: _dateFrom ?? DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime.now(),
                  );
                  if (picked != null) {
                    setState(() {
                      _dateFrom = picked;
                    });
                    Navigator.pop(context);
                    _showDateBottomSheet();
                  }
                },
              ),
              ListTile(
                title: const Text('To Date'),
                trailing: const Icon(Icons.calendar_today),
                subtitle: _dateTo != null
                    ? Text(DateFormat('dd/MM/yyyy').format(_dateTo!))
                    : const Text('Select a date'),
                onTap: () async {
                  DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: _dateTo ?? DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime.now(),
                  );
                  if (picked != null) {
                    setState(() {
                      _dateTo = picked;
                    });
                    Navigator.pop(context);
                    _showDateBottomSheet();
                  }
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _dateFrom = null;
                        _dateTo = null;
                        _filterTransactions();
                      });
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _filterTransactions();
                      Navigator.pop(context);
                    },
                    child: const Text('Apply'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search transactions...',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide.none,
            ),
            fillColor: Colors.white,
            filled: true,
            prefixIcon: const Icon(Icons.search),
            suffixIcon: IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                _searchController.clear();
                _filterTransactions();
              },
            ),
          ),
          onChanged: (value) {
            _filterTransactions();
          },
        ),
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ChoiceChip(
                  label: const Text('Merchant Name'),
                  selected: _merchantName.isNotEmpty,
                  onSelected: (selected) {
                    _showMerchantNameBottomSheet();
                  },
                ),
                const SizedBox(width: 8),
                ChoiceChip(
                  label: const Text('Date'),
                  selected: _dateFrom != null || _dateTo != null,
                  onSelected: (selected) {
                    _showDateBottomSheet();
                  },
                ),
                const SizedBox(width: 8),
                ChoiceChip(
                  label: const Text('Expense'),
                  selected: _isExpense,
                  onSelected: (selected) {
                    setState(() {
                      _isExpense = selected;
                    });
                    _filterTransactions();
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: _filteredTransactions.length,
              padding: const EdgeInsets.all(16.0),
              separatorBuilder: (context, index) =>
                  Divider(color: Colors.grey[300]),
              itemBuilder: (context, index) {
                final transaction = _filteredTransactions[index];
                return GestureDetector(
                  onTap: () {
                    _showTransactionDetails(transaction);
                  },
                  child: TransactionTile(
                    title: transaction.title,
                    description: transaction.merchantName,
                    amount: transaction.amount,
                    date: transaction.date,
                    isExpense: transaction.isExpense,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showTransactionDetails(Transaction transaction) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.title,
                  // style: Theme.of(context).textTheme.headline6,
                ),
                const SizedBox(height: 8.0),
                Text(
                  'Merchant: ${transaction.merchantName}',
                  // style: Theme.of(context).textTheme.subtitle1,
                ),
                const SizedBox(height: 8.0),
                Text(
                  'Amount: \$${transaction.amount.toStringAsFixed(2)}',
                  // style: Theme.of(context).textTheme.subtitle1,
                ),
                const SizedBox(height: 8.0),
                Text(
                  'Date: ${DateFormat('dd/MM/yyyy').format(transaction.date)}',
                  // style: Theme.of(context).textTheme.subtitle1,
                ),
                const SizedBox(height: 8.0),
                Text(
                  'Invoice ID: ${transaction.invoiceId}',
                  // style: Theme.of(context).textTheme.subtitle1,
                ),
                const SizedBox(height: 8.0),
                Text(
                  'Notes: ${transaction.notes ?? 'Start noting down your transactions!'}',
                  // style: Theme.of(context).textTheme.subtitle1,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
