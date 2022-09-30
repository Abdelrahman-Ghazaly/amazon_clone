import 'package:amazon_clone/model/model.dart';
import 'package:amazon_clone/provider/user_provider.dart';
import 'package:amazon_clone/services/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rating_dialog/rating_dialog.dart';

class ReviewDialog extends StatelessWidget {
  const ReviewDialog({Key? key, required this.product}) : super(key: key);
  final Product product;

  @override
  Widget build(BuildContext context) {
    return RatingDialog(
      title: Text(
        product.productName,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
      message: const Text(
        'Tap a star to set your rating for this product.',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 15),
      ),
      submitButtonText: 'Submit',
      onSubmitted: (response) async {
        Review review = Review(
          reviewerName: Provider.of<UserProvider>(context, listen: false)
              .currentUser
              .name,
          comment: response.comment,
          rating: response.rating,
        );
        CloudFirestore().uploadReview(review: review, productUid: product.uid);
      },
    );
  }
}
