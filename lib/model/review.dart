class Review {
  const Review({
    required this.reviewerName,
    required this.comment,
    required this.rating,
  });

  final String reviewerName;
  final String comment;
  final double rating;

  Map<String, dynamic> toMap() {
    return {
      'reviewerName': reviewerName,
      'description': comment,
      'rating': rating,
    };
  }

  factory Review.fromMap(Map<String, dynamic> map) {
    return Review(
      reviewerName: map['reviewerName'] ?? '',
      comment: map['description'] ?? '',
      rating: map['rating']?.toDouble() ?? 0.0,
    );
  }
}
