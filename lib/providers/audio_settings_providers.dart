import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class SettingsProvider with ChangeNotifier {
  bool _enableAudio = true;

  bool get enableAudio => _enableAudio;

  set enableAudio(bool value) {
    _enableAudio = value;
    notifyListeners();
  }
}
