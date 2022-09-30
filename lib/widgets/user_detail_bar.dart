import 'package:amazon_clone/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:amazon_clone/constants/constants.dart';
import 'package:amazon_clone/model/model.dart';
import 'package:amazon_clone/services/services.dart';
import 'package:provider/provider.dart';

class UserDetailBar extends StatelessWidget {
  final double offset;
  const UserDetailBar({
    Key? key,
    required this.offset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utilities().screenSize;
    User user = Provider.of<UserProvider>(context).currentUser;

    return Positioned(
      top: -offset / 3,
      child: Container(
        width: screenSize.width,
        height: kAppBarHeight / 2,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: kLightBackgroundGradient,
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 3,
          ),
          child: Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                color: Colors.grey[900]!,
              ),
              const SizedBox(width: 5),
              SizedBox(
                width: screenSize.width * 0.7,
                child: Text(
                  'Deliver to ${user.name} - ${user.address} ',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.grey[900]!,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
