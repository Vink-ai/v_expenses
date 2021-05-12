import 'package:flutter/material.dart';
import './trans_item.dart';
import '../models/transactions.dart';

class TransList extends StatelessWidget {
  final List<Transactions> transaction;
  final Function removeTrans;
  TransList(this.transaction, this.removeTrans);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450,
      child: transaction.isEmpty
          ? LayoutBuilder(builder: (ctx, constraints){
              return Column(
                children: <Widget>[
                  Text(
                    'No Transactions added yer!!',
                    style: Theme.of(context).textTheme.title,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Container(
                    height: constraints.maxHeight * 0.6,
                    child:  Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              );
            }
          ) 
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return TransItem(transaction: transaction[index], removeTrans: removeTrans);
              },
              itemCount: transaction.length,
            ),
    );
  }
}


