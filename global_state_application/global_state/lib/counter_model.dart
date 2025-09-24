import 'package:flutter/material.dart';

class CounterModel {
  final String id;
  String label;
  int value;
  Color color;

  CounterModel({
    required this.id,
    this.label = "Counter",
    this.value = 0,
    required this.color,
  });
}
