import 'dart:ui';

import 'package:flutter/material.dart';

class CostWidget extends StatelessWidget {
  final double cost;
  final double fontSize;
  const CostWidget({
    Key? key,
    required this.cost,
    required this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double smallFontSize = fontSize / 1.5;
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '\$',
            style: TextStyle(
              fontSize: smallFontSize,
              fontFeatures: const [
                FontFeature.superscripts(),
              ],
            ),
          ),
          Text(
            cost.toInt().toString(),
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            ((cost - cost.toInt()) * 100).toInt().toString(),
            style: TextStyle(
              fontSize: smallFontSize,
              fontFeatures: const [
                FontFeature.superscripts(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
