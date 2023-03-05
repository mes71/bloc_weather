import 'package:open_meteo_api/open_meteo_api.dart';
import 'package:test/test.dart';

void main() {
  group('Location from Json ', () {
    test('returns correct Weather  object', () {
      expect(
          Weather.fromJson({'temperature': 15.3, 'weathercode': 63}),
          isA<Weather>()
              .having((p0) => p0.temperature, 'temperature', 15.3)
              .having((p0) => p0.weatherCode, 'weatherCode', 63));
    });
  });
}
