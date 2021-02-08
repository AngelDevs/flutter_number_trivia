import 'package:number_trivia/core/utils/either/either.dart';
import 'package:number_trivia/core/utils/failure/failure.dart';
import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia/number_trivia.dart';

abstract class NumberTriviaRepository {
  Future<Either<Failure, NumberTrivia>> getSpecificNumberTrivia(int number);
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia(int number);
}