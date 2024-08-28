import 'package:flutter/material.dart';
import 'sensor_data.dart';
import 'package:fl_chart/fl_chart.dart';

class SensorGraphPage extends StatelessWidget {
  final List<SensorData> sensorData;

  const SensorGraphPage({super.key, required this.sensorData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sensor Data Graph'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: LineChart(
          LineChartData(
            gridData: const FlGridData(show: true),
            titlesData: const FlTitlesData(show: true),
            borderData: FlBorderData(show: true),
            minX: 0,
            maxX: sensorData.length.toDouble(),
            minY: 0,
            maxY: 50, // Adjust based on your data range
            lineBarsData: [
              LineChartBarData(
                spots: List.generate(sensorData.length, (index) {
                  return FlSpot(index.toDouble(), double.parse(sensorData[index].temperature));
                }),
                isCurved: true,
                colors: [const Color.fromARGB(255, 219, 155, 182)], // Corrected here
                barWidth: 2,
                isStrokeCapRound: true,
                belowBarData: BarAreaData(show: true),
              ),
              LineChartBarData(
                spots: List.generate(sensorData.length, (index) {
                  return FlSpot(index.toDouble(), double.parse(sensorData[index].humidity));
                }),
                isCurved: true,
                colors: [const Color.fromARGB(255, 107, 206, 148)], // Corrected here
                barWidth: 2,
                isStrokeCapRound: true,
                belowBarData: BarAreaData(show: true),
              ),
            ]
          ),
        ),
      ),
    );
  }
}
