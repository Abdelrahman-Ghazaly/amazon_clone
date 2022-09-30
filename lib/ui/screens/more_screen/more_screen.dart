import 'package:amazon_clone/constants/app_values.dart';
import 'package:amazon_clone/ui/screens/more_screen/widgets/category_grid.dart';
import 'package:amazon_clone/widgets/search_app_bar.dart';
import 'package:flutter/material.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SearchAppBar(isReadOnly: true),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 2.2 / 3.5,
            mainAxisSpacing: 15,
            crossAxisSpacing: 15,
          ),
          itemCount: kCategoriesList.length,
          itemBuilder: (context, index) => CategoryGrid(index: index),
        ),
      ),
    );
  }
}
