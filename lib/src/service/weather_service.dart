import 'package:flutter/foundation.dart';
import 'package:projets_flutter/src/api/api_repository.dart';
import 'package:projets_flutter/src/model/current_weather_data.dart';
import 'package:projets_flutter/src/model/five_days_data.dart';

class WeatherService {
  final String city;

  String baseUrl = 'https://api.openweathermap.org/data/2.5';
  String apiKey = 'appid=cebeed66c3b7770e663c8817b26b26f3';

  WeatherService({@required this.city});

  void getCurrentWeatherData({
    Function() beforSend,
    Function(CurrentWeatherData currentWeatherData) onSuccess,
    Function(dynamic error) onError,
  }) {
    final url = '$baseUrl/weather?q=$city&lang=fr&$apiKey';
    //print(url);
    ApiRepository(url: '$url', payload: null).get(
        beforeSend: () => {
          if (beforSend != null)
            {
              beforSend(),
            },
        },
        onSuccess: (data) => {
          onSuccess(CurrentWeatherData.fromJson(data)),
        },
        onError: (error) => {
          if (onError != null)
            {
              print(error),
              onError(error),
            }
        });
  }

  void getFiveDaysThreeHoursForcastData({
    Function() beforSend,
    Function(List<FiveDayData> fiveDayData) onSuccess,
    Function(dynamic error) onError,
  }) {
    final url = '$baseUrl/forecast?q=$city&lang=fr&$apiKey';
    print(url);
    ApiRepository(url: '$url', payload: null).get(
        beforeSend: () => {},
        onSuccess: (data) => {
          onSuccess((data['list'] as List)
              ?.map((t) => FiveDayData.fromJson(t))
              ?.toList() ??
              List.empty()),
        },
        onError: (error) => {
          print(error),
          onError(error),
        });
  }
}