import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:number_trivia/core/errors/exceptions/exceptions.dart';
import 'package:number_trivia/core/utils/endpoints/endpoints.dart'
    show NumbersEndPoints;
import 'package:number_trivia/core/utils/headers/headers.dart';
import 'package:number_trivia/features/number_trivia/data/datasources/number_trivia_remote_datasource/number_trivia_remote_datasource.dart';
import 'package:number_trivia/features/number_trivia/data/models/number_trivia_model/number_trivia_model.dart';

class HttpNumberTriviaRemoteDataSource implements NumberTriviaRemoteDataSource {
  HttpNumberTriviaRemoteDataSource({
    @required this.client,
    @required this.numbersEndPoints,
    @required this.headers,
  });

  final http.Client client;
  final NumbersEndPoints numbersEndPoints;
  final Headers headers;

  @override
  Future<NumberTriviaModel> getRandomNumberTrivia() async {
    final numberTriviaResponse = await client.get(
      numbersEndPoints.randomNumberTrivia(),
      headers: {
        ...headers.applicationJsonContentType,
      },
    );

    if (numberTriviaResponse.statusCode != 200) throw ServerException();

    final numberTriviaModel = numberTriviaResponse.body.toNumberTrivia();
    return numberTriviaModel;
  }

  @override
  Future<NumberTriviaModel> getSpecificNumberTrivia(int number) async {
    final numberTriviaResponse = await client.get(
      numbersEndPoints.concreteNumberTrivia(number),
      headers: {
        ...headers.applicationJsonContentType,
      },
    );

    if (numberTriviaResponse.statusCode != 200) throw ServerException();

    final numberTriviaModel = numberTriviaResponse.body.toNumberTrivia();
    return numberTriviaModel;
  }
}

extension NumberTriviaStringExtension on String {
  NumberTriviaModel toNumberTrivia() {
    final numberTriviaJson = jsonDecode(this);

    final numberTriviaModel = NumberTriviaModel.fromJson(numberTriviaJson);

    return numberTriviaModel;
  }
}
