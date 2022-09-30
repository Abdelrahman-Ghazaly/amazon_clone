import 'package:amazon_clone/constants/constants.dart';
import 'package:amazon_clone/model/model.dart';
import 'package:amazon_clone/provider/user_provider.dart';
import 'package:amazon_clone/services/services.dart';
import 'package:amazon_clone/widgets/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'widgets/cart_item.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SearchAppBar(isReadOnly: true),
      body: Center(
        child: Stack(
          children: [
            Column(
              children: [
                const SizedBox(height: kAppBarHeight / 2),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomButton(
                      color: kYellowColor,
                      onPressed: () {},
                      isLoading: false,
                      child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('user')
                            .doc(FirebaseAuth.instance.currentUser?.uid)
                            .collection('cart')
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                                snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CustomButton(
                                color: kYellowColor,
                                isLoading: true,
                                onPressed: () {},
                                child: const Text(
                                  'Loading',
                                  style: TextStyle(color: Colors.black),
                                ));
                          } else {
                            return CustomButton(
                              color: kYellowColor,
                              isLoading: false,
                              onPressed: () async {
                                await CloudFirestore().buyProducts(
                                  user: Provider.of<UserProvider>(context,
                                          listen: false)
                                      .currentUser,
                                );
                                Utilities().showSnackBar(
                                    context: context,
                                    message: 'Ordered Placed',
                                    color: Colors.green);
                              },
                              child: Text(
                                'Proceed to buy ${snapshot.data?.docs.length} items',
                                style: const TextStyle(color: Colors.black),
                              ),
                            );
                          }
                        },
                      )),
                ),
                Expanded(
                    child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('user')
                      .doc(FirebaseAuth.instance.currentUser?.uid)
                      .collection('cart')
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                          snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const LoadingWidget();
                    } else {
                      return ListView.builder(
                        itemCount: snapshot.data?.docs.length,
                        itemBuilder: (BuildContext context, int index) {
                          Product product = Product.fromMap(
                              snapshot.data!.docs[index].data());
                          return CartItem(product: product);
                        },
                      );
                    }
                  },
                )),
              ],
            ),
            const UserDetailBar(offset: 0),
          ],
        ),
      ),
    );
  }
}
