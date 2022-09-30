import 'package:amazon_clone/constants/constants.dart';
import 'package:amazon_clone/model/model.dart';
import 'package:amazon_clone/services/services.dart';
import 'package:amazon_clone/ui/screens/product_screen/widgets/review_dialog.dart';
import 'package:amazon_clone/ui/screens/product_screen/widgets/review_widget.dart';
import 'package:amazon_clone/widgets/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key, required this.product}) : super(key: key);
  final Product product;

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = Utilities().screenSize;
    const SizedBox heightSpacer = SizedBox(height: 10);
    return SafeArea(
      child: Scaffold(
        appBar: const SearchAppBar(
          isReadOnly: true,
          hasBackButton: true,
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    SizedBox(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: kAppBarHeight / 2,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                widget.product.productName,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                ),
                              ),
                              kRatingBar(product: widget.product)
                            ],
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              widget.product.sellerName,
                              style: const TextStyle(
                                color: kActiveCyanColor,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: screenSize.height / 3,
                            width: screenSize.width,
                            child: FittedBox(
                              child: Image.network(
                                widget.product.imageUrl!,
                              ),
                            ),
                          ),
                          CostWidget(
                            cost: widget.product.cost,
                            fontSize: 25,
                          ),
                          heightSpacer,
                          CustomButton(
                            color: Colors.orange,
                            isLoading: false,
                            child: const Text('Buy Now'),
                            onPressed: () async {
                              CloudFirestore()
                                  .adddProductToCart(product: widget.product);
                              Utilities().showSnackBar(
                                context: context,
                                message: 'Added to Cart',
                                color: Colors.green,
                              );
                            },
                          ),
                          heightSpacer,
                          CustomButton(
                            color: kYellowColor,
                            isLoading: false,
                            onPressed: () {},
                            child: const Text('Add to Wishlist'),
                          ),
                          heightSpacer,
                          CustomSmallButton(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) =>
                                    ReviewDialog(product: widget.product),
                              );
                            },
                            text: 'Add a review for this Product',
                          ),
                        ],
                      ),
                    ),
                    Column(children: [
                      StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('products')
                            .doc(widget.product.uid)
                            .collection('reviews')
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                                snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const LoadingWidget();
                          } else {
                            return SizedBox(
                              height: screenSize.height * 0.25,
                              child: ListView.builder(
                                itemCount: snapshot.data?.docs.length,
                                itemBuilder: (BuildContext context, int index) {
                                  Review review = Review.fromMap(
                                      snapshot.data!.docs[index].data());
                                  return ReviewWidget(review: review);
                                },
                              ),
                            );
                          }
                        },
                      )
                    ]),
                  ],
                ),
              ),
            ),
            const UserDetailBar(offset: 0),
          ],
        ),
      ),
    );
  }
}
