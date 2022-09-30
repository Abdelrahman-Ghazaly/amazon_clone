import 'package:amazon_clone/constants/constants.dart';
import 'package:amazon_clone/model/model.dart';
import 'package:amazon_clone/services/services.dart';
import 'package:amazon_clone/ui/screens.dart';
import 'package:amazon_clone/widgets/widgets.dart';
import 'package:flutter/material.dart';

class ResultsGrid extends StatelessWidget {
  const ResultsGrid({
    Key? key,
    required this.product,
  }) : super(key: key);
  final Product product;

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utilities().screenSize;
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductScreen(product: product)));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              width: screenSize.width / 3,
              child: Image.network(product.imageUrl!),
            ),
            Text(
              product.productName,
            ),
            CostWidget(
              cost: product.cost,
              fontSize: 12,
            ),
            kRatingBar(product: product),
          ],
        ),
      ),
    );
  }
}
