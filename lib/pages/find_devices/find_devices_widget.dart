import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';

BluetoothDevice? connectedDevice;

class FindDevicesWidget extends StatefulWidget {
  const FindDevicesWidget({Key? key}) : super(key: key);

  @override
  State<FindDevicesWidget> createState() => _FindDevicesWidgetState();
}

class _FindDevicesWidgetState extends State<FindDevicesWidget> {
  final FlutterBluePlus flutterBlue = FlutterBluePlus();
  List<ScanResult> devices = [];
  BluetoothDevice? connectedDevice;

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
      print('Todos los permisos concedidos');
    } else {
      print('Permisos denegados');
      openAppSettings();
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
          //devices = results.where((result) => result.device.remoteId.toString() == "01:23:45:67:A9:8D").toList();
        });
        });
        print('Dispositivos encontrados:');
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
      connectedDevice = device;
      print('Conectado a ${device.platformName}');
    } catch (e) {
      print('Error al conectar: $e');
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
            size: 30.0,
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
              'Información',
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
          ElevatedButton(
            onPressed: startScanning,
            child: Text('Start Scanning'),
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
                      : 'Unnamed Device'),
                  subtitle: Text(
                    isConnected
                        ? '${device.device.remoteId} (Conectado)'
                        : device.device.remoteId.toString(),
                  ),
                  onTap: () => connectToDevice(device.device),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: FindDevicesWidget(),
  ));
}
