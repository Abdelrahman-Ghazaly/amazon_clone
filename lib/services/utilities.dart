import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Utilities {
  static final Utilities _utilities = Utilities._internal();

  factory Utilities() {
    return _utilities;
  }

  Utilities._internal();

  Size get screenSize =>
      MediaQueryData.fromWindow(WidgetsBinding.instance.window).size;

  showSnackBar(
      {required BuildContext context,
      required String message,
      required Color color}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
                child: Text(
              message,
              overflow: TextOverflow.visible,
            )),
          ],
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        backgroundColor: color,
      ),
    );
  }

  Future<Uint8List?> pickImage() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);
    return file?.readAsBytes();
  }
}
