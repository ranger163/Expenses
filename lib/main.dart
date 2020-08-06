import 'dart:io';

import 'package:expenses/models/transaction.dart';
import 'package:expenses/widgets/charts.dart';
import 'package:expenses/widgets/transaction_input_form.dart';
import 'package:expenses/widgets/transactions_list.dart';
import 'package:flutter/cupertino.dart';
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
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final isIos = Platform.isIOS;

    final PreferredSizeWidget appBar = isIos
        ? CupertinoNavigationBar(
            middle: Text('Personal Expenses'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GestureDetector(
                    child: Icon(CupertinoIcons.add),
                    onTap: () => _startAddNewTransactionSheet(context)),
              ],
            ),
          )
        : AppBar(
            title: Text('Personal Expenses'),
            actions: <Widget>[
              isIos
                  ? IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () => _startAddNewTransactionSheet(context))
                  : Container(),
            ],
          );

    final txListWidget = Container(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
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
                    const SizedBox(
                      height: 10,
                    ),
                    const Text('No transactions added yet.')
                  ],
                );
              },
            )
          : TransactionsItemList(_transactionsList, _removeTransaction),
    );

    final pageBody = SafeArea(
      child: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(left: 16, right: 16),
          child: Column(
//        mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              if (isLandscape)
                _buildLandscapeContent(context),
              if (!isLandscape)
                _buildPortraitContent(mediaQuery, appBar),
              if (!isLandscape) txListWidget,
              if (isLandscape)
                _showCharts
                    ? Container(
                        height: (mediaQuery.size.height -
                                appBar.preferredSize.height -
                                mediaQuery.padding.top) *
                            0.7,
                        margin: const EdgeInsets.only(bottom: 8),
                        child: Charts(_recentTransactions),
                      )
                    : txListWidget
            ],
          ),
        ),
      ),
    );

    return isIos
        ? CupertinoPageScaffold(
            navigationBar: appBar,
            child: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.only(left: 16, right: 16),
                child: Column(
//        mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    if (isLandscape)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Text('Show Charts'),
                          Switch.adaptive(
                              activeColor: Theme.of(context).accentColor,
                              value: _showCharts,
                              onChanged: (value) {
                                setState(() {
                                  _showCharts = value;
                                });
                              }),
                        ],
                      ),
                    if (!isLandscape)
                      _buildPortraitContent(mediaQuery, appBar),
                    if (!isLandscape) txListWidget,
                    if (isLandscape)
                      _showCharts
                          ? Container(
                              height: (mediaQuery.size.height -
                                      appBar.preferredSize.height -
                                      mediaQuery.padding.top) *
                                  0.7,
                              margin: const EdgeInsets.only(bottom: 8),
                              child: Charts(_recentTransactions),
                            )
                          : txListWidget
                  ],
                ),
              ),
            ),
          )
        : Scaffold(
            appBar: appBar,
            body: pageBody,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: isIos
                ? Container()
                : FloatingActionButton(
                    child: const Icon(Icons.add),
                    onPressed: () => _startAddNewTransactionSheet(context),
                  ),
          );
  }

  Widget _buildPortraitContent(MediaQueryData mediaQuery, PreferredSizeWidget appBar) {
    return Container(
                height: (mediaQuery.size.height -
                        appBar.preferredSize.height -
                        mediaQuery.padding.top) *
                    0.2,
                margin: const EdgeInsets.only(bottom: 8),
                child: Charts(_recentTransactions),
              );
  }

  Widget _buildLandscapeContent(BuildContext context) {
    return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Show Charts',
                      style: Theme.of(context).textTheme.headline6),
                  Switch.adaptive(
                      activeColor: Theme.of(context).accentColor,
                      value: _showCharts,
                      onChanged: (value) {
                        setState(() {
                          _showCharts = value;
                        });
                      }),
                ],
              );
  }
}
