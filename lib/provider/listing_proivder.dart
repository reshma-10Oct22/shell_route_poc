import 'package:flutter/material.dart';

class ListProvider extends ChangeNotifier {
  bool _isListloaded = false;
  bool get isListLoaded => _isListloaded;
  List<String> _generatedList = [];
  List<String> get generatedList => _generatedList;

  Future<void> updateList() async {
    var genList = List.generate(30, (index) => "Item: ${index + 1}");
    _generatedList.clear();
    _generatedList.addAll(genList);
    await Future.delayed(Duration.zero);
    _isListloaded = true;
    notifyListeners();
  }
}
