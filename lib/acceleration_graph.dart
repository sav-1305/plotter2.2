import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'data_loader.dart';
import 'data_index_provider.dart';

class AccelerationGraph extends StatefulWidget {
  const AccelerationGraph({super.key});

  @override
  _AccelerationGraphState createState() => _AccelerationGraphState();
}

class _AccelerationGraphState extends State<AccelerationGraph> {
  final List<FlightData> _displayData = [];

  @override
  Widget build(BuildContext context) {
    return Consumer<DataIndexProvider>(
      builder: (context, dataIndexProvider, _) {
        final flightData = dataIndexProvider.currentData;

        if (flightData == null) return const Center(child: CircularProgressIndicator());

        // Reset graph data when index loops back to 0
        if (dataIndexProvider.currentIndex == 0) {
          _displayData.clear();
        }

        _displayData.add(flightData);

        if (_displayData.length > 500) {
          _displayData.removeAt(0);
        }

        return SfCartesianChart(
          primaryXAxis: NumericAxis(title: AxisTitle(text: "Time (s)")),
          primaryYAxis: NumericAxis(title: AxisTitle(text: "Acceleration (m/s²)")),
          legend: Legend(isVisible: true),
          series: <ChartSeries>[
            LineSeries<FlightData, double>(
              name: "Acc X",
              dataSource: _displayData,
              xValueMapper: (FlightData data, _) => data.time,
              yValueMapper: (FlightData data, _) => data.accX,
              color: Colors.red,
            ),
            LineSeries<FlightData, double>(
              name: "Acc Y",
              dataSource: _displayData,
              xValueMapper: (FlightData data, _) => data.time,
              yValueMapper: (FlightData data, _) => data.accY,
              color: Colors.green,
            ),
            LineSeries<FlightData, double>(
              name: "Acc Z",
              dataSource: _displayData,
              xValueMapper: (FlightData data, _) => data.time,
              yValueMapper: (FlightData data, _) => data.accZ,
              color: Colors.blue,
            ),
          ],
        );
      },
    );
  }
}
