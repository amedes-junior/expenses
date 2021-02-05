import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

main() => runApp(ExpendesesApp());

class ExpendesesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MyHomePage());
  }
}

class MyHomePage extends StatelessWidget {

  String title;
  String value;

  final _transactions = [
    Transaction(
        id: 't1',
        title: 'Novo Tênis de Corrida',
        value: 310.76,
        date: DateTime.now()),
    Transaction(
        id: 't2', title: 'Conta de Luz', value: 1211.30, date: DateTime.now()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Despesas Pessoais'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              child: Card(
                color: Colors.blue,
                child: Text('Gráfico'),
                elevation: 5,
              ),
            ),
            Column(
              children: _transactions.map((tr) {
                return Card(
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.purple,
                            width: 2
                          )
                        ),
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'R\$ ${NumberFormat("#,##0.00", "pt-BR").format(tr.value)}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.purple
                          )
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(tr.title,
                          style: TextStyle(
                              fontWeight:FontWeight.bold,
                              fontSize: 16,
                              color: Colors.black
                            )),
                          Text(
                            DateFormat('d MMM y').format(tr.date),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey
                            )
                          )
                        ]
                      )
                    ],
                  ),
                );
              }).toList(),
            ),
            Card(
             elevation: 5,
             child: Padding(
               padding: const EdgeInsets.all(10),
               child: Column(
                 children: [
                   TextField(
                     decoration: InputDecoration(
                       labelText: 'Título'
                     ) ,
                   ),
                   TextField(
                     onChanged: ,
                     decoration: InputDecoration(
                       labelText: 'Valor R\$'
                     ),
                   ),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.end,
                     children: [
                       FlatButton(
                         child: Text('Nova Transação'),
                         textColor: Colors.purple,
                         onPressed: () => {},
                       ),
                     ],
                   )
                 ],
               ),
             ),
            ),
          ],
        ));
  }
}
