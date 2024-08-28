// sensor_data.dart

class SensorData {
  final String temperature;
  final String humidity;
  final String time;

  SensorData({
    required this.temperature,
    required this.humidity,
    required this.time,
  });

  // Factory method to create a SensorData object from a JSON map
  factory SensorData.fromJson(Map<String, dynamic> json) {
    return SensorData(
      temperature: json['temperature'],
      humidity: json['humidity'],
      time: json['time'],
    );
  }

  // Method to convert a SensorData object into a JSON map
  Map<String, dynamic> toJson() {
    return {
      'temperature': temperature,
      'humidity': humidity,
      'time': time,
    };
  }
}
