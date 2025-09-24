import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:global_state/global_state.dart';
import 'package:global_state/counter_model.dart';
import 'package:uuid/uuid.dart';

void main() {
  runApp(
    ChangeNotifierProvider<GlobalState>(
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
      body: ReorderableListView(
        onReorder: global.reorder,
        children: [
          for (final counter in global.counters)
            AnimatedContainer(
              key: ValueKey(counter.id),
              duration: Duration(milliseconds: 300),
              color: counter.color.withOpacity(0.2),
              child: ListTile(
                title: Text(counter.label),
                subtitle: AnimatedSwitcher(
                  duration: Duration(milliseconds: 300),
                  transitionBuilder: (child, animation) =>
                      ScaleTransition(scale: animation, child: child),
                  child: Text(
                    '${counter.value}',
                    key: ValueKey(counter.value),
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Edit label
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        final controller = TextEditingController(text: counter.label);
                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: Text("Edit Label"),
                            content: TextField(controller: controller),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  global.updateLabel(counter.id, controller.text);
                                  Navigator.pop(context);
                                },
                                child: Text("Save"),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    // Change color
                    PopupMenuButton<Color>(
                      icon: Icon(Icons.color_lens),
                      onSelected: (color) => global.updateColor(counter.id, color),
                      itemBuilder: (_) => Colors.primaries
                          .map((c) => PopupMenuItem(
                                value: c,
                                child: Container(
                                  width: 50,
                                  height: 20,
                                  color: c,
                                ),
                              ))
                          .toList(),
                    ),
                    // Decrement
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: () => global.decrement(counter.id),
                    ),
                    // Increment
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () => global.increment(counter.id),
                    ),
                    // Delete
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => global.removeCounter(counter.id),
                    ),
                  ],
                ),
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
              color: Colors.primaries[global.counters.length % Colors.primaries.length],
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
