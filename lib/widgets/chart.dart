import 'package:flutter/material.dart';
import '../models/transactions.dart';
import 'package:intl/intl.dart';
import './chart_bars.dart';

class Chart extends StatelessWidget {
  final List<Transactions> recentTrans;
  
  Chart(this.recentTrans);

  List<Map<String, Object>> get groupedTrans{
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index),); //gets the day
      var totalSum = 0.0;

      for(var i = 0; i < recentTrans.length; i++) {
          if(recentTrans[i].date.day == weekDay.day && 
             recentTrans[i].date.month == weekDay.month &&
             recentTrans[i].date.year == weekDay.year) {
          totalSum  += recentTrans[i].amount;
        }
      } 

      print(DateFormat.E().format(weekDay));
      print(totalSum);

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),    //gets a shortcut for the day
        'amount': totalSum,   //gets total sum of spending on that day
      };
    }).toList();
  }

  double get totalSpending {
    return groupedTrans.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    print(groupedTrans);
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTrans.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                data['day'], 
                data['amount'], 
                totalSpending == 0.0 ? 0.0 : (data['amount'] as double) / totalSpending,
              ),
            );
          }).toList()
        ),
      ),
    );
  }
}