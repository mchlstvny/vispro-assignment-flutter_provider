import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:global_state/global_state.dart';
import 'package:global_state/counter_model.dart';
import 'package:uuid/uuid.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => GlobalState(),
      child: MyGlobalCounterApp(),
    ),
  );
}

class MyGlobalCounterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Global State — Counters',
      theme: ThemeData(useMaterial3: true),
      home: CounterListPage(),
    );
  }
}

class CounterListPage extends StatelessWidget {
  final _uuid = Uuid();

  @override
  Widget build(BuildContext context) {
    final global = Provider.of<GlobalState>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Global Counters")),
      body: ListView(
        children: [
          for (final counter in global.counters)
            ListTile(
              key: ValueKey(counter.id),
              title: Text(counter.label),
              subtitle: Text('${counter.value}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: () => global.decrement(counter.id),
                  ),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () => global.increment(counter.id),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => global.removeCounter(counter.id),
                  ),
                ],
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          global.addCounter(
            CounterModel(
              id: _uuid.v4(),
              label: "Counter ${global.counters.length + 1}",
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
