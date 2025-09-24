import 'package:flutter/material.dart';

class CounterModel {
  final String id;     
  String label;       
  int value;           
  Color color;         

  CounterModel({
    required this.id,
    required this.label,
    this.value = 0,
    this.color = Colors.blue, 
  });
}
