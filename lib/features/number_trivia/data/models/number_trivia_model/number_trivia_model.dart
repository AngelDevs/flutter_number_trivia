import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia/number_trivia.dart';

part 'number_trivia_model.g.dart';

@immutable
@JsonSerializable(fieldRename: FieldRename.snake)
class NumberTriviaModel extends NumberTrivia {
  const NumberTriviaModel({
    @required this.text,
    @required this.number,
  }) : super(
          text: text,
          number: number,
        );

  final String text;

  @JsonKey(
    fromJson: _numberFromJson,
    toJson: _numberFromJson,
  )
  final int number;

  factory NumberTriviaModel.fromJson(Map<String, dynamic> json) =>
      _$NumberTriviaModelFromJson(json);

  Map<String, dynamic> toJson() => _$NumberTriviaModelToJson(this);
}

int _numberFromJson(num number) => number.toInt();