import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './adaptive_button.dart';

class NewTrans extends StatefulWidget {
  final Function addTrans;

  NewTrans(this.addTrans);

  @override
  _NewTransState createState() => _NewTransState();
}

class _NewTransState extends State<NewTrans> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime selectedDate;

  void _submitData(){
    if(amountController.text.isEmpty){
      return;
    }
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if(enteredAmount <= 0 || enteredTitle.isEmpty){
      print('InputFields are Empty');
      return;
    }
    widget.addTrans(
      enteredTitle,
      enteredAmount,
      selectedDate,
    );

    Navigator.of(context).pop();
  }

  void _presentDatePicker(){
    showDatePicker(
      context: context, 
      initialDate: DateTime.now(), 
      firstDate: DateTime(2019), 
      lastDate: DateTime.now(),
    ).then((pickedData){
      if (pickedData == null){
        return;
      }
      setState(() {
        selectedDate = pickedData;
      });
      

    });
      print('');
    
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                // onChanged: (val){
                //   titleInput = val;
                // }
                controller: titleController,
                onSubmitted: (_) => _submitData(),
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Amount'),
                controller: amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitData(),
              ),
              Container(
                height: 70,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text( 
                      selectedDate == null 
                      ? 'No Date Selected!' 
                      : 'Picked Date: ${DateFormat.yMd().format(selectedDate)}',
                      ),
                    ),
                    AdaptiveButton(_presentDatePicker),
                  ]
                ),
              ),
              RaisedButton(
                child: const Text('Add Transaction'),
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                onPressed: _submitData,
              ),
            ]
          ),
        ),
      ),
    );
  }
}