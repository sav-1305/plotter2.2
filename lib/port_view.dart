import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'data_index_provider.dart';

class PortViewScreen extends StatelessWidget {
  const PortViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Port View')),
      body: Consumer<DataIndexProvider>(
        builder: (context, dataIndexProvider, _) {
          final flightData = dataIndexProvider.currentData;

          if (flightData == null) {
            return const Center(child: CircularProgressIndicator());
          }

          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Time: ${flightData.time}s", style: const TextStyle(fontSize: 18)),
                Text("Altitude: ${flightData.altitude} m", style: const TextStyle(fontSize: 18)),
                Text("Velocity: ${flightData.velocity} m/s", style: const TextStyle(fontSize: 18)),
                Text("Pressure: ${flightData.pressure} Pa", style: const TextStyle(fontSize: 18)),
                Text("Acc X: ${flightData.accX} m/s²", style: const TextStyle(fontSize: 18)),
                Text("Acc Y: ${flightData.accY} m/s²", style: const TextStyle(fontSize: 18)),
                Text("Acc Z: ${flightData.accZ} m/s²", style: const TextStyle(fontSize: 18)),
              ],
            ),
          );
        },
      ),
    );
  }
}
