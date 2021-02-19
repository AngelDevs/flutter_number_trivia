import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia/number_trivia.dart';

part 'number_trivia_state.freezed.dart';

@freezed
abstract class NumberTriviaState with _$NumberTriviaState {
  const factory NumberTriviaState() = _NumberTriviaState;
  const factory NumberTriviaState.initial() = _Initial;
  const factory NumberTriviaState.empty() = _Empty;
  const factory NumberTriviaState.loading() = _Loading;
  const factory NumberTriviaState.success({
    NumberTrivia trivia,
  }) = _Success;
  const factory NumberTriviaState.cacheFailure() = _CacheError;
  const factory NumberTriviaState.serverFailure() = _ServerError;
  const factory NumberTriviaState.invalidInput() = _InvalidInput;
}
