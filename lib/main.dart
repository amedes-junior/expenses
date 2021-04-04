import 'package:expenses/components/chart.dart';
import 'package:expenses/components/transaction_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';
import 'components/transaction_form.dart';
import 'components/transaction_list.dart';
import 'models/transaction.dart';

import 'dart:io';

main() => runApp(ExpensesApp());

class ExpensesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    return MaterialApp(
      home: MyHomePage(),
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
            headline6: TextStyle(
              fontFamily: 'Opensans',
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            button:
                TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontFamily: 'Opensans',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _showChart = false;

  final List<Transaction> _transactions = [
    Transaction(
      id: 't0',
      title: 'Conta Antiga',
      value: 400.00,
      date: DateTime.now().subtract(Duration(days: 7)),
    ),
    Transaction(
      id: 't1',
      title: 'Novo Tênis de Corrida',
      value: 310.76,
      date: DateTime.now().subtract(Duration(days: 6)),
    ),
    Transaction(
      id: 't2',
      title: 'Conta de Luz',
      value: 211.30,
      date: DateTime.now().subtract(Duration(days: 5)),
    ),
    Transaction(
      id: 't3',
      title: 'Cartão de Crédito',
      value: 456.78,
      date: DateTime.now().subtract(Duration(days: 4)),
    ),
    Transaction(
      id: 't4',
      title: 'Lanche',
      value: 111.30,
      date: DateTime.now().subtract(Duration(days: 3)),
    ),
    Transaction(
      id: 't5',
      title: 'Monitor',
      value: 543.30,
      date: DateTime.now().subtract(Duration(days: 2)),
    ),
    Transaction(
      id: 't6',
      title: 'CAGECE',
      value: 145.78,
      date: DateTime.now().subtract(Duration(days: 1)),
    ),
    Transaction(
      id: 't7',
      title: 'COELCE',
      value: 245.78,
      date: DateTime.now(),
    ),
  ];

  List<Transaction> get _recentTransactions {
    return _transactions.where((tr) {
      return tr.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  _addTransaction(String title, double value, DateTime date) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: date,
    );

    setState(() {
      _transactions.add(newTransaction);
    });
    Navigator.of(context).pop();
  }

  _removeTransaction(String id) {
    setState(() {
      _transactions.removeWhere((tr) => tr.id == id);
    });
  }

  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return TransactionForm(_addTransaction);
        });
  }

  Widget _getIconButton(IconData icon, Function fn) {
    return Platform.isIOS
        ? GestureDetector(
            onTap: fn,
            child: Icon(icon),
          )
        : IconButton(icon: Icon(icon), onPressed: fn);
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    bool isLandscape = mediaQuery.orientation == Orientation.landscape;

    final iconList = Platform.isIOS ? CupertinoIcons.news : Icons.list;
    final chartIcon =
        Platform.isIOS ? CupertinoIcons.refresh : Icons.show_chart;

    final actions = <Widget>[
      if (isLandscape)
        _getIconButton(
          _showChart ? iconList : chartIcon,
          () {
            setState(() {
              _showChart = !_showChart;
            });
          },
        ),
      _getIconButton(
        Platform.isIOS ? CupertinoIcons.add : Icons.add,
        () => _openTransactionFormModal(context),
      )
    ];

    final PreferredSizeWidget appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text('Despesas Pessoais'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: actions,
            ),
          )
        : AppBar(title: Text('Depesas Pessoais'), actions: actions);

    final availableHeight = mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top;

    final bodyPage = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // if (isLandscape)
            //   Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       Text('Exibir Gráfico'),
            //       Switch.adaptive(
            //         activeColor: Theme.of(context).accentColor,
            //         value: _showChart,
            //         onChanged: (value) {
            //           setState(() {
            //             _showChart = value;
            //           });
            //         },
            //       ),
            //     ],
            //   ),
            if (_showChart || !isLandscape)
              Container(
                  height: availableHeight * (isLandscape ? 0.8 : 0.3),
                  child: Chart(_recentTransactions)),
            if (!_showChart || !isLandscape)
              Container(
                  height: availableHeight * (isLandscape ? 1 : 0.7),
                  child: TransactionList(_transactions, _removeTransaction)),
          ],
        ),
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: appBar,
            child: bodyPage,
          )
        : Scaffold(
            appBar: appBar,
            body: bodyPage,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () => _openTransactionFormModal(context),
                  ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
  }
}
