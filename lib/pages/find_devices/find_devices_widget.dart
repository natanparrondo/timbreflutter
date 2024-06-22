import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/globals.dart'; // Import the globals file
import 'dart:convert';

class FindDevicesWidget extends StatefulWidget {
  const FindDevicesWidget({Key? key}) : super(key: key);

  @override
  State<FindDevicesWidget> createState() => _FindDevicesWidgetState();
}

class _FindDevicesWidgetState extends State<FindDevicesWidget> {
  final FlutterBluePlus flutterBlue = FlutterBluePlus();
  List<ScanResult> devices = [];
  BluetoothDevice? connectedDevice;
  BluetoothCharacteristic? characteristic;

  static const String serviceUUID = "0000ffe0-0000-1000-8000-00805f9b34fb";
  static const String characteristicUUID = "0000ffe1-0000-1000-8000-00805f9b34fb";

  @override
  void initState() {
    super.initState();
    checkPermissions();
  }

  Future<void> checkPermissions() async {
    final locationStatus = await Permission.location.request();
    final bluetoothScanStatus = await Permission.bluetoothScan.request();
    final bluetoothConnectStatus = await Permission.bluetoothConnect.request();

    if (locationStatus.isGranted &&
        bluetoothScanStatus.isGranted &&
        bluetoothConnectStatus.isGranted) {
      print('All permissions granted');
    } else {
      print('Permissions denied');
    }
  }

  void startScanning() {
    try {
      FlutterBluePlus.startScan(timeout: const Duration(seconds: 5)).catchError((e) {
        print('Error starting scan: $e');
      });
      FlutterBluePlus.scanResults.listen((results) {
        setState(() {
          devices = results;
        });
        print('Devices found:');
        for (var device in devices) {
          print('${device.device.name} (${device.device.remoteId})');
        }
      }).onError((error) {
        print('Error receiving scan results: $error');
      });
    } catch (e) {
      print('Error: $e');
    }
  }

Future<void> connectToDevice(BluetoothDevice device) async {
  try {
    await device.connect();
    setState(() {
      connectedDevice = device;
    });
    print('Connected to ${device.remoteId}');

    // Discover services and characteristics
    List<BluetoothService> services = await device.discoverServices();
    services.forEach((service) {
      if (service.uuid.toString() == serviceUUID) {
        service.characteristics.forEach((characteristic) {
          if (characteristic.uuid.toString() == characteristicUUID) {
            this.characteristic = characteristic;
          }
        });
      }
    });
  } catch (e) {
    print('Error connecting: $e');
  }
}


  void sendDataToBluetooth() async {
      try {
        List<int> data = utf8.encode("r");
        await characteristic!.write(data);
        print("Data sent successfully!");
      } catch (error) {
        print("Error sending data: $error");
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).primary,
        automaticallyImplyLeading: false,
        leading: FlutterFlowIconButton(
          borderColor: Colors.transparent,
          borderRadius: 30.0,
          borderWidth: 1.0,
          buttonSize: 60.0,
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
            size: 20.0,
          ),
          onPressed: () async {
            Navigator.of(context).pop();
          },
        ),
        title: Align(
          alignment: const AlignmentDirectional(0.0, 0.0),
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 56.0, 0.0),
            child: Text(
              'Vincular modulo',
              style: FlutterFlowTheme.of(context).headlineMedium.override(
                    fontFamily: 'Outfit',
                    color: Colors.white,
                    fontSize: 22.0,
                    letterSpacing: 0.0,
                  ),
            ),
          ),
        ),
        actions: const [],
        centerTitle: true,
        elevation: 2.0,
      ),
      body: Column(
        children: [
          Container(
            height: 24,
          ),
          ElevatedButton.icon(
            onPressed: startScanning,
            icon: const Icon(
              Icons.search,
              size: 15.0,
            ),
            label: const Text('Scan Devices'),
            style: ElevatedButton.styleFrom(
              backgroundColor: FlutterFlowTheme.of(context).primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 16.0),
              textStyle: FlutterFlowTheme.of(context).labelMedium.override(
                fontFamily: 'Readex Pro',
                color: Colors.white,
                letterSpacing: 0.0,
              ),
              elevation: 3.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
          Container(
            height: 12,
          ),
          Text(
            'Nearby compatible BLE devices are shown',
            style: FlutterFlowTheme.of(context).labelMedium.override(
              fontFamily: 'Outfit',
              letterSpacing: 0.0,
            ),
          ),
          Container(
            height: 24,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: devices.length,
              itemBuilder: (context, index) {
                final device = devices[index];
                bool isConnected = connectedDevice != null && connectedDevice!.remoteId == device.device.remoteId;
                return ListTile(
                  title: Text(device.device.platformName.isNotEmpty
                      ? device.device.platformName
                      : 'Unknown Device'),
                  subtitle: Text(
                    isConnected
                        ? '${device.device.remoteId} (Connected)'
                        : device.device.remoteId.toString(),
                  ),
                  onTap: () => connectToDevice(device.device),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => sendDataToBluetooth(),
        child: const Icon(Icons.send),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: FindDevicesWidget(),
  ));
}
