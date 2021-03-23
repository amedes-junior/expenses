
import 'package:flutter/material.dart';
import '../models/transaction.dart';
import "package:intl/intl.dart";


class TransactionList extends StatelessWidget {

  final List<Transaction> _transactions;

  TransactionList(this._transactions);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return
      Container(
        height: 300,
        child: ListView.builder(
          itemCount: _transactions.length,
          itemBuilder: (ctx, index){
            final tr = _transactions[index];
            return Card(
            child: Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).primaryColor,
                      width: 2,
                    ),
                  ),
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'R\$ ${tr.value.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      tr.title,
                      style: Theme.of(context).textTheme.headline6,
                      // style: TextStyle(
                      //   fontSize: 16,
                      //   fontWeight: FontWeight.bold,
                      //   //color: Theme.of(context).primaryColor,
                      // ),
                    ),
                    Text(
                      DateFormat('d MMM y').format(tr.date),
                        style: TextStyle(
                        //color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        }
      ),
    );
  }
}