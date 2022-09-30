import 'package:amazon_clone/constants/app_values.dart';
import 'package:amazon_clone/model/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ReviewWidget extends StatelessWidget {
  const ReviewWidget({Key? key, required this.review}) : super(key: key);
  final Review review;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            review.reviewerName,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: [
              RatingBar(
                ratingWidget: kRatingWidget,
                onRatingUpdate: (_) {},
                initialRating: review.rating,
                itemSize: 20,
                allowHalfRating: true,
              ),
              const SizedBox(width: 10),
              Text(
                kRating[(review.rating.toInt() - 1)],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            review.comment,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
