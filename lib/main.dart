import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import './models/transaction.dart';
import './widgets/create_tx.dart';
import './widgets/weekly_chart.dart';
import './widgets/transactions_list.dart';

void main() {
  // to disabel landscape
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // delete DEBUG label or Debug banner
      debugShowCheckedModeBanner: false,
      title: 'Personal Expenses',
      home: MyHomePage(),
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        errorColor: Colors.pinkAccent,
        textTheme: ThemeData.light().textTheme.copyWith(
              title: const TextStyle(
                fontFamily: 'Quicksand',
              ),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                title: const TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                  // fontWeight: FontWeight.bold,
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

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  final List<Transaction> transactions = [
    // Transaction(
    //   id: "t1",
    //   title: "Grocery",
    //   amount: 12.99,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: "t2",
    //   title: "Shoes",
    //   amount: 45.55,
    //   date: DateTime.now(),
    // ),
  ];

  @override
  void initState() {
    print(' > s1 initState');
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    print(' > s2 lifecycle change $state');
    // inactive
    // paused

    // resumed
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
    print(' > s3 dispose state');
  }

  void addTx(String title, double amount, DateTime date) {
    var newTx = Transaction(
      id: DateTime.now().toString(),
      title: title,
      amount: amount,
      date: date,
    );
    setState(() {
      transactions.add(newTx);
    });
  }

  void deleteTransaction(String id) {
    setState(() {
      transactions.removeWhere((tx) => tx.id == id);
    });
  }

  void showCreateTxForm(BuildContext appCtx) {
    showModalBottomSheet(
        context: appCtx,
        builder: (bCtx) {
          return GestureDetector(
            onTap: () {},
            child: CreateTransaction(addTx),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  List<Transaction> get pastWeekTransactions {
    return transactions.where((tx) {
      return true;
    }).toList();
  }

  bool showSummery = false;
  bool noSummery = true;
  void changeShowSummeryState(bool doShow) {
    setState(() {
      showSummery = doShow;
      noSummery = !doShow;
    });
  }

  List<Widget> buildPortraitBodyContent(double bodyHeight, bool showSummery) {
    return [
      Container(
        height: bodyHeight * 0.2,
        child: WeeklyChart(pastWeekTransactions),
      ),
      Container(
        height: bodyHeight * (showSummery ? 0.8 : 1),
        child: TransactionList(transactions, deleteTransaction),
      ),
    ];
  }

  List<Widget> buildLandscapeBodyContent(double bodyHeight, bool showSummery) {
    return [
      // transactio
      if (showSummery)
        Container(
          height: bodyHeight,
          child: TransactionList(transactions, deleteTransaction),
        ),
      // summery chart
      if (!showSummery)
        Container(
          height: bodyHeight,
          child: WeeklyChart(pastWeekTransactions),
        ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    var isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    var isPortrait = !isLandscape;

    final PreferredSizeWidget androidAppBar = AppBar(
      title: const Text("Personal Expenses"),
      actions: [
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () => showCreateTxForm(context),
        ),
        if (isLandscape)
          Row(
            children: [
              Text(
                'SUMMERY',
                // style: Theme.of(context).textTheme.subtitle1,
                style: TextStyle(
                    fontFamily: 'OpenSand',
                    color: showSummery
                        ? Theme.of(context).accentColor
                        : Colors.black),
              ),
              // Text(
              //   'SUMMERY',
              //   style: TextStyle(color: Colors.white),
              // ),
              Switch.adaptive(
                value: showSummery,
                onChanged: (val) => changeShowSummeryState(val),
                activeColor: Theme.of(context).accentColor,
              ),
            ],
          )
      ],
    );

    final PreferredSizeWidget iosNavigationBar = CupertinoNavigationBar(
      middle: const Text('Personal Expense'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ** cupetino don't support IconButton
          GestureDetector(
            child: const Icon(CupertinoIcons.add),
            onTap: () => showCreateTxForm(context),
          ),
          if (isLandscape)
            Container(
              margin: const EdgeInsets.only(
                left: 5,
              ),
              child: Row(
                children: [
                  Text(
                    'SUMMERY',
                    // style: Theme.of(context).textTheme.subtitle1,
                    // ** Cupetrino don't add default theme to text
                    style: TextStyle(
                        fontFamily: 'OpenSand',
                        color: showSummery
                            ? Theme.of(context).accentColor
                            : Colors.black),
                  ),
                  // ** Cupetino don't support Switch
                  CupertinoSwitch(
                    value: showSummery,
                    onChanged: (val) => changeShowSummeryState(val),
                    activeColor: Theme.of(context).accentColor,
                  ),
                ],
              ),
            )

          // CupertinoSwitch(
          //   value: showSummery,
          //   onChanged: (val) => changeShowSummeryState(val),
          //   activeColor: Theme.of(context).accentColor,
          // ),
          // Text(
          //   'SUMMERY',
          //   style: Theme.of(context).textTheme.subtitle1,
          // ),

          // IconButton(
          //   icon: Icon(Icons.add),
          //   onPressed: () => showCreateTxForm(context),
          // ),
          // Text(
          //   'SUMMERY',
          //   style: TextStyle(color: Colors.white),
          // ),
          // Switch.adaptive(
          //   value: showSummery,
          //   onChanged: (val) => changeShowSummeryState(val),
          //   activeColor: Theme.of(context).accentColor,
          // ),
        ],
      ),
    );

    final PreferredSizeWidget appBar =
        Platform.isAndroid ? androidAppBar : iosNavigationBar;

    var bodyHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        appBar.preferredSize.height;

    final appBody = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (isPortrait)
              ...buildPortraitBodyContent(bodyHeight, showSummery),
            if (isLandscape)
              ...buildLandscapeBodyContent(bodyHeight, showSummery),
          ],
        ),
      ),
    );

    final androidScafforld = Scaffold(
      appBar: appBar,
      body: appBody,
      floatingActionButton: Platform.isIOS || Platform.isAndroid
          ? Container()
          : FloatingActionButton(
              child: const Icon(
                Icons.add,
              ),
              onPressed: () => showCreateTxForm(context),
            ),
    );

    final iosSacaffold = CupertinoPageScaffold(
      navigationBar: iosNavigationBar,
      child: appBody,
    );

    // return iosSacaffold;
    return androidScafforld;
  }
}
