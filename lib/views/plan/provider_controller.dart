import 'package:flutter/material.dart';

class ProviderController with ChangeNotifier {
  bool objectCreated = false;

  buildCreate() {
    if (!objectCreated) {
      objectCreated = true;
      Future.delayed(const Duration(seconds: 3), () {
        notifyListeners();
      });
    }
  }

  destructedObject() {
    objectCreated = false;
    notifyListeners();
  }

  updateState() {
    Future.delayed(const Duration(seconds: 1), () {
      notifyListeners();
    });
  }

}
