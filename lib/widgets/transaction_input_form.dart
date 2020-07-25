import 'package:flutter/material.dart';

/// This class is used to hold the input form widgets
class TransactionInputForm extends StatelessWidget {
//  String titleInput;
//  String amountInput;

  final titleController = TextEditingController();
  final amountController = TextEditingController();
  final Function _addTransaction;

  TransactionInputForm(this._addTransaction);

  void _submitTransactionForm() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0) {
      return;
    }
    _addTransaction(enteredTitle, enteredAmount);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(top: 16, bottom: 16),
      elevation: 4,
      child: Container(
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: titleController,
//              onChanged: (value) => titleInput = value,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountController,

              /// Using numberWithOptions to support IOS
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              onSubmitted: (_) {
                _submitTransactionForm();
              },
//              onChanged: (value) => amountInput = value,
            ),
            FlatButton(
              child: Text('Add transaction'),
              textColor: Colors.blue,
              onPressed: () {
                _submitTransactionForm();
              },
            ),
          ],
        ),
      ),
    );
  }
}
