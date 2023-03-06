import 'package:bloc_test/bloc_test.dart';
import 'package:bloc_weather/theme/cubit/theme_cubit.dart';
import 'package:bloc_weather/weather/weather.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helper/hydrated_bloc.dart';

class MockWeather extends Mock implements Weather {
  final WeatherCondition _condition;

  MockWeather(this._condition);

  @override
  WeatherCondition get condition => _condition;
}

void main() {
  initHydrationStorage();

  group('ThemeCubit', () {
    test('initial state is Correct', () {
      expect(ThemeCubit().state, ThemeCubit.defaultColor);
    });

    group('fromJson/toJson', () {
      test('work properly', () {
        final themeCubit = ThemeCubit();
        expect(themeCubit.fromJson(themeCubit.toJson(themeCubit.state)),
            themeCubit.state);
      });

      group('updateTheme', () {
        final clearWeather = MockWeather(WeatherCondition.clear);
        final snowyWeather = MockWeather(WeatherCondition.snowy);
        final rainyWeather = MockWeather(WeatherCondition.rainy);
        final cloudyWeather = MockWeather(WeatherCondition.cloudy);
        final unknowWeather = MockWeather(WeatherCondition.unknown);

        blocTest<ThemeCubit, Color>(
          'emits correct color for WeatherCondition.clear',
          build: ThemeCubit.new,
          act: (cubit) => cubit.updateTheme(clearWeather),
          expect: () => <Color>[Colors.orangeAccent],
        );

        blocTest<ThemeCubit, Color>(
          'emits correct color for WeatherCondition.snowy',
          build: ThemeCubit.new,
          act: (cubit) => cubit.updateTheme(snowyWeather),
          expect: () => <Color>[Colors.lightBlueAccent],
        );

        blocTest<ThemeCubit, Color>(
          'emits correct color for WeatherCondition.cloudy',
          build: ThemeCubit.new,
          act: (cubit) => cubit.updateTheme(cloudyWeather),
          expect: () => <Color>[Colors.blueGrey],
        );

        blocTest<ThemeCubit, Color>(
          'emits correct color for WeatherCondition.rainy',
          build: ThemeCubit.new,
          act: (cubit) => cubit.updateTheme(rainyWeather),
          expect: () => <Color>[Colors.indigoAccent],
        );

        blocTest<ThemeCubit, Color>(
          'emits correct color for WeatherCondition.clear',
          build: ThemeCubit.new,
          act: (cubit) => cubit.updateTheme(unknowWeather),
          expect: () => <Color>[ThemeCubit.defaultColor],
        );
      });
    });
  });
}
