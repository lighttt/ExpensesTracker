import 'package:expenses_tracker/widgets/adpative_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:io';

class NewTransaction extends StatefulWidget {
  final Function addTx;
  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final itemNameController = new TextEditingController();
  final itemPriceController = new TextEditingController();
  DateTime _selectedDateTime;

  void submitData() {
    final enteredName = itemNameController.text;
    final enteredPrice = double.parse(itemPriceController.text);

    if (enteredName.isEmpty || enteredPrice < 0 || _selectedDateTime == null) {
      return;
    }
    widget.addTx(enteredName, enteredPrice, _selectedDateTime);
    Navigator.pop(context);
  }

  void _pickDate() {
    Platform.isIOS
        ? CupertinoDatePicker(
            initialDateTime: DateTime.now(),
            maximumDate: DateTime.now(),
            minimumDate: DateTime(2020),
            onDateTimeChanged: (pickedDate) {
              setState(() {
                _selectedDateTime = pickedDate;
              });
            },
          )
        : showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2020),
                lastDate: DateTime.now())
            .then((pickedDate) {
            setState(() {
              _selectedDateTime = pickedDate;
            });
          });
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
              bottom: MediaQuery.of(context).viewInsets.bottom + 10),
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
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      _selectedDateTime == null
                          ? "No date entered"
                          : "Picked Date : ${DateFormat.yMd().format(_selectedDateTime)}",
                      style: Theme.of(context).textTheme.title.copyWith(
                          fontSize: 16, fontWeight: FontWeight.normal),
                    ),
                  ),
                  AdaptiveButton(
                    text: "Choose a date",
                    onPress: _pickDate,
                  )
                ],
              ),
              RaisedButton(
                color: Theme.of(context).accentColor,
                child: Text("Add Transcation"),
                textColor: Colors.white,
                onPressed: submitData,
              )
            ],
          ),
        ),
      ),
    );
  }
}
