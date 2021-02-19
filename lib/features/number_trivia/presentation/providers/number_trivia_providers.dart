import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:number_trivia/common/providers/providers.dart';
import 'package:number_trivia/core/utils/endpoints/endpoints.dart';
import 'package:number_trivia/features/number_trivia/data/datasources/number_trivia_local_datasource/number_trivia_local_datasource.dart';
import 'package:number_trivia/features/number_trivia/data/datasources/number_trivia_local_datasource/shared_preference_number_trivia_local_datasource.dart';
import 'package:number_trivia/features/number_trivia/data/datasources/number_trivia_remote_datasource/http_number_trivia_remote_datasource.dart';
import 'package:number_trivia/features/number_trivia/data/datasources/number_trivia_remote_datasource/number_trivia_remote_datasource.dart';
import 'package:number_trivia/features/number_trivia/data/repositories/number_trivia_repository_data.dart';
import 'package:number_trivia/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:number_trivia/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:number_trivia/features/number_trivia/domain/usecases/get_specific_number_trivia.dart';
import 'package:number_trivia/features/number_trivia/presentation/notifiers/number_trivia_state_notifier/number_trivia_state_notifier.dart';

final numbersEndPointsProvider = Provider((ref) => NumbersEndPoints());

final Provider<NumberTriviaLocalDataSource>
    numberTriviaLocalDataSourceProvider = Provider(
  (ref) {
    return ref.watch(sharedPreferencesFutureProvider).maybeWhen(
          data: (sharedPrefences) =>
              SharedPreferencesNumberTriviaLocalDataSource(
            sharedPrefences,
          ),
          orElse: () => throw Exception(
            'Shared Preferences is not initialized',
          ),
        );
  },
);

final Provider<NumberTriviaRemoteDataSource>
    numberTriviaRemoteDataSourceProvider = Provider(
  (ref) {
    final headers = ref.watch(headersProvider);
    final numbersEndPoints = ref.watch(numbersEndPointsProvider);

    return HttpNumberTriviaRemoteDataSource(
      client: Client(),
      headers: headers,
      numbersEndPoints: numbersEndPoints,
    );
  },
);

final Provider<NumberTriviaRepository> numberTriviaRepositoryProvider =
    Provider(
  (ref) {
    final netWorkInfo = ref.watch(networkInfoProvider);
    final localDataSource = ref.watch(numberTriviaLocalDataSourceProvider);
    final remoteDataSource = ref.watch(numberTriviaRemoteDataSourceProvider);

    return NumberTriviaRepositoryData(
      netWorkInfo: netWorkInfo,
      localDataSource: localDataSource,
      remoteDataSource: remoteDataSource,
    );
  },
);

final Provider<GetSpecificNumberTrivia> getSpecificNumberTriviaProvider =
    Provider(
  (ref) {
    final numberTriviaRepository = ref.watch(numberTriviaRepositoryProvider);

    return GetSpecificNumberTrivia(numberTriviaRepository);
  },
);

final Provider<GetRandomNumberTrivia> getRandomNumberTriviaProvider = Provider(
  (ref) {
    final numberTriviaRepository = ref.watch(numberTriviaRepositoryProvider);

    return GetRandomNumberTrivia(numberTriviaRepository);
  },
);

final numberTriviaStateNotifierProvider = StateNotifierProvider.autoDispose(
  (ref) {
    final getSpecificTrivia = ref.watch(getSpecificNumberTriviaProvider);
    final getRandomTrivia = ref.watch(getRandomNumberTriviaProvider);
    final inputConverter = ref.watch(inputConverterProvider);
    return NumberTriviaStateNotifier(
      getRandomTriviaUseCase: getRandomTrivia,
      getSpecificTriviaUseCase: getSpecificTrivia,
      inputConverter: inputConverter,
    );
  },
);
