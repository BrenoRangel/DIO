class Person {
  int? id;
  String name;
  double weight, height;

  Person({
    this.id,
    required this.name,
    required this.weight,
    required this.height,
  });

  static Person fromJson(Map<String, Object?> map) {
    return Person(
      id: map["id"] == null ? null : map["id"] as int,
      name: map["name"] as String,
      weight: map["weight"] as double,
      height: map["height"] as double,
    );
  }

  Map<String, Object?> toJson() {
    return {
      if (id != null) "id": id,
      "name": name,
      "weight": weight,
      "height": height
    };
  }
}
