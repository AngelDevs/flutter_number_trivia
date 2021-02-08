// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'failure.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$FailureTearOff {
  const _$FailureTearOff();

// ignore: unused_element
  _Failure call([List<dynamic> properties = const []]) {
    return _Failure(
      properties,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $Failure = _$FailureTearOff();

/// @nodoc
mixin _$Failure {
  List<dynamic> get properties;

  @JsonKey(ignore: true)
  $FailureCopyWith<Failure> get copyWith;
}

/// @nodoc
abstract class $FailureCopyWith<$Res> {
  factory $FailureCopyWith(Failure value, $Res Function(Failure) then) =
      _$FailureCopyWithImpl<$Res>;
  $Res call({List<dynamic> properties});
}

/// @nodoc
class _$FailureCopyWithImpl<$Res> implements $FailureCopyWith<$Res> {
  _$FailureCopyWithImpl(this._value, this._then);

  final Failure _value;
  // ignore: unused_field
  final $Res Function(Failure) _then;

  @override
  $Res call({
    Object properties = freezed,
  }) {
    return _then(_value.copyWith(
      properties: properties == freezed
          ? _value.properties
          : properties as List<dynamic>,
    ));
  }
}

/// @nodoc
abstract class _$FailureCopyWith<$Res> implements $FailureCopyWith<$Res> {
  factory _$FailureCopyWith(_Failure value, $Res Function(_Failure) then) =
      __$FailureCopyWithImpl<$Res>;
  @override
  $Res call({List<dynamic> properties});
}

/// @nodoc
class __$FailureCopyWithImpl<$Res> extends _$FailureCopyWithImpl<$Res>
    implements _$FailureCopyWith<$Res> {
  __$FailureCopyWithImpl(_Failure _value, $Res Function(_Failure) _then)
      : super(_value, (v) => _then(v as _Failure));

  @override
  _Failure get _value => super._value as _Failure;

  @override
  $Res call({
    Object properties = freezed,
  }) {
    return _then(_Failure(
      properties == freezed ? _value.properties : properties as List<dynamic>,
    ));
  }
}

/// @nodoc
class _$_Failure with DiagnosticableTreeMixin implements _Failure {
  const _$_Failure([this.properties = const []]) : assert(properties != null);

  @JsonKey(defaultValue: const [])
  @override
  final List<dynamic> properties;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Failure(properties: $properties)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Failure'))
      ..add(DiagnosticsProperty('properties', properties));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Failure &&
            (identical(other.properties, properties) ||
                const DeepCollectionEquality()
                    .equals(other.properties, properties)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(properties);

  @JsonKey(ignore: true)
  @override
  _$FailureCopyWith<_Failure> get copyWith =>
      __$FailureCopyWithImpl<_Failure>(this, _$identity);
}

abstract class _Failure implements Failure {
  const factory _Failure([List<dynamic> properties]) = _$_Failure;

  @override
  List<dynamic> get properties;
  @override
  @JsonKey(ignore: true)
  _$FailureCopyWith<_Failure> get copyWith;
}
