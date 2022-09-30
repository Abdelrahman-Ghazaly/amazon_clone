import 'package:amazon_clone/constants/constants.dart';
import 'package:amazon_clone/services/services.dart';
import 'package:amazon_clone/widgets/widgets.dart';
import 'package:flutter/material.dart';

class ProductInfo extends StatelessWidget {
  final String productName;
  final double cost;
  final String sellerName;
  const ProductInfo({
    Key? key,
    required this.productName,
    required this.cost,
    required this.sellerName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utilities().screenSize;
    return SizedBox(
      width: screenSize.width / 2,
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(
                productName,
                maxLines: 2,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
          CostWidget(
            cost: cost,
            fontSize: 13,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: RichText(
                  text: TextSpan(children: [
                TextSpan(
                    text: 'Sold by ',
                    style: TextStyle(
                      color: Colors.grey[700]!,
                      fontSize: 10,
                    )),
                TextSpan(
                    text: sellerName,
                    style: const TextStyle(
                      color: kActiveCyanColor,
                      fontSize: 10,
                    )),
              ])),
            ),
          ),
        ],
      ),
    );
  }
}
