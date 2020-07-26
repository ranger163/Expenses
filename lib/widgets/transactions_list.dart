import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// This class is used to Display transaction item widget with its data
class TransactionsItemList extends StatelessWidget {
  final List<Transaction> _transactionsList;

  TransactionsItemList(this._transactionsList);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: _transactionsList.isEmpty
          ? Column(
              children: <Widget>[
                Container(
                    height: 200,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    )),
                SizedBox(
                  height: 10,
                ),
                Text('No transactions added yet.')
              ],
            )
          : ListView.builder(
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
                              child: Text(
                                  '\$${_transactionsList[index].amount}'))),
                    ),
                    title: Text(
                      _transactionsList[index].title,
                      style: Theme.of(context).textTheme.title,
                    ),
                    subtitle: Text(DateFormat.yMMMd()
                        .format(_transactionsList[index].date)),
                  ),
                );
              },
              itemCount: _transactionsList.length,
            ),
    );
  }
}
