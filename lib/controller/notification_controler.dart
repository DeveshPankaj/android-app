import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/rendering.dart';
import 'package:local_market/controller/product_controller.dart';
import 'package:local_market/controller/user_controller.dart';
import 'package:local_market/utils/globals.dart' as globals;

import "package:uuid/uuid.dart";

class NotificationController {
  // final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseDatabase _database = FirebaseDatabase.instance;
  final Firestore _firestore = Firestore.instance;
  final UserController _userController = new UserController();
  final String ref = "notification";
  // final ProductController _productController = new ProductController();

  void add(String userId, String username, String phone, String orderId, var product, String dateTime, var count, var size) {

    String notificationId = Uuid().v1();

    // Map<String, String> dict;
  
    // dict['id'] = notificationId;
    // dict['orderId'] = orderId;

    
    _firestore.collection(ref).document(userId).collection(ref).document(notificationId).setData({
      "id" : notificationId,
      "orderId" : orderId,
      "username": username,
      "code": phone.substring(6),
      "productId": product['id'],
      "productName" : product['name'],
      "productImage" : product['image'],
      "quantity" : count,
      "prodPrice" : product['offerPrice'],
      "dateTime": dateTime,
      "size" : size
    });
  }


  Future<List<Map<String, String> > > getAll() async {
    List<Map<String, String> > results = new List<Map<String, String> >();
    // FirebaseUser _userId = await _userController.getCurrentUser();
    // print(globals.currentUser.data);
    QuerySnapshot notifications = await _firestore.collection(ref).document(globals.currentUser.data['uid']).collection(ref).orderBy('dateTime', descending: true).getDocuments();

    for(var i = 0; i < notifications.documents.length; i++){
      DocumentSnapshot notification = notifications.documents[i];
    
      results.add({
        "id" : notification.data['id'],
        "orderId" : notification.data['orderId'],
        "username" : notification.data['username'],
        "code" : notification.data['code'],
        "productId" : notification.data['productId'],
        "productName" : notification.data['productName'],
        "productImage" : notification.data['productImage'],
        "quantity" : notification.data['quantity'],
        "prodPrice" : notification.data['prodPrice'],
        "dateTime": notification.data['dateTime'],
        "size" : notification.data['size']
      });
    }
    return results;
  }

  Future<List<Map<String, String> > > getN(int n) async {
    List<Map<String, String> > results = new List<Map<String, String> >();
    // FirebaseUser _userId = await _userController.getCurrentUser();
    // print(globals.currentUser.data);
    QuerySnapshot notifications = await _firestore.collection(ref).document(globals.currentUser.data['uid']).collection(ref).orderBy('id').limit(n).getDocuments();

    for(var i = 0; i < notifications.documents.length; i++){
      DocumentSnapshot notification = notifications.documents[i];
    
      results.add({
        "id" : notification.data['id'],
        "orderId" : notification.data['orderId'],
        "username" : notification.data['username'],
        "code" : notification.data['code'],
        "productId" : notification.data['productId'],
        "productName" : notification.data['productName'],
        "productImage" : notification.data['productImage'],
        "quantity" : notification.data['quantity'],
        "prodPrice" : notification.data['prodPrice'],
        "dateTime": notification.data['dateTime'],
        "size" : notification.data['size']
      });
    }
    return results;
  }

  Future<List<Map<String, String> > > getNNext(int n, String lastNotificationId) async {
    List<Map<String, String> > results = new List<Map<String, String> >();
    // FirebaseUser _userId = await _userController.getCurrentUser();
    // print(globals.currentUser.data);
    QuerySnapshot notifications = await _firestore.collection(ref).document(globals.currentUser.data['uid']).collection(ref).orderBy('id').startAfter([lastNotificationId]).limit(n).getDocuments();

    for(var i = 0; i < notifications.documents.length; i++){
      DocumentSnapshot notification = notifications.documents[i];
    
      results.add({
        "id" : notification.data['id'],
        "orderId" : notification.data['orderId'],
        "username" : notification.data['username'],
        "code" : notification.data['code'],
        "productId" : notification.data['productId'],
        "productName" : notification.data['productName'],
        "productImage" : notification.data['productImage'],
        "quantity" : notification.data['quantity'],
        "prodPrice" : notification.data['prodPrice'],
        "dateTime": notification.data['dateTime'],
        "size" : notification.data['size']
      });
    }
    return results;
  }

  Future<void> remove(String notificationId) async {
    await _firestore.collection(ref).document(globals.currentUser.data['uid']).collection(ref).document(notificationId).delete().catchError((e){
      throw e;
    });
  }

}