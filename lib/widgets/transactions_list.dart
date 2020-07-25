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
                  elevation: 2,
                  margin: EdgeInsets.only(top: 8),
                  child: Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 15,
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(
                          color: Theme.of(context).primaryColor,
                          width: 1,
                        )),
                        padding: EdgeInsets.all(10),
                        child: Text(
                          '\$${_transactionsList[index].amount.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            _transactionsList[index].title,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            DateFormat.yMMMd()
                                .format(_transactionsList[index].date),
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
              itemCount: _transactionsList.length,
            ),
    );
  }
}
