import 'package:connectivity/connectivity.dart';
import 'package:number_trivia/core/platform/network/network_info_checker.dart';

class ConnectivityNetWorkInfoChecker extends NetWorkInfoChecker {
  ConnectivityNetWorkInfoChecker(
    this.networkInfoManager,
  );

  final Connectivity networkInfoManager;

  @override
  Future<bool> get isConnected => _checkConnectivity();

  Future<bool> _checkConnectivity() async {
    final connectivityResult = await networkInfoManager.checkConnectivity();
    final hasConnection = _checkHasConnection(connectivityResult);
    return hasConnection;
  }

  bool _checkHasConnection(ConnectivityResult connectivityResult) {
    return connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi;
  }
}
