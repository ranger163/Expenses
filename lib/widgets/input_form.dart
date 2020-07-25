import 'package:flutter/material.dart';

/// This class is used to hold the input form widgets
class InputForm extends StatelessWidget {
//  String titleInput;
//  String amountInput;

  final titleController = TextEditingController();
  final amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16),
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
//              onChanged: (value) => amountInput = value,
            ),
            FlatButton(
              child: Text('Add transaction'),
              textColor: Colors.blue,
              onPressed: () {
                print(
                    'Title: ${titleController.text}\nAmount: ${amountController.text}');
              },
            ),
          ],
        ),
      ),
    );
  }
}
