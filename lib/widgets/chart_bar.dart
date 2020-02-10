import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spentAmount;
  final double spentPercent;

  ChartBar(this.label, this.spentAmount, this.spentPercent);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
            height: 15,
            child:
                FittedBox(child: Text("\$${spentAmount.toStringAsFixed(0)}"))),
        SizedBox(
          height: 4,
        ),
        Container(
          width: 10,
          height: 60,
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1.0),
                  color: Color.fromRGBO(220, 220, 220, 1),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              FractionallySizedBox(
                heightFactor: spentPercent,
                child: Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ],
          ),
        ),
        Text("$label")
      ],
    );
  }
}
