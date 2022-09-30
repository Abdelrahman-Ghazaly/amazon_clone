import 'package:flutter/material.dart';
import 'package:amazon_clone/constants/constants.dart';
import 'package:amazon_clone/services/services.dart';
import 'package:amazon_clone/ui/screens.dart';

class SearchAppBar extends StatelessWidget with PreferredSizeWidget {
  const SearchAppBar(
      {Key? key, required this.isReadOnly, this.hasBackButton = false})
      : preferredSize = const Size.fromHeight(kAppBarHeight),
        super(key: key);

  final bool isReadOnly;
  final bool hasBackButton;

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utilities().screenSize;

    OutlineInputBorder border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(7),
      borderSide: const BorderSide(color: Colors.grey),
    );

    return SafeArea(
      child: Container(
        height: kAppBarHeight,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: kBackgroundGradient,
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            !isReadOnly || hasBackButton
                ? IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back))
                : Container(),
            SizedBox(
              width: screenSize.width * 0.7,
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8,
                      spreadRadius: 1,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: TextField(
                  onSubmitted: (query) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return SafeArea(
                          child: ResultsSrceen(query: query),
                        );
                      }),
                    );
                  },
                  autofocus: !isReadOnly,
                  readOnly: isReadOnly,
                  onTap: () {
                    if (isReadOnly) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SearchScreen(),
                        ),
                      );
                    }
                  },
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    border: border,
                    focusedBorder: border,
                    hintText: 'Search',
                  ),
                ),
              ),
            ),
            IconButton(onPressed: () {}, icon: const Icon(Icons.mic_outlined))
          ],
        ),
      ),
    );
  }
}
