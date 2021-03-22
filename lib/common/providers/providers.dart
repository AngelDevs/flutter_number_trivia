import 'package:connectivity/connectivity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:number_trivia/core/platform/network/connectivity_network_info_checker.dart';
import 'package:number_trivia/core/utils/headers/headers.dart';
import 'package:number_trivia/core/utils/input_converter/input_converter.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferencesFutureProvider = FutureProvider(
  (ref) async => await SharedPreferences.getInstance(),
);

final headersProvider = Provider(
  (ref) => AppHeaders(),
);

final inputConverterProvider = Provider(
  (ref) => InputConverter(),
);

final networkInfoProvider = Provider(
  (ref) => ConnectivityNetWorkInfoChecker(Connectivity()),
);
