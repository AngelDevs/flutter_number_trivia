import 'dart:convert';

import 'package:number_trivia/features/number_trivia/data/models/number_trivia_model/number_trivia_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class NumberTriviaLocalDataSource {
  /// Gets the cached [NumberTriviaModel] which was gotten the last time
  /// the user had an internet connection.
  ///
  /// Throws [CacheException] if no cached data is present.
  Future<NumberTriviaModel> getLastNumberTrivia();

  Future<void> cacheNumberTrivia(NumberTriviaModel numberTriviaModel);

  String get CACHED_NUMBER_TRIVIA;
}

class SharedPreferenceNumberTriviaLocalDataSource
    implements NumberTriviaLocalDataSource {
  SharedPreferenceNumberTriviaLocalDataSource(
    this.cacheManager,
  );

  final SharedPreferences cacheManager;

  @override
  Future<void> cacheNumberTrivia(NumberTriviaModel numberTriviaModel) {
    // TODO: implement cacheNumberTrivia
    throw UnimplementedError();
  }

  @override
  Future<NumberTriviaModel> getLastNumberTrivia() async {
    final numberTriviaJsonString = cacheManager.getString(CACHED_NUMBER_TRIVIA);
    final numberTriviaJson = json.decode(numberTriviaJsonString);
    final numberTriviaModel = NumberTriviaModel.fromJson(numberTriviaJson);
    return numberTriviaModel;
  }

  @override
  String get CACHED_NUMBER_TRIVIA => 'CACHED_NUMBER_TRIVIA';
}
