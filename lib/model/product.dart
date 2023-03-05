import 'package:flutter/foundation.dart';

class Product {
  const Product({
    required this.imageUrl,
    required this.productName,
    required this.cost,
    required this.discount,
    required this.uid,
    required this.sellerName,
    required this.sellerUid,
    required this.rating,
    required this.numberOfRatings,
    this.rawImage,
  });

  final String? imageUrl;
  final String productName;
  final double cost;
  final double discount;
  final String uid;
  final String sellerName;
  final String sellerUid;
  final double rating;
  final int numberOfRatings;
  final Uint8List? rawImage;

  Map<String, dynamic> toMap() {
    return {
      'imageUrl': imageUrl,
      'productName': productName,
      'cost': cost,
      'discount': discount,
      'uid': uid,
      'sellerName': sellerName,
      'sellerUid': sellerUid,
      'rating': rating,
      'numberOfRatings': numberOfRatings,
      'rawImage': rawImage,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      imageUrl: map['imageUrl'],
      productName: map['productName'] ?? '',
      cost: map['cost']?.toDouble() ?? 0.0,
      discount: map['discount']?.toDouble() ?? 0.0,
      uid: map['uid'],
      sellerName: map['sellerName'] ?? '',
      sellerUid: map['sellerUid'] ?? '',
      rating: map['rating'] ?? 0,
      numberOfRatings: map['numberOfRatings']?.toInt() ?? 0,
    );
  }

  Product trim() {
    return Product(
      imageUrl: imageUrl?.trim(),
      productName: productName.trim(),
      cost: cost,
      discount: discount,
      uid: uid.trim(),
      sellerName: sellerName.trim(),
      sellerUid: sellerUid.trim(),
      rating: rating,
      numberOfRatings: numberOfRatings,
    );
  }

  @override
  String toString() {
    return 'Product(imageUrl: $imageUrl, productName: $productName, cost: $cost, discount: $discount, uid: $uid, sellerName: $sellerName, sellerUid: $sellerUid, rating: $rating, numberOfRatings: $numberOfRatings, rawImage: $rawImage)';
  }
}
