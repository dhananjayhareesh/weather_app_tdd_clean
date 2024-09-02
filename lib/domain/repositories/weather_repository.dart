import 'package:dartz/dartz.dart';
import 'package:weatherapp_tdd/core/error/failure.dart';
import 'package:weatherapp_tdd/domain/entities/weather.dart';

abstract class WeatherRepository {
  Future<Either<Failure, WeatherEntity>> getCurrentWeather(String cityName);
}
