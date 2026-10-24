// lib/services/firebase_services.dart
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:gokul_weds_vrinda/firebase_options.dart';

class FirebaseServices {
  static Future<void> init() async {
    try {
      debugPrint('🔥 Initializing Flutter bindings...');
      WidgetsFlutterBinding.ensureInitialized();

      debugPrint('🔥 Starting Firebase initialization...');
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );

      debugPrint('✅ Firebase initialized successfully!');
    } catch (e, stackTrace) {
      debugPrint('❌ Error initializing Firebase: $e');
      debugPrint('StackTrace: $stackTrace');
      rethrow;
    }
  }
}
