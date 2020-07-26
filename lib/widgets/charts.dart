import 'package:expenses/models/transaction.dart';
import 'package:expenses/widgets/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Charts extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Charts(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      var totalAmountSum = 0.0;

      recentTransactions.forEach((element) {
        if (element.date.day == weekDay.day &&
            element.date.month == weekDay.month &&
            element.date.year == weekDay.year) {
          totalAmountSum += element.amount;
        }
      });
      return {'day': DateFormat.E().format(weekDay), 'amount': totalAmountSum};
    });
  }

  double get totalSpending {
    return groupedTransactionValues.fold(
        0.0, (previousValue, element) => previousValue + element['amount']);
  }

  @override
  Widget build(BuildContext context) {
    print(groupedTransactionValues);
    return Card(
        elevation: 4,
        margin: EdgeInsets.all(8),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: groupedTransactionValues
                  .map(
                    (data) => Flexible(
                      fit: FlexFit.tight,
                      child: ChartBar(
                          data['day'],
                          data['amount'],
                          totalSpending == 0.0
                              ? 0.0
                              : (data['amount'] as double) / totalSpending),
                    ),
                  )
                  .toList()),
        ));
  }
}
