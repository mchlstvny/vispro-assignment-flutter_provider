import 'package:flutter_test/flutter_test.dart';
import 'package:global_state/global_state.dart';
import 'package:global_state/counter_model.dart';

void main() {
  late GlobalState global;

  setUp(() {
    global = GlobalState();
  });

  test('addCounter adds a new counter', () {
    final counter = CounterModel(id: '1', label: 'Test');
    global.addCounter(counter);

    expect(global.counters.length, 1);
    expect(global.counters.first.label, 'Test');
  });

  test('increment increases counter value', () {
    final counter = CounterModel(id: '1', label: 'Test');
    global.addCounter(counter);

    global.increment('1');

    expect(global.counters.first.value, 1);
  });

  test('decrement decreases counter value but not below 0', () {
    final counter = CounterModel(id: '1', label: 'Test');
    global.addCounter(counter);

    global.increment('1'); // value = 1
    global.decrement('1'); // value = 0
    global.decrement('1'); // still 0

    expect(global.counters.first.value, 0);
  });

  test('removeCounter removes the counter', () {
    final counter = CounterModel(id: '1', label: 'Test');
    global.addCounter(counter);

    global.removeCounter('1');

    expect(global.counters.isEmpty, true);
  });
}
