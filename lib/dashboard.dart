import 'package:flutter/material.dart';
import 'graph_widget.dart';
import 'acceleration_graph.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flight Data Dashboard')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 1.2,
          children: [
            RealTimeGraph(yAxisLabel: "Altitude (m)", lineColor: Colors.blue, dataField: 'altitude'),
            RealTimeGraph(yAxisLabel: "Velocity (m/s)", lineColor: Colors.green, dataField: 'velocity'),
            RealTimeGraph(yAxisLabel: "Pressure (Pa)", lineColor: Colors.orange, dataField: 'pressure'),
            const AccelerationGraph(),
          ],
        ),
      ),
    );
  }
}
