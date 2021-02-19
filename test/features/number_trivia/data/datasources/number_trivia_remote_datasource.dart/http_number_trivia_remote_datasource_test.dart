import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:number_trivia/core/errors/exceptions/exceptions.dart';
import 'package:number_trivia/core/utils/endpoints/endpoints.dart'
    show NumbersEndPoints;
import 'package:number_trivia/core/utils/headers/headers.dart';
import 'package:number_trivia/features/number_trivia/data/datasources/number_trivia_remote_datasource/http_number_trivia_remote_datasource.dart';
import 'package:number_trivia/features/number_trivia/data/models/number_trivia_model/number_trivia_model.dart';

import '../../../../../fixtures/utils/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  HttpNumberTriviaRemoteDataSource dataSource;
  MockHttpClient mockHttpClient;
  NumbersEndPoints numbersApiEndPoints;
  Headers headers;

  setUp(() async {
    mockHttpClient = MockHttpClient();
    numbersApiEndPoints = NumbersEndPoints();
    headers = AppHeaders();
    dataSource = HttpNumberTriviaRemoteDataSource(
      client: mockHttpClient,
      numbersEndPoints: numbersApiEndPoints,
      headers: headers,
    );
  });

  void whenHttpClientSuccess() {
    final triviaFixture = fixtureReader('trivia.json');

    when(
      mockHttpClient.get(any, headers: anyNamed('headers')),
    ).thenAnswer((_) async => http.Response(triviaFixture, 200));
  }

  void whenHttpClientFails() {
    final triviaFixture = fixtureReader('trivia.json');

    when(
      mockHttpClient.get(any, headers: anyNamed('headers')),
    ).thenAnswer((_) async => http.Response(triviaFixture, 500));
  }

  group('getConcreteNumberTrivia', () {
    final number = 1;
    final triviaFixture = fixtureReader('trivia.json');
    final triviaJson = jsonDecode(triviaFixture);
    final numberTriviaModel = NumberTriviaModel.fromJson(triviaJson);

    test(
        'should have the number as the endpoint and application/json content-type header when a GET request call is made',
        () async {
      // arrange

      whenHttpClientSuccess();

      // act
      dataSource.getSpecificNumberTrivia(number);

      // assert
      verify(mockHttpClient.get(
        numbersApiEndPoints.concreteNumberTrivia(number),
        headers: {
          ...headers.applicationJsonContentType,
        },
      ));
    });

    test(
        'should return a number trivia model when the response status code is 200 (successful)',
        () async {
      // arrange
      whenHttpClientSuccess();

      // act
      final result = await dataSource.getSpecificNumberTrivia(number);

      // assert
      verify(mockHttpClient.get(
        numbersApiEndPoints.concreteNumberTrivia(number),
        headers: {
          ...headers.applicationJsonContentType,
        },
      ));

      expect(result, equals(numberTriviaModel));
    });

    test(
        'should throw [ServerException] when the response status code is not 200 (unsuccessful)',
        () async {
      // arrange
      whenHttpClientFails();

      // act
      final call = dataSource.getSpecificNumberTrivia;

      // assert

      expect(() => call(number), throwsA(isA<ServerException>()));
    });
  });

  group('getRandomNumberTrivia', () {
    final triviaFixture = fixtureReader('trivia.json');
    final triviaJson = jsonDecode(triviaFixture);
    final numberTriviaModel = NumberTriviaModel.fromJson(triviaJson);

    test(
        'should return a number trivia model when the response status code is 200 (successful)',
        () async {
      // arrange
      whenHttpClientSuccess();

      // act
      final result = await dataSource.getRandomNumberTrivia();

      // assert
      verify(mockHttpClient.get(
        numbersApiEndPoints.randomNumberTrivia(),
        headers: {
          ...headers.applicationJsonContentType,
        },
      ));

      expect(result, equals(numberTriviaModel));
    });

    test(
        'should throw [ServerException] when the response status code is not 200 (unsuccessful)',
        () async {
      // arrange
      whenHttpClientFails();

      // act
      final call = dataSource.getRandomNumberTrivia;

      // assert

      expect(() => call(), throwsA(isA<ServerException>()));
    });
  });
}
