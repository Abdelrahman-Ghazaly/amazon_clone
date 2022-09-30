import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String title;
  final bool isPassword;
  final TextEditingController controller;
  final String hintText;
  const CustomTextField({
    Key? key,
    required this.title,
    required this.controller,
    this.isPassword = false,
    required this.hintText,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Text(
            widget.title,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          child: TextField(
            obscureText: widget.isPassword,
            controller: widget.controller,
            decoration: InputDecoration(
              hintText: widget.hintText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(color: Colors.grey, width: 2),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  width: 2.5,
                  color: Colors.orange,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
