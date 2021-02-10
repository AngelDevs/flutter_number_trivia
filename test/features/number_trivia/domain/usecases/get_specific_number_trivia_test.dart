import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia/number_trivia.dart';
import 'package:number_trivia/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:number_trivia/features/number_trivia/domain/usecases/get_specific_number_trivia.dart';

class MockNumberTriviaRepository extends Mock
    implements NumberTriviaRepository {}

void main() {
  GetSpecificNumberTrivia useCase;
  MockNumberTriviaRepository mockNumberTriviaRepository;

  setUp(() {
    mockNumberTriviaRepository = MockNumberTriviaRepository();
    useCase = GetSpecificNumberTrivia(mockNumberTriviaRepository);
  });

  const number = 1;
  const numberTrivia = NumberTrivia(number: 1, text: 'test');

  test(
    'should get trivia for the number from the repository',
    () async {
      // arrange
      when(mockNumberTriviaRepository.getSpecificNumberTrivia(any)).thenAnswer(
        (_) async => const Right(numberTrivia),
      );

      // act
      final result = await useCase(number);

      // assert
      expect(
        result,
        const Right(numberTrivia),
      );

      verify(
        mockNumberTriviaRepository.getSpecificNumberTrivia(number),
      );
    },
  );
}
