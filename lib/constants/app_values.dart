import 'package:amazon_clone/model/model.dart';
import 'package:amazon_clone/ui/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'app_colors.dart';

const List<Widget> kScreens = [
  HomeScreen(),
  AccountScreen(),
  CartScreen(),
  MoreScreen(),
];

const double kAppBarHeight = 80;

const List<String> kCategoriesList = [
  "Prime",
  "Mobiles",
  "Fashion",
  "Electronics",
  "Home",
  "Fresh",
  "Appliances",
  "Books, Toys",
  "Essential"
];
const List<String> kAdItemNames = [
  "Amazon Pay",
  "Recharge",
  "Rewards",
  "Pay Bills"
];

const List<String> kRating = [
  'Very Bad',
  'Poor',
  'Average',
  'Good',
  'Excellent'
];

RatingBar kRatingBar({required Product product}) {
  return RatingBar(
    itemSize: 20,
    initialRating: product.rating,
    allowHalfRating: true,
    ratingWidget: kRatingWidget,
    onRatingUpdate: (_) {},
    ignoreGestures: true,
  );
}

RatingWidget kRatingWidget = RatingWidget(
  full: const Icon(
    Icons.star,
    color: kYellowColor,
  ),
  half: const Icon(
    Icons.star_half,
    color: kYellowColor,
  ),
  empty: const Icon(
    Icons.star_outline,
    color: Colors.grey,
  ),
);
