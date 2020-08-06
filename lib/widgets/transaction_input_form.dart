import 'package:expenses/widgets/adaptive_flat_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  void _submitTransactionForm() {
    if (_amountController.text.isEmpty) return;
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }
    widget._addTransaction(enteredTitle, enteredAmount, _selectedDate);
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) return;
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 4,
        child: Container(
          padding: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: const InputDecoration(labelText: 'Title'),
                controller: _titleController,
//              onChanged: (value) => titleInput = value,
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Amount'),
                controller: _amountController,

                /// Using numberWithOptions to support IOS
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                onSubmitted: (_) {
                  _submitTransactionForm();
                },
//              onChanged: (value) => amountInput = value,
              ),
              Container(
                height: 70,
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: Text(_selectedDate != null
                            ? 'Picked Date: ${DateFormat.yMMMd().format(_selectedDate)}'
                            : 'No Date Chosen!')),
                    AdaptiveFlatButton('Choose Date', _presentDatePicker),
                  ],
                ),
              ),
              RaisedButton(
                child: const Text('Add transaction'),
                textColor: Colors.white,
                color: Theme.of(context).primaryColor,
                onPressed: () {
                  _submitTransactionForm();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
