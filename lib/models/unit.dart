class Unit {
  final String name;
  final double Function(double) toBase; // Converte para unidade base
  final double Function(double) fromBase; // Converte da unidade base

  Unit({required this.name, required this.toBase, required this.fromBase});
}

class UnitCategory {
  final String name;
  final List<Unit> units;

  UnitCategory({required this.name, required this.units});
}