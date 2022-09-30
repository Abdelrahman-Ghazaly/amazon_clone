import 'package:amazon_clone/model/model.dart';
import 'package:amazon_clone/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:amazon_clone/constants/constants.dart';
import 'package:provider/provider.dart';

class UserIntroBar extends StatelessWidget {
  const UserIntroBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<UserProvider>(context).currentUser;

    return Container(
      height: kAppBarHeight / 2,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: kBackgroundGradient,
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Container(
        height: kAppBarHeight / 2,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white,
              Colors.white.withOpacity(0.00000000001),
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 17.0),
              child: RichText(
                text: TextSpan(children: [
                  TextSpan(
                    text: 'Hello, ',
                    style: TextStyle(
                      color: Colors.grey[800]!,
                      fontSize: 25,
                    ),
                  ),
                  TextSpan(
                    text: user.name,
                    style: TextStyle(
                      color: Colors.grey[800]!,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ]),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: CircleAvatar(
                backgroundImage: NetworkImage(kProfilePicUrl),
              ),
            )
          ],
        ),
      ),
    );
  }
}
