import 'package:flutter/material.dart';

void main() => runApp(MyLocalCounterApp());

class MyLocalCounterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Local Counter (Part 1)',
      theme: ThemeData(useMaterial3: true),
      home: Scaffold(
        appBar: AppBar(title: Text('Local State — Counter')),
        body: CounterWidget(),
      ),
    );
  }
}

class CounterWidget extends StatefulWidget {
  @override
  _CounterWidgetState createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  int _counter = 0;

  void _increment() {
    setState(() {
      _counter++;
    });
  }

  void _decrement() {
    if (_counter > 0) {
      setState(() {
        _counter--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Counter Value',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(height: 8),
          Text(
            '$_counter',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          SizedBox(height: 18),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton.icon(
                onPressed: _counter > 0 ? _decrement : null,
                icon: Icon(Icons.remove),
                label: Text('Decrement'),
              ),
              SizedBox(width: 12),
              ElevatedButton.icon(
                onPressed: _increment,
                icon: Icon(Icons.add),
                label: Text('Increment'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
