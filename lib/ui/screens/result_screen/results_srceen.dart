import 'package:amazon_clone/model/model.dart';
import 'package:amazon_clone/ui/screens/result_screen/widgets/results_grid.dart';
import 'package:amazon_clone/widgets/search_app_bar.dart';
import 'package:amazon_clone/widgets/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ResultsSrceen extends StatelessWidget {
  const ResultsSrceen({Key? key, required this.query}) : super(key: key);
  final String query;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SearchAppBar(isReadOnly: false),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                        text: 'Showing results for ',
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.black,
                        )),
                    TextSpan(
                      text: query,
                      style: const TextStyle(
                        fontSize: 17,
                        fontStyle: FontStyle.italic,
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection("products")
                  .where("productName", isEqualTo: query)
                  .get(),
              builder: (context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const LoadingWidget();
                } else {
                  return GridView.builder(
                      itemCount: snapshot.data!.docs.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3, childAspectRatio: 0.8),
                      itemBuilder: (context, index) {
                        Product product =
                            Product.fromMap(snapshot.data!.docs[index].data());
                        return ResultsGrid(
                          product: product,
                        );
                      });
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
