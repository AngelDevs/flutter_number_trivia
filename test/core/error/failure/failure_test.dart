import 'package:flutter_test/flutter_test.dart';
import 'package:number_trivia/core/errors/failure/failure.dart';

void main() {
  test('server failure should be of type failure', () {
    // arrange
    final serverFailure = ServerFailure();

    // assert
    expect(serverFailure, isA<Failure>());
  });
}
