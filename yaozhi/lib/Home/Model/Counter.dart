import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Counter extends ChangeNotifier {

  int _count;

  add() {
    _count ++;
    notifyListeners();
  }

  get count => _count;
}