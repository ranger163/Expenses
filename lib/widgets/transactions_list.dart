import 'package:expenses/models/transaction.dart';
import 'package:expenses/widgets/transaction_item.dart';
import 'package:flutter/material.dart';

/// This class is used to Display transaction item widget with its data
class TransactionsItemList extends StatelessWidget {
  final List<Transaction> _transactionsList;
  final Function _removeTransaction;

  TransactionsItemList(this._transactionsList, this._removeTransaction);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: _transactionsList
          .map((e) => TransactionItem(
                key: ValueKey(e.id),
                transaction: e,
                removeTransaction: _removeTransaction,
              ))
          .toList(),
    );
  }
}
