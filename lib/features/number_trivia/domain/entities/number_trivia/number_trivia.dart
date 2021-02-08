import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'number_trivia.freezed.dart';
part 'number_trivia.g.dart';

@immutable
@freezed
abstract class NumberTrivia with _$NumberTrivia {
  const factory NumberTrivia({
    @required String text,
    @required int number,
  }) = _NumberTrivia;

  factory NumberTrivia.fromJson(Map<String, dynamic> json) =>
      _$NumberTriviaFromJson(json);
}