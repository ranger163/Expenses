import 'package:expenses/widgets/input_form.dart';
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
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Demo'),
      ),
      body: Column(
//        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(left: 16, right: 16, top: 8),
            child: Card(
              color: Colors.blue,
              child: Text('CHARTS'),
            ),
          ),
          InputForm(),
          TransactionsItemList(),
        ],
      ),
    );
  }
}
