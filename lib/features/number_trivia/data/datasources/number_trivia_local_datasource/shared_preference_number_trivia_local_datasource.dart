import 'dart:convert';

import 'package:number_trivia/core/errors/exceptions/exceptions.dart';
import 'package:number_trivia/features/number_trivia/data/datasources/number_trivia_local_datasource/number_trivia_local_datasource.dart';
import 'package:number_trivia/features/number_trivia/data/models/number_trivia_model/number_trivia_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceNumberTriviaLocalDataSource
    implements NumberTriviaLocalDataSource {
  SharedPreferenceNumberTriviaLocalDataSource(
    this.cacheManager,
  );

  final SharedPreferences cacheManager;

  @override
  String get CACHED_NUMBER_TRIVIA => 'CACHED_NUMBER_TRIVIA';

  @override
  Future<void> cacheNumberTrivia(NumberTriviaModel numberTrivia) async {
    final numberTriviaJson = numberTrivia.toJson();
    await cacheManager.setString(
      CACHED_NUMBER_TRIVIA,
      json.encode(numberTriviaJson),
    );
  }

  @override
  Future<NumberTriviaModel> getLastNumberTrivia() async {
    final String numberTriviaJsonString = cacheManager.getString(
      CACHED_NUMBER_TRIVIA,
    );
    checkCacheValue(numberTriviaJsonString);
    final numberTriviaJson = json.decode(numberTriviaJsonString);
    final numberTriviaModel = NumberTriviaModel.fromJson(numberTriviaJson);
    return numberTriviaModel;
  }

  void checkCacheValue(Object cacheValue) {
    if (cacheValue == null) {
      throw CacheException();
    }
  }
}
