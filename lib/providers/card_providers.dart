import 'package:flutter/material.dart';

class CardProvider extends ChangeNotifier {
  bool _isOpened = false;

  bool get isOpened => _isOpened;

  void openCard() {
    _isOpened = true;
    notifyListeners(); // UI-kku update cheyyan signal kodukkunnu
  }
}