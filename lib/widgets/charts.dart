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

  @override
  Widget build(BuildContext context) {
    print(groupedTransactionValues);
    return Card(
        elevation: 4,
        margin: EdgeInsets.all(8),
        child: Row(
            children: groupedTransactionValues
                .map((data) => ChartBar(data['day'], data['amount'], 0.5))
                .toList()));
  }
}
