
import 'package:mycustomers/core/enums/connectivity_status.dart';

import '../stoppable_services.dart';

abstract class ConnectivityService implements StoppableService {
  Stream<ConnectivityStatus> get connectivity$;
  Future<bool> get isConnected;
  void registerListener(Function(ConnectivityStatus) callback);
  void registerAllListeners(List<Function(ConnectivityStatus)> callbacks);
}