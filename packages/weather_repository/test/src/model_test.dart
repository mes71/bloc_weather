import 'package:test/test.dart';
import 'package:weather_repository/weather_repository.dart';

void main() {
  group('Weather', () {
    test('can be (de)serialized', () {
      final weather = Weather(
          location: 'Chicago',
          temperature: 10.2,
          condition: WeatherCondition.cloudy);
      
      expect(Weather.fromJson(weather.toJson()), weather);
    });
  });
}
