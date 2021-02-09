import 'package:meta/meta.dart';
import 'package:number_trivia/core/errors/failure/failure.dart';
import 'package:number_trivia/core/platform/network/network_info.dart';
import 'package:number_trivia/core/utils/either/either.dart';
import 'package:number_trivia/features/number_trivia/data/datasources/number_trivia_local_datasource.dart';
import 'package:number_trivia/features/number_trivia/data/datasources/number_trivia_remote_datasource.dart';
import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia/number_trivia.dart';
import 'package:number_trivia/features/number_trivia/domain/repositories/number_trivia_repository.dart';

class NumberTriviaRepositoryImpl implements NumberTriviaRepository {
  const NumberTriviaRepositoryImpl({
    @required this.remoteDataSource,
    @required this.localDataSource,
    @required this.networkInfo,
  });

  final NumberTriviaRemoteDataSource remoteDataSource;
  final NumberTriviaLocalDataSource localDataSource;
  final NetWorkInfo networkInfo;

  @override
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia() {
    return null;
  }

  @override
  Future<Either<Failure, NumberTrivia>> getSpecificNumberTrivia(
    int number,
  ) async {
    networkInfo.isConnected;

    return Right(await remoteDataSource.getSpecificNumberTrivia(number));
  }
}