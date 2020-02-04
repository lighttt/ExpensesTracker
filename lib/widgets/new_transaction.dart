import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;
  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final itemNameController = new TextEditingController();
  final itemPriceController = new TextEditingController();

  void submitData() {
    final enteredName = itemNameController.text;
    final enteredPrice = double.parse(itemPriceController.text);

    if (enteredName.isEmpty || enteredPrice < 0) {
      return;
    }
    widget.addTx(enteredName, enteredPrice);
    Navigator.pop(context);
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
              decoration: InputDecoration(labelText: "Item Name"),
              controller: itemNameController,
              onSubmitted: (_) {
                submitData();
              },
            ),
            TextField(
              decoration: InputDecoration(labelText: "Item Price"),
              controller: itemPriceController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) {
                submitData();
              },
            ),
            RaisedButton(
              color: Colors.blue,
              child: Text("Add Transcation"),
              textColor: Colors.white,
              onPressed: submitData,
            )
          ],
        ),
      ),
    );
  }
}
