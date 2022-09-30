import 'package:amazon_clone/model/model.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'cloud_firestore.dart';

class Authentication {
  String outputString = 'Something went wrong';
  fb.FirebaseAuth firebaseAuth = fb.FirebaseAuth.instance;
  CloudFirestore cloudFirestore = CloudFirestore();

  static final Authentication _auth = Authentication._internal();

  factory Authentication() {
    return _auth;
  }

  Authentication._internal();

  Future<String> signUpUser(User user) async {
    user = trim(user);
    if (hasData(user)) {
      try {
        await firebaseAuth.createUserWithEmailAndPassword(
          email: user.email,
          password: user.password,
        );
        await cloudFirestore.uploadUserData(user: user);

        return 'Success';
      } on fb.FirebaseAuthException catch (e) {
        return e.message.toString();
      }
    } else {
      return 'Missing Fields';
    }
  }

  // Remove leading and/or trailing whitespaces
  User trim(User user) {
    return user.copyWith(
      name: user.name.trim(),
      address: user.address.trim(),
      email: user.email.trim(),
      password: user.password.trim(),
    );
  }

  // Check if the data has empty fields
  bool hasData(User user) {
    if (user.name != '' &&
        user.address != '' &&
        user.email != '' &&
        user.password != '') {
      return true;
    } else {
      return false;
    }
  }

  Future<String> signInUser({String? email, String? password}) async {
    email = email!.trim();
    password = password!.trim();
    if (email != '' && password != '') {
      try {
        await firebaseAuth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        return 'Success';
      } on fb.FirebaseAuthException catch (e) {
        return e.message.toString();
      }
    } else {
      return 'Missing Fields';
    }
  }
}
