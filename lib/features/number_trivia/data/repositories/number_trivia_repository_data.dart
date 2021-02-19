import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:number_trivia/core/errors/exceptions/exceptions.dart';
import 'package:number_trivia/core/errors/failure/failure.dart';
import 'package:number_trivia/core/platform/network/network_info_checker.dart';
import 'package:number_trivia/features/number_trivia/data/datasources/number_trivia_local_datasource/number_trivia_local_datasource.dart';
import 'package:number_trivia/features/number_trivia/data/datasources/number_trivia_remote_datasource/number_trivia_remote_datasource.dart';
import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia/number_trivia.dart';
import 'package:number_trivia/features/number_trivia/domain/repositories/number_trivia_repository.dart';

class NumberTriviaRepositoryData implements NumberTriviaRepository {
  const NumberTriviaRepositoryData({
    @required this.remoteDataSource,
    @required this.localDataSource,
    @required this.netWorkInfo,
  });

  final NumberTriviaRemoteDataSource remoteDataSource;
  final NumberTriviaLocalDataSource localDataSource;
  final NetWorkInfoChecker netWorkInfo;

  @override
  Future<Either<Failure, NumberTrivia>> getSpecificNumberTrivia(
    int number,
  ) async {
    if (await netWorkInfo.isConnected) {
      return await _getRemoteSpecificNumberTrivia(number);
    } else {
      return await _getCachedNumberTrivia();
    }
  }

  Future<Either<Failure, NumberTrivia>> _getRemoteSpecificNumberTrivia(
    int number,
  ) async {
    try {
      return await _tryGetSpecificNumberTrivia(number);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Right<Failure, NumberTrivia>> _tryGetSpecificNumberTrivia(
    int number,
  ) async {
    final numberTrivia = await remoteDataSource.getSpecificNumberTrivia(number);
    localDataSource.cacheNumberTrivia(numberTrivia);
    return Right(numberTrivia);
  }

  Future<Either<Failure, NumberTrivia>> _getCachedNumberTrivia() async {
    try {
      return await _tryGetLastNumberTrivia();
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  Future<Right<Failure, NumberTrivia>> _tryGetLastNumberTrivia() async {
    final numberTrivia = await localDataSource.getLastNumberTrivia();
    return Right(numberTrivia);
  }

  @override
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia() async {
    if (await netWorkInfo.isConnected) {
      return await _getRemoteNumberTrivia();
    } else {
      return await _getCachedNumberTrivia();
    }
  }

  Future<Either<Failure, NumberTrivia>> _getRemoteNumberTrivia() async {
    try {
      return await _tryGetRemoteNumberTrivia();
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Right<Failure, NumberTrivia>> _tryGetRemoteNumberTrivia() async {
    final numberTrivia = await remoteDataSource.getRandomNumberTrivia();
    localDataSource.cacheNumberTrivia(numberTrivia);
    return Right(numberTrivia);
  }
}
