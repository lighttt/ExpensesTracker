import 'package:expenses_tracker/models/transcation.dart';
import 'package:expenses_tracker/widgets/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  List<Transaction> recentTransactions = [];

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedExpenses {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double totalSum = 0.0;
      for (int i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].itemDate.day == weekDay.day &&
            recentTransactions[i].itemDate.month == weekDay.month &&
            recentTransactions[i].itemDate.year == weekDay.year) {
          totalSum += recentTransactions[i].itemPrice;
        }
      }
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum
      };
    }).reversed.toList();
  }

  double get totalSpending {
    return groupedExpenses.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: groupedExpenses.map((data) {
          return Flexible(
            fit: FlexFit.tight,
            child: ChartBar(
                data['day'],
                data['amount'],
                totalSpending == 0.0
                    ? 0.0
                    : (data['amount'] as double) / totalSpending),
          );
        }).toList(),
      ),
    );
  }
}
