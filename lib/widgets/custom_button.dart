import 'package:flutter/material.dart';
import 'package:amazon_clone/services/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CustomButton extends StatelessWidget {
  final Widget child;
  final Color color;
  final bool isLoading;
  final VoidCallback onPressed;

  const CustomButton({
    Key? key,
    required this.color,
    required this.isLoading,
    required this.onPressed,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utilities().screenSize;
    const double buttonHeight = 40;
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        fixedSize: Size(screenSize.width * 0.55, buttonHeight),
      ),
      child: !isLoading
          ? child
          : const SpinKitThreeBounce(
              color: Colors.black,
              size: 20,
            ),
    );
  }
}
