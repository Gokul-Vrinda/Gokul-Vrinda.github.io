// lib/providers/guestbook_provider.dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gokul_weds_vrinda/model/wish_model.dart';

class GuestbookProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<WishModel> _wishes = [];
  bool _isLoading = false;

  List<WishModel> get wishes => _wishes;
  bool get isLoading => _isLoading;

  // Fetch wishes from Firestore in real-time
  void fetchWishes() {
    _firestore
        .collection('guestbook_wishes')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .listen((snapshot) {
      _wishes = snapshot.docs
          .map((doc) => WishModel.fromFirestore(doc))
          .toList();
      notifyListeners();
    });
  }

  // Add a new wish to Firestore
  Future<bool> addWish(String name, String message) async {
    try {
      _isLoading = true;
      notifyListeners();

      WishModel newWish = WishModel(
        id: '',
        name: name.trim(),
        message: message.trim(),
        timestamp: DateTime.now(),
      );

      await _firestore.collection('guestbook_wishes').add(newWish.toMap());

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      debugPrint("Error adding wish: $e");
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }
}