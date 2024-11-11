class UpdateUser {
  final String email;
  final String username;
  final Name name;
  final Address address;
  final String phone;

  UpdateUser({
    required this.email,
    required this.username,
    required this.name,
    required this.address,
    required this.phone,
  });

  // Convert to JSON for API request
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'username': username,
      'name': name.toJson(),
      'address': address.toJson(),
      'phone': phone,
      'id': 7
    }; // Remove null fields
  }
}

class Name {
  final String? firstname;
  final String? lastname;

  Name({
    this.firstname,
    this.lastname,
  });

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'firstname': firstname,
      'lastname': lastname,
    }..removeWhere((key, value) => value == null); // Remove null fields
  }

  // Factory method to create a Name from JSON
  factory Name.fromJson(Map<String, dynamic> json) {
    return Name(
      firstname: json['firstname'],
      lastname: json['lastname'],
    );
  }
}

class Address {
  final String? city;
  final String? street;
  final int? number;
  final String? zipcode;
  final Geolocation? geolocation;

  Address({
    this.city,
    this.street,
    this.number,
    this.zipcode,
    this.geolocation,
  });

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'city': city,
      'street': street,
      'number': number,
      'zipcode': zipcode,
      'geolocation': geolocation?.toJson(),
    }..removeWhere((key, value) => value == null); // Remove null fields
  }

  // Factory method to create an Address from JSON
  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      city: json['city'],
      street: json['street'],
      number: json['number'],
      zipcode: json['zipcode'],
      geolocation: json['geolocation'] != null
          ? Geolocation.fromJson(json['geolocation'])
          : null,
    );
  }
}

class Geolocation {
  final String? lat;
  final String? long;

  Geolocation({
    this.lat,
    this.long,
  });

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'lat': lat,
      'long': long,
    }..removeWhere((key, value) => value == null); // Remove null fields
  }

  // Factory method to create a Geolocation from JSON
  factory Geolocation.fromJson(Map<String, dynamic> json) {
    return Geolocation(
      lat: json['lat'],
      long: json['long'],
    );
  }
}
