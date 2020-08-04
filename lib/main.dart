import 'package:expenses/models/transaction.dart';
import 'package:expenses/widgets/charts.dart';
import 'package:expenses/widgets/transaction_input_form.dart';
import 'package:expenses/widgets/transactions_list.dart';
import 'package:flutter/material.dart';

void main() {
  /// Using these functions to lock screen orientation to portrait
//  WidgetsFlutterBinding.ensureInitialized();
//  SystemChrome.setPreferredOrientations(
//      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
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
  bool _showCharts = false;

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
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    final appBar = AppBar(
      title: Text('Personal Expenses'),
      actions: <Widget>[
        IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _startAddNewTransactionSheet(context)),
      ],
    );

    final txListWidget = Container(
      height: (MediaQuery.of(context).size.height -
              appBar.preferredSize.height -
              MediaQuery.of(context).padding.top) *
          0.7,
      child: _transactionsList.isEmpty
          ? LayoutBuilder(
              builder: (context, constraints) {
                return Column(
                  children: <Widget>[
                    Container(
                        height: constraints.maxHeight * 0.6,
                        child: Image.asset(
                          'assets/images/waiting.png',
                          fit: BoxFit.cover,
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    Text('No transactions added yet.')
                  ],
                );
              },
            )
          : TransactionsItemList(_transactionsList, _removeTransaction),
    );

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 16, right: 16),
          child: Column(
//        mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              if (isLandscape)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Show Charts'),
                    Switch(
                        value: _showCharts,
                        onChanged: (value) {
                          setState(() {
                            _showCharts = value;
                          });
                        }),
                  ],
                ),
              if (!isLandscape)
                Container(
                  height: (MediaQuery.of(context).size.height -
                          appBar.preferredSize.height -
                          MediaQuery.of(context).padding.top) *
                      0.2,
                  margin: EdgeInsets.only(bottom: 8),
                  child: Charts(_recentTransactions),
                ),
              if (!isLandscape) txListWidget,
              if (isLandscape)
                _showCharts
                    ? Container(
                        height: (MediaQuery.of(context).size.height -
                                appBar.preferredSize.height -
                                MediaQuery.of(context).padding.top) *
                            0.7,
                        margin: EdgeInsets.only(bottom: 8),
                        child: Charts(_recentTransactions),
                      )
                    : txListWidget
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
