import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:number_trivia/core/errors/failure/failure.dart';
import 'package:number_trivia/core/utils/input_converter/input_converter.dart';

void main() {
  InputConverter inputConverter;

  setUp(() {
    inputConverter = InputConverter();
  });

  group('stringToUnsingnedInt', () {
    test('should return an integer when the string represents an integer', () {
      // arrange
      final string = '123';
      final expectedResult = 123;
      // act
      final result = inputConverter.stringToUnsignedInt(string);

      // assert
      expect(result, Right(expectedResult));
    });

    test(
        'should return an integer when the string represents an negative integer',
        () {
      // arrange
      final string = '-123';
      final expectedResult = 123;
      // act
      final result = inputConverter.stringToUnsignedInt(string);

      // assert
      expect(result, Right(expectedResult));
    });

    test(
        'should return an [FormatFailure] when the string is an invalid number',
        () {
      // arrange
      final string = 'abc';

      // act
      final result = inputConverter.stringToUnsignedInt(string);

      // assert
      expect(result, Left(FormatFailure()));
    });
  });
}
