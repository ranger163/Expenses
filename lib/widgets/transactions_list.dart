import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// This class is used to Display transaction item widget with its data
class TransactionsItemList extends StatelessWidget {
  final List<Transaction> _transactionsList;
  final Function _removeTransaction;

  TransactionsItemList(this._transactionsList, this._removeTransaction);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Card(
          margin: EdgeInsets.symmetric(vertical: 4, horizontal: 4),
          elevation: 4,
          child: ListTile(
            leading: CircleAvatar(
              radius: 30,
              child: Padding(
                  padding: EdgeInsets.all(8),
                  child: FittedBox(
                      child: Text('\$${_transactionsList[index].amount}'))),
            ),
            title: Text(
              _transactionsList[index].title,
              style: Theme.of(context).textTheme.title,
            ),
            subtitle:
                Text(DateFormat.yMMMd().format(_transactionsList[index].date)),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              color: Theme.of(context).errorColor,
              onPressed: () => _removeTransaction(_transactionsList[index].id),
            ),
          ),
        );
      },
      itemCount: _transactionsList.length,
    );
  }
}
