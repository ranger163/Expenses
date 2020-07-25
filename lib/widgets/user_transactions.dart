import 'package:expenses/models/transaction.dart';
import 'package:expenses/widgets/input_form.dart';
import 'package:expenses/widgets/transactions_list.dart';
import 'package:flutter/material.dart';

class UserTransactions extends StatefulWidget {
  @override
  _UserTransactionsState createState() => _UserTransactionsState();
}

class _UserTransactionsState extends State<UserTransactions> {
  final List<Transaction> _transactionsList = [
    Transaction(
        id: "id1", title: "New Shoes", amount: 600.00, date: DateTime.now()),
    Transaction(
        id: "id2", title: "New Shirt", amount: 450.50, date: DateTime.now()),
    Transaction(
        id: "id3", title: "New Pants", amount: 300.00, date: DateTime.now()),
    Transaction(
        id: "id2", title: "New Shirt", amount: 450.50, date: DateTime.now()),
    Transaction(
        id: "id3", title: "New Pants", amount: 300.00, date: DateTime.now()),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TransactionInputForm(),
        TransactionsItemList(_transactionsList),
      ],
    );
  }
}
