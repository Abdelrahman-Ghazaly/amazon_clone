import 'package:amazon_clone/constants/constants.dart';
import 'package:amazon_clone/model/model.dart';
import 'package:amazon_clone/services/utilities.dart';
import 'package:amazon_clone/ui/screens.dart';
import 'package:amazon_clone/widgets/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'widgets/account_app_bar.dart';
import 'widgets/user_intro_bar.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = Utilities().screenSize;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AccountAppBar(),
      body: SingleChildScrollView(
        child: SizedBox(
          height: screenSize.height,
          width: screenSize.width,
          child: Column(
            children: [
              const UserIntroBar(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomButton(
                  color: Colors.orange,
                  isLoading: false,
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                  },
                  child: const Text(
                    'Sign Out',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomButton(
                  color: kYellowColor,
                  isLoading: false,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SellScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    'Sell',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection('user')
                    .doc(FirebaseAuth.instance.currentUser?.uid)
                    .collection('orders')
                    .get(),
                builder: (context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const LoadingWidget();
                  } else {
                    List<Widget> orders = [];

                    for (var i = 0; i < snapshot.data!.docs.length; i++) {
                      Product product =
                          Product.fromMap(snapshot.data!.docs[i].data());
                      orders.add(ProductWidget(product: product));
                    }

                    return ProductListView(
                      title: 'Your Order',
                      children: orders,
                    );
                  }
                },
              ),
              const Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Order Requests',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('user')
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .collection('order requests')
                      .snapshots(),
                  builder: (context,
                      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                          snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const LoadingWidget();
                    } else {
                      return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          OrderRequest orderRequest = OrderRequest.fromMap(
                            snapshot.data!.docs[index].data(),
                          );
                          return ListTile(
                            title: Text(
                              orderRequest.productName,
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            subtitle: Text(orderRequest.buyerAddress),
                            trailing: IconButton(
                              icon: const Icon(Icons.check),
                              onPressed: () async {
                                await FirebaseFirestore.instance
                                    .collection('user')
                                    .doc(FirebaseAuth.instance.currentUser?.uid)
                                    .collection('order requests')
                                    .doc(snapshot.data!.docs[index].id)
                                    .delete();
                              },
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
