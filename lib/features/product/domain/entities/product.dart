import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;
  final Rating rating;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
  });

  // Factory method to create a Product from JSON
  factory Product.fromJson(Map<dynamic, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      price: (json['price'] as num).toDouble(),
      description: json['description'],
      category: json['category'],
      image: json['image'],
      rating: Rating.fromJson(json['rating']),
    );
  }

  // Method to convert a Product to JSON
  Map<dynamic, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'description': description,
      'category': category,
      'image': image,
      'rating': rating.toJson(),
    };
  }

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class Rating extends Equatable {
  final double rate;
  final int count;

  Rating({
    required this.rate,
    required this.count,
  });

  // Factory method to create a Rating from JSON
  factory Rating.fromJson(Map<dynamic, dynamic> json) {
    return Rating(
      rate: (json['rate'] as num).toDouble(),
      count: json['count'],
    );
  }

  // Method to convert a Rating to JSON
  Map<String, dynamic> toJson() {
    return {
      'rate': rate,
      'count': count,
    };
  }

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
