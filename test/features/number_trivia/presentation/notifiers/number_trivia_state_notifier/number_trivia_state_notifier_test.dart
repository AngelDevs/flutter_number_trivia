import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia/core/errors/failure/failure.dart';
import 'package:number_trivia/core/utils/input_converter/input_converter.dart';
import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia/number_trivia.dart';
import 'package:number_trivia/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:number_trivia/features/number_trivia/domain/usecases/get_specific_number_trivia.dart';
import 'package:number_trivia/features/number_trivia/presentation/notifiers/number_trivia_state_notifier/number_trivia_state.dart';
import 'package:number_trivia/features/number_trivia/presentation/notifiers/number_trivia_state_notifier/number_trivia_state_notifier.dart';

class MockGetSpecificNumberTrivia extends Mock
    implements GetSpecificNumberTrivia {}

class MockGetRandomNumberTrivia extends Mock implements GetRandomNumberTrivia {}

class MockInputConverter extends Mock implements InputConverter {}

void main() {
  NumberTriviaStateNotifier stateNotifier;
  MockGetSpecificNumberTrivia mockGetSpecificNumberTriviaUseCase;
  MockGetRandomNumberTrivia mockGetRandomNumberTriviaUseCase;
  MockInputConverter mockInputConverter;

  setUp(() {
    mockInputConverter = MockInputConverter();
    mockGetSpecificNumberTriviaUseCase = MockGetSpecificNumberTrivia();
    mockGetRandomNumberTriviaUseCase = MockGetRandomNumberTrivia();
    stateNotifier = NumberTriviaStateNotifier(
      getRandomTriviaUseCase: mockGetRandomNumberTriviaUseCase,
      getSpecificTriviaUseCase: mockGetSpecificNumberTriviaUseCase,
      inputConverter: mockInputConverter,
    );
  });

  Future<void> getSpecificTriviaStateFlow(numberString) async {
    // expect
    expect(stateNotifier.debugState, NumberTriviaState.initial());

    // act
    stateNotifier.getSpecificTrivia(numberString);
    // expect
    expect(stateNotifier.debugState, NumberTriviaState.loading());

    // act
    await untilCalled(mockGetSpecificNumberTriviaUseCase(any));
  }

  Future<void> getRandomTriviaStateFlow() async {
    // expect
    expect(stateNotifier.debugState, NumberTriviaState.initial());

    // act
    stateNotifier.getRandomTrivia();
    // expect
    expect(stateNotifier.debugState, NumberTriviaState.loading());

    // act
    await untilCalled(mockGetRandomNumberTriviaUseCase());
  }

  void whenGetSpecificNumberTriviaUseCaseSuccess(NumberTrivia numberTrivia) {
    when(mockGetSpecificNumberTriviaUseCase(any)).thenAnswer(
      (_) async => Right(numberTrivia),
    );
  }

  void whenGetRandomNumberTriviaUseCaseSuccess(NumberTrivia numberTrivia) {
    when(mockGetRandomNumberTriviaUseCase()).thenAnswer(
      (_) async => Right(numberTrivia),
    );
  }

  void whenInuputConverterSuccess(int numberParsed) {
    when(mockInputConverter.stringToUnsignedInt(any)).thenReturn(
      Right(numberParsed),
    );
  }

  test('should be in a [NumberTriviaState.initial()] state when initialized',
      () {
    // assert

    expect(stateNotifier.debugState, equals(NumberTriviaState.initial()));
  });

  group('GetSpecificNumberTrivia', () {
    final numberString = "1";
    final numberParsed = 1;
    final numberTrivia = const NumberTrivia(number: 1, text: 'test');

    test(
        'should call [InputConverter] to validate and convert the string to an unsigned int when the use case is called',
        () async {
      // arrange
      whenInuputConverterSuccess(numberParsed);
      whenGetSpecificNumberTriviaUseCaseSuccess(numberTrivia);

      // act
      stateNotifier.getSpecificTrivia(numberString);
      await untilCalled(mockInputConverter.stringToUnsignedInt(numberString));

      // assert
      verify(mockInputConverter.stringToUnsignedInt(numberString));
    });

    test(
        'should return [FormatFailure] when the [InputConverter] is called with invalid arguments',
        () {
      // arrange
      when(mockInputConverter.stringToUnsignedInt(any))
          .thenReturn(Left(FormatFailure()));

      // act
      stateNotifier.getSpecificTrivia(numberString);

      // assert
      verify(mockInputConverter.stringToUnsignedInt(numberString));
      expect(
        stateNotifier.debugState,
        NumberTriviaState.invalidInput(),
      );
    });

    test('should get number trivia when the use case is called', () async {
      // arrange
      whenInuputConverterSuccess(numberParsed);
      whenGetSpecificNumberTriviaUseCaseSuccess(numberTrivia);

      // act
      await getSpecificTriviaStateFlow(
        numberString,
      );

      // assert
      expect(
        stateNotifier.debugState,
        NumberTriviaState.success(trivia: numberTrivia),
      );
    });

    test(
        'should return [ServerError] when the use case is called and it fails the remote call',
        () async {
      // arrange
      whenInuputConverterSuccess(numberParsed);
      when(mockGetSpecificNumberTriviaUseCase(any))
          .thenAnswer((_) async => Left(ServerFailure()));

      // act
      await getSpecificTriviaStateFlow(
        numberString,
      );

      // assert
      expect(
        stateNotifier.debugState,
        NumberTriviaState.serverFailure(),
      );
    });

    test(
        'should return [CacheFailure] when the use case is called and it fails the local call',
        () async {
      // arrange
      whenInuputConverterSuccess(numberParsed);
      when(mockGetSpecificNumberTriviaUseCase(any))
          .thenAnswer((_) async => Left(CacheFailure()));

      // act
      await getSpecificTriviaStateFlow(
        numberString,
      );

      // assert
      expect(
        stateNotifier.debugState,
        NumberTriviaState.cacheFailure(),
      );
    });
  });

  group('GetRandomForSpecificNumber', () {
    final numberTrivia = const NumberTrivia(number: 1, text: 'test');

    test('should get number trivia when the use case is called', () async {
      // arrange

      whenGetRandomNumberTriviaUseCaseSuccess(numberTrivia);

      // act
      await getRandomTriviaStateFlow();

      // assert
      expect(
        stateNotifier.debugState,
        NumberTriviaState.success(trivia: numberTrivia),
      );
    });

    test(
        'should return [ServerError] when the use case is called and it fails the remote call',
        () async {
      // arrange

      when(mockGetRandomNumberTriviaUseCase())
          .thenAnswer((_) async => Left(ServerFailure()));

      // act
      await getRandomTriviaStateFlow();

      // assert
      expect(
        stateNotifier.debugState,
        NumberTriviaState.serverFailure(),
      );
    });

    test(
        'should return [CacheError] when the use case is called and it fails the local call',
        () async {
      // arrange

      when(mockGetRandomNumberTriviaUseCase())
          .thenAnswer((_) async => Left(CacheFailure()));

      // act
      await getRandomTriviaStateFlow();

      // assert
      expect(
        stateNotifier.debugState,
        NumberTriviaState.cacheFailure(),
      );
    });
  });
}
