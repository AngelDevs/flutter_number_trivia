// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'number_trivia.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
NumberTrivia _$NumberTriviaFromJson(Map<String, dynamic> json) {
  return _NumberTrivia.fromJson(json);
}

/// @nodoc
class _$NumberTriviaTearOff {
  const _$NumberTriviaTearOff();

// ignore: unused_element
  _NumberTrivia call({@required String text, @required int number}) {
    return _NumberTrivia(
      text: text,
      number: number,
    );
  }

// ignore: unused_element
  NumberTrivia fromJson(Map<String, Object> json) {
    return NumberTrivia.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $NumberTrivia = _$NumberTriviaTearOff();

/// @nodoc
mixin _$NumberTrivia {
  String get text;
  int get number;

  Map<String, dynamic> toJson();
  @JsonKey(ignore: true)
  $NumberTriviaCopyWith<NumberTrivia> get copyWith;
}

/// @nodoc
abstract class $NumberTriviaCopyWith<$Res> {
  factory $NumberTriviaCopyWith(
          NumberTrivia value, $Res Function(NumberTrivia) then) =
      _$NumberTriviaCopyWithImpl<$Res>;
  $Res call({String text, int number});
}

/// @nodoc
class _$NumberTriviaCopyWithImpl<$Res> implements $NumberTriviaCopyWith<$Res> {
  _$NumberTriviaCopyWithImpl(this._value, this._then);

  final NumberTrivia _value;
  // ignore: unused_field
  final $Res Function(NumberTrivia) _then;

  @override
  $Res call({
    Object text = freezed,
    Object number = freezed,
  }) {
    return _then(_value.copyWith(
      text: text == freezed ? _value.text : text as String,
      number: number == freezed ? _value.number : number as int,
    ));
  }
}

/// @nodoc
abstract class _$NumberTriviaCopyWith<$Res>
    implements $NumberTriviaCopyWith<$Res> {
  factory _$NumberTriviaCopyWith(
          _NumberTrivia value, $Res Function(_NumberTrivia) then) =
      __$NumberTriviaCopyWithImpl<$Res>;
  @override
  $Res call({String text, int number});
}

/// @nodoc
class __$NumberTriviaCopyWithImpl<$Res> extends _$NumberTriviaCopyWithImpl<$Res>
    implements _$NumberTriviaCopyWith<$Res> {
  __$NumberTriviaCopyWithImpl(
      _NumberTrivia _value, $Res Function(_NumberTrivia) _then)
      : super(_value, (v) => _then(v as _NumberTrivia));

  @override
  _NumberTrivia get _value => super._value as _NumberTrivia;

  @override
  $Res call({
    Object text = freezed,
    Object number = freezed,
  }) {
    return _then(_NumberTrivia(
      text: text == freezed ? _value.text : text as String,
      number: number == freezed ? _value.number : number as int,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_NumberTrivia with DiagnosticableTreeMixin implements _NumberTrivia {
  const _$_NumberTrivia({@required this.text, @required this.number})
      : assert(text != null),
        assert(number != null);

  factory _$_NumberTrivia.fromJson(Map<String, dynamic> json) =>
      _$_$_NumberTriviaFromJson(json);

  @override
  final String text;
  @override
  final int number;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'NumberTrivia(text: $text, number: $number)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'NumberTrivia'))
      ..add(DiagnosticsProperty('text', text))
      ..add(DiagnosticsProperty('number', number));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _NumberTrivia &&
            (identical(other.text, text) ||
                const DeepCollectionEquality().equals(other.text, text)) &&
            (identical(other.number, number) ||
                const DeepCollectionEquality().equals(other.number, number)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(text) ^
      const DeepCollectionEquality().hash(number);

  @JsonKey(ignore: true)
  @override
  _$NumberTriviaCopyWith<_NumberTrivia> get copyWith =>
      __$NumberTriviaCopyWithImpl<_NumberTrivia>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_NumberTriviaToJson(this);
  }
}

abstract class _NumberTrivia implements NumberTrivia {
  const factory _NumberTrivia({@required String text, @required int number}) =
      _$_NumberTrivia;

  factory _NumberTrivia.fromJson(Map<String, dynamic> json) =
      _$_NumberTrivia.fromJson;

  @override
  String get text;
  @override
  int get number;
  @override
  @JsonKey(ignore: true)
  _$NumberTriviaCopyWith<_NumberTrivia> get copyWith;
}
