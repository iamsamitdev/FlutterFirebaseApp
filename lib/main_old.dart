import 'package:firebaseApp/counterProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<CounterProvider>(
          create: (_) => CounterProvider(),
        ),
      ],
      child:  MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    var _counter =  Provider.of<CounterProvider>(context, listen: false);

    print("build.. build(BuildContext)");
    print("build.. Scaffold");
    print("build.. AppBar");
    print("build.. Center");
    print("build.. Column");
    print("build.. Text");
    print("build.. FloatingActionButton");

    return Scaffold(
      appBar: AppBar(
        title: Text('Provider Manage'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('You have pushed the button this many times'),
            Consumer<CounterProvider>(
              builder: (_, value, __) => Text(
                '${_counter.value}',
                style: Theme.of(context).textTheme.headline4,
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _counter.increment(),
        child: Icon(Icons.add),
      ),
    );
  }
}