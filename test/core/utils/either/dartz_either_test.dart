import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:number_trivia/core/errors/failure/failure.dart';
import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia/number_trivia.dart';

Either<Failure, NumberTrivia> testEitherLeftSide() {
  return Left(ServerFailure());
}

void main() {
  test(
    'dartz either left side should be equal when contains same data ',
    () {
      // arrange
      final eitherOne = Left(ServerFailure());
      final eitherTwo = Left(ServerFailure());

      // assert
      expect(eitherOne, equals(eitherTwo));
    },
  );

  test(
    'dartz either left side should be equal when method returns a class that extends left type',
    () {
      // arrange
      final eitherLeftResult = testEitherLeftSide();
      final expectedLeftResult = Left(ServerFailure());

      // assert
      expect(eitherLeftResult, equals(expectedLeftResult));
    },
  );
}
