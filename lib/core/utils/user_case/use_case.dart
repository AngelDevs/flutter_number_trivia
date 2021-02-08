import 'package:number_trivia/core/utils/either/either.dart';
import 'package:number_trivia/core/utils/failure/failure.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);

  Future<Either<Failure, Type>> execute();
}
