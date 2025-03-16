import 'dart:async';
import 'package:flutter/services.dart' show rootBundle;
import 'package:csv/csv.dart';

class FlightData {
  final double time;
  final double pressure;
  final double altitude;
  final double velocity;
  final double accX;
  final double accY;
  final double accZ;

  FlightData(this.time, this.pressure, this.altitude, this.velocity, this.accX, this.accY, this.accZ);

  @override
  String toString() {
    return 'Time: $time, Pressure: $pressure, Altitude: $altitude, Velocity: $velocity, AccX: $accX, AccY: $accY, AccZ: $accZ';
  }
}

class FlightDataLoader {
  static Future<List<FlightData>> loadCsvData() async {
    final rawData = await rootBundle.loadString('assets/flight_data.csv');
    List<List<dynamic>> listData = const CsvToListConverter().convert(rawData);

    return listData.skip(1).map((row) {
      return FlightData(
        row[0].toDouble(),  // time
        row[1].toDouble(),  // pressure
        row[2].toDouble(),  // altitude
        row[3].toDouble(),  // velocity
        row[4].toDouble(),  // acc_x
        row[5].toDouble(),  // acc_y
        row[6].toDouble(),  // acc_z
      );
    }).toList();
  }
}
