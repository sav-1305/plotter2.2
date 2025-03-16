import 'dart:async';
import 'package:flutter/foundation.dart';
import 'data_loader.dart';

class DataIndexProvider with ChangeNotifier {
  int _currentIndex = 0;
  List<FlightData> _flightData = [];
  late Timer _timer;

  int get currentIndex => _currentIndex;

  FlightData? get currentData =>
      (_flightData.isNotEmpty && _currentIndex < _flightData.length)
          ? _flightData[_currentIndex]
          : null;

  void setFlightData(List<FlightData> data) {
    _flightData = data;
    _currentIndex = 0; // Reset to the start of the data
    notifyListeners();
  }

  void startIteration() {
    _timer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      if (_flightData.isEmpty) return;

      _currentIndex++;
      if (_currentIndex >= _flightData.length) {
        _currentIndex = 0; // Reset on loopback
      }

      notifyListeners();
    });
  }

  void stopIteration() {
    _timer.cancel();
  }
}