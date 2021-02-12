import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia/core/errors/exceptions/exceptions.dart';
import 'package:number_trivia/features/number_trivia/data/datasources/number_trivia_local_datasource/number_trivia_local_datasource.dart';
import 'package:number_trivia/features/number_trivia/data/models/number_trivia_model/number_trivia_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../fixtures/utils/fixture_reader.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  SharedPreferenceNumberTriviaLocalDataSource dataSource;
  MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource =
        SharedPreferenceNumberTriviaLocalDataSource(mockSharedPreferences);
  });

  group('getLastNumberTrivia', () {
    final fixtureJsonEncoded = fixtureReader('trivia_cached.json');
    final numberTriviaModel = NumberTriviaModel.fromJson(
      json.decode(fixtureJsonEncoded),
    );
    test(
      'should return [NumberTrivia] from sharedPrefence when there is one cached',
      () async {
        // arrange
        when(mockSharedPreferences.getString(any)).thenReturn(
          fixtureJsonEncoded,
        );

        // act
        final result = await dataSource.getLastNumberTrivia();

        // assert
        verify(
          mockSharedPreferences.getString(dataSource.CACHED_NUMBER_TRIVIA),
        );
        expect(result, equals(numberTriviaModel));
      },
    );

    test(
      'should throw [CacheException] when there is not a cached value',
      () async {
        // arrange
        when(mockSharedPreferences.getString(any)).thenReturn(null);

        // act
        final result = await dataSource.getLastNumberTrivia();

        // assert
        verify(
          mockSharedPreferences.getString(dataSource.CACHED_NUMBER_TRIVIA),
        );
        expect(result, throwsA(isA<CacheException>()));
      },
    );
  });
}
