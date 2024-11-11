import 'package:tezda/features/authentication/domain/entities/address.dart';
import 'package:tezda/features/authentication/domain/entities/name.dart';

class User {
  final int id;
  final String email;
  final String username;

  final Name name;
  final Address address;
  final String phone;

  User({
    required this.id,
    required this.email,
    required this.username,
    required this.name,
    required this.address,
    required this.phone,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 7,
      email: json['email'],
      username: json['username'],
      name: Name.fromJson(json['name']),
      address: Address.fromJson(json['address']),
      phone: json['phone'],
    );
  }

  // Method to convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'username': username,
      'name': name.toJson(),
      'address': address.toJson(),
      'phone': phone,
    };
  }
}
