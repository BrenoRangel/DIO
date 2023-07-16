class Contact {
  String? objectId;
  String name, phone, email;

  Contact({
    this.objectId,
    required this.name,
    required this.phone,
    required this.email,
  });

  Map<String, dynamic> toJson() {
    return {
      'objectId': objectId,
      'name': name,
      'phone': phone,
      'email': email,
    };
  }

  static Contact fromJson(Map<String, dynamic> json) {
    return Contact(
      objectId: json['objectId'],
      name: json['name'],
      phone: json['phone'],
      email: json['email'],
    );
  }
}
