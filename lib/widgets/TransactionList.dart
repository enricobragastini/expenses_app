// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/Transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function(String) deleteFunction;

  TransactionList({ Key? key, required this.transactions, required this.deleteFunction }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      child: (transactions.isEmpty) ? 
        Column(
          children: [
            Text("No transactions added yet!", style: Theme.of(context).textTheme.headline6,),
            SizedBox(height: 20,),
            SizedBox(height: 200, child: Image.asset("assets/images/waiting.png", fit: BoxFit.cover)),
          ],
        ) : 
        ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
            elevation: 5,
            child: ListTile(
              leading: CircleAvatar(
                radius: 30,
                child: Padding(
                  padding: EdgeInsets.all(6),
                  child: FittedBox(
                    child: Text('€ ${transactions[index].amount.toStringAsFixed(2)}'),
                  ),
                ),
              ),
              title: Text(
                transactions[index].title,
                style: Theme.of(context).textTheme.headline6,
              ),
              subtitle: Text(
                DateFormat.yMMMd().format(transactions[index].date)
              ),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                color: Theme.of(context).errorColor,
                onPressed: () => deleteFunction(transactions[index].id),
              ),
            ),
          );
        },
        itemCount: transactions.length,
      )
    );
  }
}