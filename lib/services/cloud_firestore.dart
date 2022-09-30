import 'dart:math';

import 'package:amazon_clone/model/model.dart';
import 'package:amazon_clone/widgets/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CloudFirestore {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  fb.FirebaseAuth firebaseAuth = fb.FirebaseAuth.instance;

  static final CloudFirestore _cloudFirestore = CloudFirestore._internal();

  factory CloudFirestore() {
    return _cloudFirestore;
  }

  CloudFirestore._internal();

  Future uploadUserData({required User user}) async {
    await firebaseFirestore
        .collection("user")
        .doc(firebaseAuth.currentUser!.uid)
        .set(user.data);
  }

  Future<User> getUserData() async {
    DocumentSnapshot snapshot = await firebaseFirestore
        .collection("user")
        .doc(firebaseAuth.currentUser!.uid)
        .get();
    User user = User.fromMap(snapshot.data() as dynamic);
    return user;
  }

  Future<String> uploadProdcutToDatabase(Product product) async {
    product.productName.trim();
    String output = 'Somthing went wrong';
    String uid = getRandomString(10);
    String url;
    Product productfinal;

    if (hasData(product)) {
      try {
        url =
            await uploadImageToDatabase(rawImage: product.rawImage!, uid: uid);
        productfinal = creatModel(product, url, uid);

        await firebaseFirestore
            .collection('products')
            .doc(uid)
            .set(productfinal.toMap());
        output = 'Success';
      } catch (e) {
        output = e.toString();
      }
    } else {
      output = 'Fill all the fields';
    }
    return output;
  }

  Product creatModel(Product product, String url, String uid) => Product(
        imageUrl: url,
        productName: product.productName,
        cost: product.cost,
        discount: product.discount,
        uid: uid,
        sellerName: product.sellerName,
        sellerUid: product.sellerUid,
        rating: product.rating,
        numberOfRatings: product.numberOfRatings,
      );

  bool hasData(Product product) {
    if (product.rawImage != null && product.productName != '') {
      return true;
    }
    return false;
  }

  Future<String> uploadImageToDatabase(
      {required Uint8List rawImage, required String uid}) async {
    Reference reference =
        FirebaseStorage.instance.ref().child('products').child(uid);

    UploadTask uploadTask = reference.putData(rawImage);
    TaskSnapshot taskSnapshot = await uploadTask;
    return taskSnapshot.ref.getDownloadURL();
  }

  final String _chars =
      r'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890~!@#$%^&*())_+<>?:{}|\,./[]';
  final Random _rnd = Random();
  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  Future<List<Widget>> getProductByDiscount(double discount) async {
    List<Widget> items = [];

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('products')
        .where('discount', isEqualTo: discount)
        .get();
    for (int i = 0; i < querySnapshot.docs.length; i++) {
      DocumentSnapshot documentSnapshot = querySnapshot.docs[i];
      Product product = Product.fromMap(documentSnapshot.data() as dynamic);
      items.add(ProductWidget(product: product));
    }
    return items;
  }

  Future uploadReview({
    required Review review,
    required String productUid,
  }) async {
    await firebaseFirestore
        .collection('products')
        .doc(productUid)
        .collection('reviews')
        .add(review.toMap());
    await changeAverageRating(productUid: productUid, review: review);
  }

  Future adddProductToCart({required Product product}) async {
    await firebaseFirestore
        .collection('user')
        .doc(firebaseAuth.currentUser!.uid)
        .collection('cart')
        .doc(product.uid)
        .set(product.toMap());
  }

  Future deleteProductFromCart({required String productUid}) async {
    await firebaseFirestore
        .collection('user')
        .doc(firebaseAuth.currentUser?.uid)
        .collection('cart')
        .doc(productUid)
        .delete();
  }

  Future buyProducts({required User user}) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await firebaseFirestore
        .collection('user')
        .doc(firebaseAuth.currentUser?.uid)
        .collection('cart')
        .get();

    for (int i = 0; i < querySnapshot.docs.length; i++) {
      Product product = Product.fromMap(querySnapshot.docs[i].data());
      addProductToOrder(product: product, user: user);
    }
  }

  Future addProductToOrder(
      {required Product product, required User user}) async {
    await firebaseFirestore
        .collection('user')
        .doc(firebaseAuth.currentUser?.uid)
        .collection('orders')
        .add(product.toMap());

    await deleteProductFromCart(productUid: product.uid);
    await sendOrderRequest(product: product, user: user);
  }

  Future sendOrderRequest(
      {required Product product, required User user}) async {
    OrderRequest orderRequest = OrderRequest(
      productName: product.sellerName,
      buyerAddress: user.address,
    );
    await firebaseFirestore
        .collection('user')
        .doc(product.sellerUid)
        .collection('order requests')
        .add(orderRequest.toMap());
  }

  Future changeAverageRating(
      {required String productUid, required Review review}) async {
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await firebaseFirestore.collection('products').doc(productUid).get();
    Product product = Product.fromMap(documentSnapshot.data()!);
    double currentRating = product.rating;
    double newRating = (currentRating + review.rating) / 2;
    firebaseFirestore
        .collection('products')
        .doc(productUid)
        .update({'rating': newRating});
  }
}
