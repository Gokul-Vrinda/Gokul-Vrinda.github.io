// lib/models/wish_model.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart'; // Added intl package for formatting

class WishModel {
  final String id;
  final String name;
  final String message;
  final DateTime timestamp;

  WishModel({
    required this.id,
    required this.name,
    required this.message,
    required this.timestamp,
  });

  // Getter to format DateTime into a readable string matching your design
  String get formattedDateTime {
    return DateFormat('M/d/yyyy, h:mm:ss a').format(timestamp);
  }

  // Convert Firestore Document to WishModel
  factory WishModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return WishModel(
      id: doc.id,
      name: data['name'] ?? '',
      message: data['message'] ?? '',
      timestamp: (data['timestamp'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  // Convert WishModel to Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'message': message,
      'timestamp': Timestamp.fromDate(timestamp),
    };
  }
}