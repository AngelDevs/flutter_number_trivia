import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia/core/errors/exceptions/exceptions.dart';
import 'package:number_trivia/core/errors/failure/failure.dart';
import 'package:number_trivia/core/platform/network/network_info.dart';
import 'package:number_trivia/features/number_trivia/data/datasources/number_trivia_local_datasource.dart';
import 'package:number_trivia/features/number_trivia/data/datasources/number_trivia_remote_datasource.dart';
import 'package:number_trivia/features/number_trivia/data/models/number_trivia_model/number_trivia_model.dart';
import 'package:number_trivia/features/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia/number_trivia.dart';

class MockRemoteDataSource extends Mock
    implements NumberTriviaRemoteDataSource {}

class MockLocalDataSource extends Mock implements NumberTriviaLocalDataSource {}

class MockNetworkInfo extends Mock implements NetWorkInfo {}

void main() {
  NumberTriviaRepositoryImpl repository;
  MockLocalDataSource mockLocalDataSource;
  MockRemoteDataSource mockRemoteDataSource;
  MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = NumberTriviaRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  group(
    'getConcreteNumberTrivia',
    () {
      final number = 1;
      final numberTriviaModel = NumberTriviaModel(
        number: number,
        text: 'test',
      );
      final NumberTrivia numberTrivia = numberTriviaModel;

      test(
        'should check if device is online',
        () async {
          // arrange
          when(mockNetworkInfo.isConnected).thenAnswer(
            (_) async => true,
          );
          when(mockRemoteDataSource.getSpecificNumberTrivia(any)).thenAnswer(
            (_) async => numberTriviaModel,
          );

          // act
          repository.getSpecificNumberTrivia(number);

          // expect
          verify(mockNetworkInfo.isConnected);
        },
      );

      group(
        'device is online',
        () {
          setUp(() {
            when(mockNetworkInfo.isConnected).thenAnswer(
              (_) async => true,
            );
          });

          test(
            'should return remote data when the call to remote datasource is successful ',
            () async {
              // arrange
              when(mockRemoteDataSource.getSpecificNumberTrivia(any))
                  .thenAnswer(
                (_) async => numberTriviaModel,
              );
              // act
              final result = await repository.getSpecificNumberTrivia(number);

              // expect
              verify(mockRemoteDataSource.getSpecificNumberTrivia(number));
              expect(result, equals(Right(numberTrivia)));
            },
          );

          test(
            'should cache the data locally when the call to remote datasource is successful ',
            () async {
              // arrange
              when(mockRemoteDataSource.getSpecificNumberTrivia(any))
                  .thenAnswer(
                (_) async => numberTriviaModel,
              );
              // act
              await repository.getSpecificNumberTrivia(number);

              // expect
              verify(mockRemoteDataSource.getSpecificNumberTrivia(number));
              verify(mockLocalDataSource.cacheNumberTrivia(numberTriviaModel));
            },
          );

          test(
            'should return server failure when the call to remote datasource is unsuccessful ',
            () async {
              // arrange
              when(mockRemoteDataSource.getSpecificNumberTrivia(any)).thenThrow(
                ServerException(),
              );
              // act
              final result = await repository.getSpecificNumberTrivia(number);

              // expect
              verify(mockRemoteDataSource.getSpecificNumberTrivia(number));
              verifyZeroInteractions(mockLocalDataSource);
              expect(
                result,
                equals(
                  Left(ServerFailure()),
                ),
              );
            },
          );
        },
      );

      group(
        'device is offline',
        () {
          setUp(() {
            when(mockNetworkInfo.isConnected).thenAnswer(
              (_) async => false,
            );
          });

          test(
            'should return last locally cached data when the cached data is present',
            () async {
              // arrange
              when(mockLocalDataSource.getLastNumberTrivia()).thenAnswer(
                (_) async => numberTriviaModel,
              );

              // act
              final result = await repository.getSpecificNumberTrivia(number);

              // assert
              verifyZeroInteractions(mockRemoteDataSource);
              verify(mockLocalDataSource.getLastNumberTrivia);
              expect(result, Right(numberTrivia));
            },
          );
        },
      );
    },
  );
}
