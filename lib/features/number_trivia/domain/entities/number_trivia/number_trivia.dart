import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
class NumberTrivia extends Equatable {
  const NumberTrivia({
    @required this.text,
    @required this.number,
  });
  final text;
  final number;

  @override
  List<Object> get props => [text, number];
}
