// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  void Function(String, double, DateTime) callback;

  NewTransaction({ Key? key, required this.callback}) : super(key: key);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;

  void _submitData(){
    final enteredTitle = _titleController.text;
    final enteredAmount = _amountController.text;

    if(enteredTitle.isEmpty || enteredAmount.isEmpty || double.parse(enteredAmount) <= 0 || _selectedDate == null){
      return;
    }

    // Chimata alla funzione callback del Widget (dichiarata nel widget, non nel suo stato)
    widget.callback(
      enteredTitle, 
      double.parse(enteredAmount),
      _selectedDate!
    );

    // Chiusura del ModalSheet
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context, 
      initialDate: DateTime.now(), 
      firstDate: DateTime(2021), 
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      
      if(pickedDate == null){
        return;
      }
      
      setState(() {
        _selectedDate = pickedDate;
      });

    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,            
      child: Container(
        padding: EdgeInsets.all(10),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                labelText: "Title",
              ),
              controller: _titleController,
              textInputAction: TextInputAction.next,
            ),
            TextField(
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: "Amount",
              ),
              controller: _amountController,
              onSubmitted: (_) => _submitData(),
            ),

            Container(
              height: 70,
              child: Row(
                children: [
                  Expanded(
                    child: Text((_selectedDate == null) ? 'No text chosen!' : 'Picked Date: ${DateFormat("dd/MM/yyyy").format(_selectedDate!)}')
                  ),
                  TextButton(
                    onPressed: _presentDatePicker, 
                    child: Text("Choose Date", style: TextStyle(fontWeight: FontWeight.bold,)),
                  ),
                ],
              ),
            ),

            ElevatedButton(
              onPressed: _submitData,
              child: Text("Add Transaction", style: TextStyle(fontWeight: FontWeight.normal))
            )
          ]
        ),
      ),
    );
  }
}