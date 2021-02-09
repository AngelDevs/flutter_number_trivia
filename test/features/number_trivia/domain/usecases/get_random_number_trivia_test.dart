import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia/core/utils/either/either.dart';
import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia/number_trivia.dart';
import 'package:number_trivia/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:number_trivia/features/number_trivia/domain/usecases/get_random_number_trivia.dart';

class MockNumberTriviaRepository extends Mock
    implements NumberTriviaRepository {}

void main() {
  GetRandomNumberTrivia useCase;
  MockNumberTriviaRepository mockNumberTriviaRepository;

  setUp(() {
    mockNumberTriviaRepository = MockNumberTriviaRepository();
    useCase = GetRandomNumberTrivia(mockNumberTriviaRepository);
  });
  const numberTrivia = NumberTrivia(number: 1, text: 'test');

  test(
    'should get trivia for random number',
    () async {
      // arrange
      when(mockNumberTriviaRepository.getRandomNumberTrivia()).thenAnswer(
        (_) async => const Right(numberTrivia),
      );

      // act
      final result = await useCase();

      // assert
      expect(
        result,
        const Right(numberTrivia),
      );

      verify(
        mockNumberTriviaRepository.getRandomNumberTrivia(),
      );
    },
  );
}
