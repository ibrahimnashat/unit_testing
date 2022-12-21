import 'package:connectivity_checker/connectivity_checker.dart';
import 'package:injectable/injectable.dart';

abstract class Network {
  Future<bool> get isConnected;
}

@Injectable(as: Network)
class NetworkStatus extends Network {
  final ConnectivityWrapper connectivityWrapper;
  NetworkStatus({required this.connectivityWrapper});
  @override
  Future<bool> get isConnected => connectivityWrapper.isConnected;
}
