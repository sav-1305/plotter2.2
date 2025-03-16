import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'data_loader.dart';
import 'data_index_provider.dart';

class RealTimeGraph extends StatefulWidget {
  final String yAxisLabel;
  final Color lineColor;
  final String dataField;

  const RealTimeGraph({super.key, required this.yAxisLabel, required this.lineColor, required this.dataField});

  @override
  _RealTimeGraphState createState() => _RealTimeGraphState();
}

class _RealTimeGraphState extends State<RealTimeGraph> {
  final List<FlightData> _displayData = [];

  @override
  Widget build(BuildContext context) {
    return Consumer<DataIndexProvider>(
      builder: (context, dataIndexProvider, _) {
        final flightData = dataIndexProvider.currentData;

        if (flightData == null) return const Center(child: CircularProgressIndicator());

        // Reset data when index loops back to 0
        if (dataIndexProvider.currentIndex == 0) {
          _displayData.clear();
        }

        // Add current data point
        _displayData.add(flightData);

        if (_displayData.length > 500) {
          _displayData.removeAt(0);
        }

        return SfCartesianChart(
          primaryXAxis: NumericAxis(title: AxisTitle(text: "Time (s)")),
          primaryYAxis: NumericAxis(title: AxisTitle(text: widget.yAxisLabel)),
          series: <ChartSeries>[
            LineSeries<FlightData, double>(
              dataSource: _displayData,
              xValueMapper: (FlightData data, _) => data.time,
              yValueMapper: (FlightData data, _) {
                switch (widget.dataField) {
                  case 'altitude':
                    return data.altitude;
                  case 'velocity':
                    return data.velocity;
                  case 'pressure':
                    return data.pressure;
                  default:
                    return 0.0;
                }
              },
              color: widget.lineColor,
            ),
          ],
        );
      },
    );
  }
}
