// bluetooth_status_notifier.dart
import 'package:flutter/foundation.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart'; // Import if using flutter_blue_plus

class BluetoothStatusNotifier extends ChangeNotifier {
  String _btStatus = 'Desconectado';

  String get btStatus => _btStatus;

  void updateStatus(BluetoothDevice? connectedDevice) {
    if (connectedDevice != null) {
      _btStatus = 'Conectado ${connectedDevice.remoteId}';
    } else {
      _btStatus = 'Desconectado';
    }
    notifyListeners();
  }
}
