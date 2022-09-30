import 'package:amazon_clone/model/model.dart';
import 'package:amazon_clone/services/services.dart';
import 'package:amazon_clone/ui/screens.dart';
import 'package:amazon_clone/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:amazon_clone/constants/constants.dart';
import 'product_info.dart';

class CartItem extends StatelessWidget {
  const CartItem({Key? key, required this.product}) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utilities().screenSize;
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: screenSize.height / 3.5,
        width: screenSize.width,
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              color: Colors.grey,
              width: 1,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                flex: 4,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductScreen(
                          product: product,
                        ),
                      ),
                    );
                  },
                  child: Row(
                    children: [
                      SizedBox(
                        width: screenSize.width / 3,
                        child: Align(
                            alignment: Alignment.topCenter,
                            child: Image.network(product.imageUrl!)),
                      ),
                      ProductInfo(
                        productName: product.productName,
                        cost: product.cost,
                        sellerName: product.sellerName,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Row(
                  children: [
                    CustomSquareButton(
                      onTap: () {},
                      color: kBackgroundColor,
                      child: const Icon(Icons.remove),
                    ),
                    CustomSquareButton(
                      onTap: () {},
                      color: Colors.white,
                      child: const Center(
                          child: Text(
                        '1',
                        style: TextStyle(color: kActiveCyanColor),
                      )),
                    ),
                    CustomSquareButton(
                      onTap: () {},
                      color: kBackgroundColor,
                      child: const Icon(Icons.add),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 5),
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CustomSmallButton(
                          onTap: () async {
                            await CloudFirestore()
                                .deleteProductFromCart(productUid: product.uid);
                          },
                          text: 'Delete',
                        ),
                        const SizedBox(width: 10),
                        CustomSmallButton(
                          onTap: () {},
                          text: 'Save for Later',
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'See more',
                        style: TextStyle(
                          color: kActiveCyanColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomSquareButton extends StatelessWidget {
  const CustomSquareButton({
    Key? key,
    required this.child,
    required this.onTap,
    required this.color,
  }) : super(key: key);

  final Widget child;
  final VoidCallback onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        width: 50,
        decoration: ShapeDecoration(
          color: color,
          shape: RoundedRectangleBorder(
            side: const BorderSide(
              color: Colors.grey,
            ),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        child: child,
      ),
    );
  }
}
