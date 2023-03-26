class Cart {
  int id;
  String product_name;
  int product_quentity;
  double total_price;
  double per_unit_price;

  Cart(
      {required this.id,
      required this.product_name,
      required this.product_quentity,
      required this.total_price,
      required this.per_unit_price});

  Cart.withId(
      {required this.id,
      required this.product_name,
      required this.product_quentity,
      required this.total_price,
      required this.per_unit_price});

  Map<String, dynamic> toMap() {
    final map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = id;
    }
    map['product_name'] = product_name;
    map['product_quantity'] = product_quentity;
    map['total_price'] = total_price;
    map['per_unit_price'] = per_unit_price;

    return map;
  }

  factory Cart.formMap(Map<String, dynamic> map) {
    return Cart.withId(
        id: map['id'],
        product_name: map['product_name'],
        product_quentity: map['product_quentity'],
        total_price: map['total_price'],
        per_unit_price: map['per_unit_price']);
  }
}
