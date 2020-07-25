import 'package:expenses/models/transaction.dart';
import 'package:expenses/widgets/transaction_input_form.dart';
import 'package:expenses/widgets/transactions_list.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
        primarySwatch: Colors.green,
        accentColor: Colors.amber,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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

  /// Adding new transaction information to the list
  void _addTransaction(String title, double amount) {
    setState(() {
      _transactionsList.add(Transaction(
          id: DateTime.now().toString(),
          title: title,
          amount: amount,
          date: DateTime.now()));
    });
  }

  /// Starting bottom sheet to let user fill his transaction info
  void _startAddNewTransactionSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return TransactionInputForm(_addTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () => _startAddNewTransactionSheet(context)),
        ],
        title: Text('Personal Expenses'),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(16),
          child: Column(
//        mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 8),
                child: Card(
                  color: Colors.blue,
                  child: Text('CHARTS'),
                ),
              ),
              TransactionsItemList(_transactionsList),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransactionSheet(context),
      ),
    );
  }
}
