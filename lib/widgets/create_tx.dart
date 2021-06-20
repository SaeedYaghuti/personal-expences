import 'package:cash_record/widgets/adaptive_flat_button.dart';
import 'package:flutter/material.dart';

class CreateTransaction extends StatefulWidget {
  final Function formDataHandler;

  // run on 1) first-time 2) every changing focus
  CreateTransaction(this.formDataHandler) {
    print(' > w1 constructor');
  }

  @override
  // run on 1) first-time
  _CreateTransactionState createState() {
    print(' > w2 createState');
    return _CreateTransactionState();
  }
}

class _CreateTransactionState extends State<CreateTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime selectedDate;

  // run on 1) first-time
  _CreateTransactionState() {
    print(' > s1 constructor state');
  }

  @override
  // run on 1) first-time
  void initState() {
    super.initState();
    print(' > s2 initState()');
  }

  @override
  // run on 1) --- 2) every changing focus
  void didUpdateWidget(covariant CreateTransaction oldWidget) {
    super.didUpdateWidget(oldWidget);
    print(' > s4 didUpdateWidget(); oldWidget: $oldWidget');
  }

  @override
  // run on 1) _  2) _  3) close modal
  void dispose() {
    super.dispose();
    print(' > s5 dispose()');
  }

  void submitData() {
    final title = titleController.text;

    if (amountController.text.isEmpty) {
      return;
    }

    final amount = double.parse(amountController.text);

    if (title.isEmpty || amount <= 0 || selectedDate == null) {
      return;
    }

    widget.formDataHandler(title, amount, selectedDate);
    // remove modal after submit
    Navigator.of(context).pop();
  }

  void pickDate() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((date) {
      setState(() {
        selectedDate = date;
      });
    });
  }

  @override
  // run on 1) first-time 2) every changing focus
  Widget build(BuildContext context) {
    print(' > s3 build()');
    return SingleChildScrollView(
      child: Card(
        elevation: 7,
        child: Container(
          padding: const EdgeInsets.only(
            top: 16,
            left: 16,
            right: 16,
            // bottom: MediaQuery.of(context).viewInsets.bottom,
            bottom: 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                decoration: InputDecoration(labelText: "What did you buy?"),
                controller: titleController,
                onSubmitted: (_) => submitData(),
              ),
              TextField(
                decoration: const InputDecoration(labelText: "Cost"),
                controller: amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => submitData(),
              ),
              Container(
                height: 80,
                child: Row(
                  children: [
                    Expanded(
                      child: selectedDate == null
                          ? const Text('DATE NOT CHOOSEN')
                          : Text('Date: $selectedDate'),
                    ),
                    AdaptiveFlatButton('SELECT DATE', pickDate),
                  ],
                ),
              ),
              ElevatedButton(
                child: const Text("add transaction"),
                onPressed: submitData,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// open modal first time
// w1
// w2
// s1
// s2
// s3

// change focus and put data => for all changing focus
// w1
// s4
// s3

// close modal
// s5
