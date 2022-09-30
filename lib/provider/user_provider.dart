import 'package:amazon_clone/model/model.dart';
import 'package:amazon_clone/services/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  UserProvider()
      : currentUser =
            const User(name: '', address: '', email: '', password: ''),
        super();
  User currentUser;
  Future getData() async {
    currentUser = await CloudFirestore().getUserData();
    notifyListeners();
  }
}
