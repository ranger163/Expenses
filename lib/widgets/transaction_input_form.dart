import 'package:flutter/material.dart';

/// This class is used to hold the input form widgets
class TransactionInputForm extends StatefulWidget {
//  String titleInput;
//  String amountInput;

  final Function _addTransaction;

  TransactionInputForm(this._addTransaction);

  @override
  _TransactionInputFormState createState() => _TransactionInputFormState();
}

class _TransactionInputFormState extends State<TransactionInputForm> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  void _submitTransactionForm() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0) {
      return;
    }
    widget._addTransaction(enteredTitle, enteredAmount);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
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
