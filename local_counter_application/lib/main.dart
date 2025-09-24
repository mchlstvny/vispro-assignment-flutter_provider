import 'package:flutter/material.dart';

/// The starting point of the app.
///
/// When the app runs, it calls [MyLocalCounterApp] as the main widget.
void main() => runApp(MyLocalCounterApp());

/// The main app widget.
///
/// This sets up:
/// - The app title shown in the task switcher
/// - The overall theme (Material 3 style)
/// - The first screen the user sees, which contains a counter
class MyLocalCounterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Local Counter (Part 1)',
      theme: ThemeData(useMaterial3: true),
      home: Scaffold(
        appBar: AppBar(title: const Text('Local State Counter')),
        body: CounterWidget(),
      ),
    );
  }
}

/// A widget that shows a counter with two buttons: increment and decrement.
///
/// The counter value is stored **locally inside this widget’s state**.
/// This means every time we change the counter, Flutter rebuilds the UI
/// to reflect the new value.
class CounterWidget extends StatefulWidget {
  @override
  _CounterWidgetState createState() => _CounterWidgetState();
}

/// The state object for [CounterWidget].
///
/// This is where the actual counter value is kept along with the logic to increase and decrease it.
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
          const SizedBox(height: 8),
          Text(
            '$_counter',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 18),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton.icon(
                onPressed: _counter > 0 ? _decrement : null,
                icon: const Icon(Icons.remove),
                label: const Text('Decrement'),
              ),
              const SizedBox(width: 12),
              ElevatedButton.icon(
                onPressed: _increment,
                icon: const Icon(Icons.add),
                label: const Text('Increment'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
