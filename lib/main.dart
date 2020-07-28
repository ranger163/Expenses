import 'package:expenses/models/transaction.dart';
import 'package:expenses/widgets/charts.dart';
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
        fontFamily: 'Quicksand',
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
              title: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
        ),
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
  final List<Transaction> _transactionsList = [];

  List<Transaction> get _recentTransactions {
    return _transactionsList.where((element) {
      return element.date.isAfter(element.date.subtract(Duration(days: 7)));
    }).toList();
  }

  /// Adding new transaction information to the list
  void _addTransaction(String title, double amount, DateTime selectedDate) {
    setState(() {
      _transactionsList.add(Transaction(
          id: DateTime.now().toString(),
          title: title,
          amount: amount,
          date: selectedDate));
    });
  }

  /// Removing transaction by it's id
  void _removeTransaction(String id) {
    setState(() {
      _transactionsList.removeWhere((element) => element.id == id);
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
    final appBar = AppBar(
      title: Text('Personal Expenses'),
      actions: <Widget>[
        IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _startAddNewTransactionSheet(context)),
      ],
    );

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 16,right: 16,top: 16),
          child: Column(
//        mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                height: (MediaQuery.of(context).size.height -
                        appBar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.2,
                margin: EdgeInsets.only(bottom: 8),
                child: Charts(_recentTransactions),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: (MediaQuery.of(context).size.height -
                        appBar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.8,
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
                    : TransactionsItemList(
                        _transactionsList, _removeTransaction),
              ),
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
