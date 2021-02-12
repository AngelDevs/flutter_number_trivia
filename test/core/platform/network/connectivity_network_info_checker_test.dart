import 'package:connectivity/connectivity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia/core/platform/network/connectivity_network_info_checker.dart';
import 'package:number_trivia/core/platform/network/network_info_checker.dart';

class MockConnectivity extends Mock implements Connectivity {}

void main() {
  NetWorkInfoChecker networkInfoChecker;
  MockConnectivity mockConnectivity;

  setUp(() {
    mockConnectivity = MockConnectivity();
    networkInfoChecker = ConnectivityNetWorkInfoChecker(mockConnectivity);
  });

  group('device is connected', () {
    test('should return true when the device is connected to mobile network',
        () async {
      final connectivityResult = ConnectivityResult.mobile;
      // arrange
      when(mockConnectivity.checkConnectivity()).thenAnswer(
        (_) async => connectivityResult,
      );
      // act
      final result = await networkInfoChecker.isConnected;

      // assert
      verify(mockConnectivity.checkConnectivity());
      expect(result, true);
    });

    test(
      'should return true when the device is connected to wifi network',
      () async {
        final connectivityResult = ConnectivityResult.wifi;
        // arrange
        when(mockConnectivity.checkConnectivity()).thenAnswer(
          (_) async => connectivityResult,
        );
        // act
        final result = await networkInfoChecker.isConnected;

        // assert
        verify(mockConnectivity.checkConnectivity());
        expect(result, true);
      },
    );

    test('should return false when the device is not connected to any network',
        () async {
      final connectivityResult = ConnectivityResult.none;
      // arrange
      when(mockConnectivity.checkConnectivity()).thenAnswer(
        (_) async => connectivityResult,
      );
      // act
      final result = await networkInfoChecker.isConnected;

      // assert
      verify(mockConnectivity.checkConnectivity());
      expect(result, false);
    });
  });
}
