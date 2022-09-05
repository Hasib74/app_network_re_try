//
//
//
// abstract class AppNetworkInfo {
//   Future<bool> get isConnected;
// }
//
// class NetworkInfoImpl implements AppNetworkInfo {
//   final Connectivity connectionChecker;
//
//   NetworkInfoImpl(this.connectionChecker);
//
//   @override
//   Future<bool> get isConnected =>
//       connectionChecker.checkConnectivity().then((value) {
//         return  value == ConnectivityResult.mobile ||
//             value == ConnectivityResult.wifi
//             ? true
//             : false;
//       });
// }
