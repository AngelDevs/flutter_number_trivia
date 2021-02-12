import 'package:connectivity/connectivity.dart';

abstract class NetWorkInfoChecker {
  Future<bool> get isConnected;
}

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
