import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Charts extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.all(8),
      child: Row(
        children: groupedTransactionValues
            .map((e) => Column(
                  children: <Widget>[Text('Hi')],
                ))
            .toList(),
      ),
    );
  }
}
