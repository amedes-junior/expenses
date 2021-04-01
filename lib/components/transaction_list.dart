
import 'package:flutter/material.dart';
import '../models/transaction.dart';
import "package:intl/intl.dart";


class TransactionList extends StatelessWidget {

  final List<Transaction> _transactions;
  final void Function(String) onRemove;

  TransactionList(this._transactions, this.onRemove);

  @override
  Widget build(BuildContext context) {
    return
      Container(
        height: 440,
        child: _transactions.isEmpty ?
        Column(
          children: [
            Text(
              'Nenhuma Transação Cadastrada',
              style: Theme.of(context).textTheme.headline6
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 250,
              child: Image.asset(
                'assets/image/waiting.png',
                fit: BoxFit.cover
                ),
            )
          ],
        )  :
        ListView.builder(
          itemCount: _transactions.length,
          itemBuilder: (ctx, index){
            final tr = _transactions[index];
            return Card(
              elevation: 5,
              margin: EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 5
              ),
              child: ListTile(
                leading: CircleAvatar(
                  radius: 30,
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: FittedBox(child: Text('R\$${tr.value}')),
                  ),
                ),
                title: Text(
                  tr.title,
                  style: Theme.of(context).textTheme.headline6,
                ),
                subtitle: Text(
                  DateFormat('d MMM y').format(tr.date)
                ),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => onRemove(tr.id),
                  color: Theme.of(context).errorColor,
                ),
              ),
            );

        }
      ),
    );
  }
}