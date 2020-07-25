import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// This class is used to Display transaction item widget with its data
class TransactionsItemList extends StatefulWidget {
  @override
  _TransactionsItemListState createState() => _TransactionsItemListState();
}

class _TransactionsItemListState extends State<TransactionsItemList> {
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
      children: _transactionsList.map((transaction) {
        return Card(
          margin: EdgeInsets.only(left: 16, right: 16, top: 8),
          child: Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 15,
                ),
                decoration: BoxDecoration(
                    border: Border.all(
                  color: Colors.blue,
                  width: 1,
                )),
                padding: EdgeInsets.all(10),
                child: Text(
                  '\$${transaction.amount}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.blue,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    transaction.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    DateFormat.yMMMd().format(transaction.date),
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
