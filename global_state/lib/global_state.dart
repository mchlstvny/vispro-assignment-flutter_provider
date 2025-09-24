import 'package:flutter/material.dart';
import 'counter_model.dart';

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

  void updateLabel(String id, String newLabel) {
    final c = _counters.firstWhere((c) => c.id == id);
    c.label = newLabel;
    notifyListeners();
  }

  void updateColor(String id, Color newColor) {
    final c = _counters.firstWhere((c) => c.id == id);
    c.color = newColor;
    notifyListeners();
  }

  void reorder(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) newIndex -= 1;
    final item = _counters.removeAt(oldIndex);
    _counters.insert(newIndex, item);
    notifyListeners();
  }
}
