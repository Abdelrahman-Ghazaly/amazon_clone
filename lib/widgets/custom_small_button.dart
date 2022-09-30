import 'package:flutter/material.dart';

class CustomSmallButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;

  const CustomSmallButton({
    Key? key,
    required this.onTap,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.grey),
        ),
        child: Text(
          text,
        ),
      ),
    );
  }
}
