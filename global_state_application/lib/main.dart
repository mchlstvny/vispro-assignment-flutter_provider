import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:global_state/global_state.dart';
import 'package:global_state/counter_model.dart';
import 'package:uuid/uuid.dart';

/// The starting point of the app.
///
/// Wraps the whole app in a [ChangeNotifierProvider] so that
/// all widgets can access and update the shared [GlobalState].
void main() {
  runApp(
    ChangeNotifierProvider<GlobalState>(
      create: (_) => GlobalState(),
      child: MyGlobalCounterApp(),
    ),
  );
}

/// The main app widget.
///
/// Sets up the title, theme, and the first screen of the app,
/// which is [CounterListPage].
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

/// The page that shows all counters in a list.
///
/// This widget reads from the [GlobalState] and displays:
/// - A list of counters (each with label, value, and color)
/// - Buttons to edit, change color, increment, decrement, or delete a counter
/// - A floating action button to add new counters
///
/// The list is reorderable so counters can be rearranged by the user.
class CounterListPage extends StatelessWidget {
  final _uuid = Uuid();

  @override
  Widget build(BuildContext context) {
    // Get access to the global state object provided at the root
    final global = Provider.of<GlobalState>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Global Counters")),
      body: Stack(
        children: [
          ReorderableListView(
            onReorder: global.reorder,
            children: [
              for (final counter in global.counters)
                AnimatedContainer(
                  key: ValueKey(counter.id),
                  duration: const Duration(milliseconds: 300),
                  color: counter.color.withOpacity(0.2),
                  child: ListTile(
                    title: Text(counter.label),
                    subtitle: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      transitionBuilder: (child, animation) =>
                          ScaleTransition(scale: animation, child: child),
                      child: Text(
                        '${counter.value}',
                        key: ValueKey(counter.value),
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Edit Label Button
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            final controller =
                                TextEditingController(text: counter.label);
                            showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                title: const Text("Edit Label"),
                                content: TextField(controller: controller),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      bool success = global.updateLabel(
                                          counter.id, controller.text);
                                      if (!success) {
                                        showDialog(
                                          context: context,
                                          builder: (_) => AlertDialog(
                                            title: const Text(
                                              'Invalid Input',
                                              style:
                                                  TextStyle(color: Colors.red),
                                            ),
                                            content: const Text(
                                              'Label cannot be empty',
                                              style: TextStyle(
                                                  color: Colors.black87),
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () =>
                                                    Navigator.pop(context),
                                                child: const Text(
                                                  'OK',
                                                  style: TextStyle(
                                                      color: Colors.blue),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                        return;
                                      }
                                      Navigator.pop(context);
                                    },
                                    child: const Text("Save"),
                                  ),
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text("Cancel"),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        // Change Color Button
                        PopupMenuButton<Color>(
                          icon: const Icon(Icons.color_lens),
                          onSelected: (color) =>
                              global.updateColor(counter.id, color),
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
                        // Decrement Button
                        IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: () => global.decrement(counter.id),
                        ),
                        // Increment Button
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () => global.increment(counter.id),
                        ),
                        // Delete Button
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => global.removeCounter(counter.id),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),

          // Centered instruction when there are no counters
          if (global.counters.isEmpty)
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.add_circle_outline,
                      size: 80, color: Colors.grey[400]),
                  const SizedBox(height: 16),
                  const Text(
                    'Tap the + button to add a counter',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
        ],
      ),
      // Floating action button to add new counters
      floatingActionButton: FloatingActionButton(
        tooltip: 'Tap + to add a counter', // Optional: tooltip
        onPressed: () {
          global.addCounter(
            CounterModel(
              id: _uuid.v4(),
              label: "Counter ${global.counters.length + 1}",
              color: Colors.primaries[
                  global.counters.length % Colors.primaries.length],
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

