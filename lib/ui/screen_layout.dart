import 'package:amazon_clone/constants/constants.dart';
import 'package:amazon_clone/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScreenLayout extends StatefulWidget {
  const ScreenLayout({Key? key}) : super(key: key);

  @override
  State<ScreenLayout> createState() => _ScreenLayoutState();
}

class _ScreenLayoutState extends State<ScreenLayout> {
  PageController pageController = PageController();
  int currentPage = 0;

  changePage(int page) {
    pageController.jumpToPage(page);
    setState(() {
      currentPage = page;
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<UserProvider>(context).getData();
    return DefaultTabController(
      length: 4,
      child: SafeArea(
        child: Scaffold(
          body: PageView(
            controller: pageController,
            children: kScreens,
            onPageChanged: (int page) {
              changePage(page);
            },
          ),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Colors.grey[400]!,
                  width: 1,
                ),
              ),
            ),
            child: TabBar(
              indicator: const BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: kActiveCyanColor,
                    width: 4,
                  ),
                ),
              ),
              indicatorSize: TabBarIndicatorSize.label,
              onTap: (int page) {
                changePage(page);
              },
              tabs: [
                Tab(
                  child: Icon(
                    Icons.home_outlined,
                    color: currentPage == 0 ? kActiveCyanColor : Colors.black,
                  ),
                ),
                Tab(
                  child: Icon(
                    Icons.account_circle_outlined,
                    color: currentPage == 1 ? kActiveCyanColor : Colors.black,
                  ),
                ),
                Tab(
                  child: Icon(
                    Icons.shopping_cart_outlined,
                    color: currentPage == 2 ? kActiveCyanColor : Colors.black,
                  ),
                ),
                Tab(
                  child: Icon(
                    Icons.menu,
                    color: currentPage == 3 ? kActiveCyanColor : Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
