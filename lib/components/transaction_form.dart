import 'adaptative_date_picker.dart';
import 'package:flutter/material.dart';

import 'adaptative_button.dart';
import 'adaptative_text_field.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) onSubmit;

  TransactionForm(this.onSubmit) {
    print('Constructor TransactionForm');
  }

  @override
  _TransactionFormState createState() {
    print('createState TransactionForm');
    return _TransactionFormState();
  }
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  _TransactionFormState() {
    print('Constructor _TransactionFormState');
  }

  @override
  void initState() {
    super.initState();
    print('init State _TransactionFormState');
  }

  @override
  void didUpdateWidget(Widget oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('didUpdateWidget State _TransactionFormState');
  }

  @override
  void dispose() {
    super.dispose();
    print('dispose  _TransactionFormState');
  }

  _submitForm() {
    final title = _titleController.text;
    final value = double.tryParse(_valueController.text) ?? 0.0;

    if (title.isEmpty || value <= 0 || _selectedDate == null) {
      return;
    }

    widget.onSubmit(title, value, _selectedDate);

    _titleController.text = "";
    _valueController.text = "0.0";
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.only(
            top: 10,
            right: 10,
            left: 10,
            bottom: 10 + mediaQuery.viewInsets.bottom,
          ),
          child: Column(
            children: <Widget>[
              AdaptativeTextField(
                label: 'Título',
                controller: _titleController,
                onSubmitted: (_) => _submitForm(),
              ),
              AdaptativeTextField(
                label: 'Valor R\$',
                controller: _valueController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onSubmitted: (_) => _submitForm(),
              ),
              // Container(
              //   height: 70,
              //   child: Row(
              //     children: [
              //       Expanded(
              //         child: Text(
              //           _selectedDate == null
              //               ? 'Nenhuma Data Selecionada!'
              //               : 'Data Selecionanda: ${DateFormat('dd/MM/y').format(_selectedDate)}',
              //         ),
              //       ),
              //       TextButton(
              //         style: TextButton.styleFrom(
              //           primary: Theme.of(context).primaryColor,
              //         ),
              //         child: Text('Selecionar Data'),
              //         onPressed: _showDatePicker,
              //       )
              //     ],
              //   ),
              // ),
              AdaptativeDatePicker(
                  selectedDate: _selectedDate,
                  onDateChanged: (newDate) {
                    setState(() {
                      _selectedDate = newDate;
                    });
                  }),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  AdaptativeButton(
                    label: 'Nova Transação',
                    onPressed: _submitForm,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
