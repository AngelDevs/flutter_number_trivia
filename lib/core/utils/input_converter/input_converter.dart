import 'package:dartz/dartz.dart';
import 'package:number_trivia/core/errors/failure/failure.dart';

class InputConverter {
  Either<Failure, int> stringToUnsignedInt(String str) {
    try {
      final number = int.parse(str).abs();
      return Right(number);
    } on FormatException {
      return Left(FormatFailure());
    }
  }
}
