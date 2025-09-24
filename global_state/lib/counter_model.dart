class CounterModel {
  final String id;
  String label;
  int value;

  CounterModel({
    required this.id,
    required this.label,
    this.value = 0,
  });
}
