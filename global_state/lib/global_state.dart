import 'counter_model.dart';
import 'package:flutter/material.dart';

class GlobalState extends ChangeNotifier { 
  final List<CounterModel> _counters = [];

  List<CounterModel> get counters => List.unmodifiable(_counters);

  void addCounter(CounterModel counter) {
    _counters.add(counter);
    notifyListeners();
  }

  void removeCounter(String id) {
    _counters.removeWhere((c) => c.id == id);
    notifyListeners();
  }

  void increment(String id) {
    final c = _counters.firstWhere((c) => c.id == id);
    c.value++;
    notifyListeners();
  }

  void decrement(String id) {
    final c = _counters.firstWhere((c) => c.id == id);
    if (c.value > 0) c.value--;
    notifyListeners();
  }
}
