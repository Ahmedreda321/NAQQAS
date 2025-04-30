import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

import '../network/api_consumer.dart';
import '../network/dio_consumer.dart';
import '../network/dio_factory.dart';

final sl = GetIt.instance;

Future<void> initServiceLocator() async {
  sl.registerLazySingleton<Dio>(() => DioFactory.createDio());

  sl.registerLazySingleton<ApiConsumer>(() => DioConsumer());
}
