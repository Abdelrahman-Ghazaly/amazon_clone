import 'dart:convert';

class User {
  const User({
    required this.name,
    required this.address,
    required this.email,
    required this.password,
  });

  final String name;
  final String address;
  final String email;
  final String password;

  Map<String, dynamic> get data => {
        'name': name,
        'address': address,
        'mail': email,
        'password': password,
      };

  User copyWith({
    String? name,
    String? address,
    String? email,
    String? password,
  }) {
    return User(
      name: name ?? this.name,
      address: address ?? this.address,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'address': address,
      'email': email,
      'password': password,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      name: map['name'] ?? '',
      address: map['address'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(name: $name, address: $address, email: $email, password: $password)';
  }
}
