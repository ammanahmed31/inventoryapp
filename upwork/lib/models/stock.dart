class Stock {
  double cheese = 0;
  double chicken = 0;
  double pizzaBase = 0;
  double sauce = 0;

  Stock({this.cheese = 0, this.chicken = 0, this.pizzaBase = 0, this.sauce = 0});

  factory Stock.fromJson(Map<String, dynamic> map) {
    return Stock(
      cheese: map['cheese'] ?? 0,
      chicken: map['chicken'] ?? 0,
      pizzaBase: map['pizza_base'] ?? 0,
      sauce: map['sauce'] ?? 0,
    );
  }
}
