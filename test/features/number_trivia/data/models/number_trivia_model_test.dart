import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:number_trivia/features/number_trivia/data/models/number_trivia_model/number_trivia_model.dart';
import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia/number_trivia.dart';

import '../../../../fixtures/utils/fixture_reader.dart';

void main() {
  const numberTriviaModel = NumberTriviaModel(
    number: 1,
    text: "Test",
  );

  final expectedMap = {
    "number": 1,
    "text": "Test",
  };

  group('equality', () {
    test(
      'should return true when compared with number trivia parent class',
      () {
        expect(numberTriviaModel, isA<NumberTrivia>());
      },
    );
  });

  group(
    'fromJson',
    () {
      test(
        'should return a valid model when the JSON model is an integer',
        () {
          // arrange
          final jsonString = fixtureReader('trivia.json');
          final jsonMap = jsonDecode(jsonString) as Map<String, dynamic>;

          // act
          final result = NumberTriviaModel.fromJson(jsonMap);

          // assert
          expect(result, numberTriviaModel);
        },
      );

      test(
        'should return a valid model when the JSON model is a double',
        () {
          // arrange
          final jsonString = fixtureReader('trivia_double.json');
          final jsonMap = jsonDecode(jsonString) as Map<String, dynamic>;

          // act
          final result = NumberTriviaModel.fromJson(jsonMap);

          // assert
          expect(result, numberTriviaModel);
        },
      );
    },
  );
  group(
    'toJson',
    () {
      test(
        'should return a JSON with the correct data',
        () {
          // act
          final result = numberTriviaModel.toJson();

          // assert

          expect(result, expectedMap);
        },
      );
    },
  );
}
