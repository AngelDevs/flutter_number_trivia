import 'package:number_trivia/core/utils/either/either.dart';
import 'package:number_trivia/core/utils/failure/failure.dart';
import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia/number_trivia.dart';
import 'package:number_trivia/features/number_trivia/domain/repositories/number_trivia_repository.dart';

class GetRandomNumberTrivia {
  final NumberTriviaRepository numberTriviaRepository;

  GetRandomNumberTrivia(this.numberTriviaRepository);

  Future<Either<Failure, NumberTrivia>> call(
    int number,
  ) async {
    final numberTrivia = await numberTriviaRepository.getRandomNumberTrivia(
      number,
    );
    return numberTrivia;
  }
}
