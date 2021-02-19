import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:number_trivia/core/errors/failure/failure.dart';
import 'package:number_trivia/core/utils/input_converter/input_converter.dart';
import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia/number_trivia.dart';
import 'package:number_trivia/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:number_trivia/features/number_trivia/domain/usecases/get_specific_number_trivia.dart';
import 'package:number_trivia/features/number_trivia/presentation/notifiers/number_trivia_state_notifier/number_trivia_state.dart';

class NumberTriviaStateNotifier extends StateNotifier<NumberTriviaState> {
  NumberTriviaStateNotifier({
    @required GetSpecificNumberTrivia getSpecificTriviaUseCase,
    @required GetRandomNumberTrivia getRandomTriviaUseCase,
    @required InputConverter inputConverter,
  })  : _getSpecificTriviaUseCase = getSpecificTriviaUseCase,
        _getRandomTriviaUseCase = getRandomTriviaUseCase,
        _inputConverter = inputConverter,
        super(NumberTriviaState.initial());

  final GetSpecificNumberTrivia _getSpecificTriviaUseCase;
  final GetRandomNumberTrivia _getRandomTriviaUseCase;
  final InputConverter _inputConverter;

  void getSpecificTrivia(String textId) async {
    state = NumberTriviaState.loading();
    final textIdConversionResult = _inputConverter.stringToUnsignedInt(textId);

    textIdConversionResult.fold(
      (failure) => state = NumberTriviaState.invalidInput(),
      (id) async => await _getSpecificTriviaSuccess(id),
    );
  }

  void _getSpecificTriviaSuccess(int id) async {
    final triviaResult = await _getSpecificTriviaUseCase(id);

    _handleTriviaResult(triviaResult);
  }

  void _handleTriviaResult(Either<Failure, NumberTrivia> triviaResult) {
    triviaResult.fold(
      _handleGetTriviaFailure,
      _handleGetTriviaSuccess,
    );
  }

  void _handleGetTriviaFailure(Failure failure) {
    failure.maybeWhen(serverFailure: () {
      state = NumberTriviaState.serverFailure();
      return;
    }, cacheFailure: () {
      state = NumberTriviaState.cacheFailure();
      return;
    }, orElse: () {
      throw Exception('unexpected error in number trivia state');
    });
  }

  void _handleGetTriviaSuccess(trivia) {
    state = NumberTriviaState.success(trivia: trivia);
  }

  void getRandomTrivia() async {
    state = NumberTriviaState.loading();
    final randomTriviaResult = await _getRandomTriviaUseCase();

    _handleTriviaResult(randomTriviaResult);
  }
}
