import 'package:amazon_clone/constants/constants.dart';
import 'package:amazon_clone/services/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:amazon_clone/widgets/widgets.dart';
import 'widgets/ad_banner.dart';
import 'widgets/horizontal_list_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController scrollController = ScrollController();
  double offset = 0;
  List<Widget>? discount75;
  List<Widget>? discount50;
  List<Widget>? discount25;
  List<Widget>? discount0;
  bool hasData = false;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      setState(() {
        offset = scrollController.position.pixels;
      });
    });
    getData();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void getData() async {
    List<Widget> temp75 = await CloudFirestore().getProductByDiscount(0.75);
    List<Widget> temp50 = await CloudFirestore().getProductByDiscount(0.50);
    List<Widget> temp25 = await CloudFirestore().getProductByDiscount(0.25);
    List<Widget> temp0 = await CloudFirestore().getProductByDiscount(0);

    setState(() {
      discount75 = temp75;
      discount50 = temp50;
      discount25 = temp25;
      discount0 = temp0;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (discount0 != null &&
        discount25 != null &&
        discount50 != null &&
        discount75 != null) {
      hasData = true;
    }

    return Scaffold(
      appBar: const SearchAppBar(
        isReadOnly: true,
      ),
      body: hasData
          ? Stack(
              children: [
                SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    children: [
                      const SizedBox(height: kAppBarHeight / 2),
                      const HorizontalListView(),
                      const AdBanner(),
                      ProductListView(
                        title: 'Up to 75% OFF',
                        children: discount75!,
                      ),
                      ProductListView(
                        title: 'Up to 50% OFF',
                        children: discount50!,
                      ),
                      ProductListView(
                        title: 'Up to 25% OFF',
                        children: discount50!,
                      ),
                      ProductListView(
                        title: 'Explore',
                        children: discount0!,
                      ),
                    ],
                  ),
                ),
                UserDetailBar(offset: offset),
              ],
            )
          : const LoadingWidget(),
    );
  }
}
