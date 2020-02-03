import 'package:expenses_tracker/transcation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Expenses Tracker"),
          centerTitle: true,
        ),
        body: ExpensePage(),
      ),
    );
  }
}

class ExpensePage extends StatefulWidget {
  @override
  _ExpensePageState createState() => _ExpensePageState();
}

class _ExpensePageState extends State<ExpensePage> {
  List<Transaction> transactions = [
    Transaction(
        itemName: "Groceries", itemPrice: 12.50, itemDate: DateTime.now()),
    Transaction(itemName: "Watch", itemPrice: 100.50, itemDate: DateTime.now()),
    Transaction(itemName: "Jacket", itemPrice: 42.50, itemDate: DateTime.now()),
  ];

  String itemName;
  String itemPrice;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          width: double.infinity,
          child: Card(
            child: Text("Chart"),
            elevation: 5,
          ),
        ),
        Card(
          elevation: 5,
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(labelText: "Item Name"),
                  onChanged: (val) {
                    itemName = val;
                  },
                ),
                TextField(
                  decoration: InputDecoration(labelText: "Item Price"),
                  onChanged: (val) {
                    itemPrice = val;
                  },
                ),
                RaisedButton(
                  color: Colors.blue,
                  child: Text("Add Transcation"),
                  textColor: Colors.white,
                  onPressed: () {
                    setState(() {
                      transactions.add(Transaction(
                          itemPrice: double.parse(itemPrice),
                          itemName: itemName,
                          itemDate: DateTime.now()));
                    });
                  },
                )
              ],
            ),
          ),
        ),
        Column(
          children: transactions.map((tx) {
            return Card(
              child: Row(
                children: <Widget>[
                  Container(
                    child: Text(
                      '\$' + tx.itemPrice.toString(),
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.green,
                        width: 2,
                      ),
                    ),
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    padding: EdgeInsets.all(5.0),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        tx.itemName,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25.0,
                        ),
                      ),
                      Text(
                        DateFormat.yMMMEd().format(tx.itemDate),
                        style: TextStyle(fontSize: 15.0, color: Colors.grey),
                      ),
                    ],
                  )
                ],
              ),
            );
          }).toList(),
        )
      ],
    );
  }
}
