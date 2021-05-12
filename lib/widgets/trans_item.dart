import 'dart:math';
import 'package:flutter/material.dart';
import '../models/transactions.dart';
import 'package:intl/intl.dart';

class TransItem extends StatefulWidget {
  const TransItem({
    Key key,
    @required this.transaction,
    @required this.removeTrans,
  }) : super(key: key);

  final Transactions transaction;
  final Function removeTrans;

  @override
  _TransItemState createState() => _TransItemState();
}

class _TransItemState extends State<TransItem> {
  Color _bgColor;

  @override

  void initState(){
    const availableColors = [
      Colors.red, 
      Colors.black,
      Colors.yellow,
      Colors.indigo,
    ];

    _bgColor = availableColors[Random().nextInt(4)];
    super.initState();
  }

  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(
        vertical: 4,
        horizontal: 4,
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _bgColor,
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: FittedBox(
              child: Text(
                '₹${widget.transaction.amount}',
              ),
            ),
          ),
        ),
        title: Text(
          widget.transaction.title,
          style: Theme.of(context).textTheme.title,
        ),
        subtitle: Text(
          DateFormat.yMMMd().format(widget.transaction.date),
        ),
        trailing: MediaQuery.of(context).size.width > 460 ? FlatButton.icon(
          icon: const Icon(Icons.delete),
          onPressed: () => widget.removeTrans(widget.transaction.id), 
          textColor : Theme.of(context).errorColor, 
          label: const Text('Delete'),
          ) : IconButton(
          icon: const Icon(Icons.delete),
          color: Theme.of(context).errorColor, 
          onPressed: () => widget.removeTrans(widget.transaction.id),
        ),
      ),
    );
  }
}