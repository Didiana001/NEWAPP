import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'sensor_data.dart';
import 'sensor_graph_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sensor Data App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 235, 191, 222)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Sensor Data'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<SensorData> _sensorData = [];

  Future<void> fetchSensorData() async {
    final response = await http.get(Uri.parse('http://172.16.60.171:8004/sense-data/'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      setState(() {
        _sensorData = data.map((item) => SensorData.fromJson(item)).toList();
      });
    } else {
      throw Exception('Failed to load sensor data');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchSensorData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: _sensorData.isEmpty
            ? const CircularProgressIndicator()
            : DataTable(
                columns: const [
                  DataColumn(label: Text('Temperature (°C)')),
                  DataColumn(label: Text('Humidity (%)')),
                  DataColumn(label: Text('Time')),
                ],
                rows: _sensorData
                    .map(
                      (data) => DataRow(cells: [
                        DataCell(Text('${data.temperature} °C')),
                        DataCell(Text('${data.humidity} %')),
                        DataCell(Text(data.time)),
                      ]),
                    )
                    .toList(),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SensorGraphPage(sensorData: _sensorData)),
          );
        },
        tooltip: 'Show Graph',
        child: const Icon(Icons.show_chart),
      ),
    );
  }
}
