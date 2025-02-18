import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import '/flutter_flow/permissions_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'home_page_model.dart';
export 'home_page_model.dart';
import '../find_devices/find_devices_widget.dart';
import '/globals.dart'; // Import the globals file
import 'dart:convert';
import 'dart:async';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({
    Key? key,
    this.name,
    String? time,
    String? btStatus,
    this.btMac,
  })  : time = time ?? '09:40',
        btStatus = btStatus ?? 'Desconectado',
        super(key: key);
  final String? name;
  final String time;
  final String btStatus;
  final String? btMac;

  @override
  State<HomePageWidget> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  late HomePageModel _model;
  Timer? _timer;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String btStatus = 'No disponible / error';

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomePageModel());
    //_initBluetooth();
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await requestPermission(bluetoothPermission);
      updateStatus();
    });
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      updateStatus();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    updateStatus();
  }

  @override
  void dispose() {
    _model.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void updateStatus() {
    print('connectedDevice: $AppGlobals.connectedDevice');
    // Actualiza el estado según el valor de la variable global connectedDevice
    setState(() {
      if (AppGlobals.connectedDevice != null) {
        btStatus = 'Conectado a "${AppGlobals.connectedDevice!.platformName}"';
      } else {
        btStatus = 'Desconectado';
      }
    });
    print('btStatus: $btStatus');
  }

void sendDataToBluetoothTime(String message) async {

  try {
    List<int> data = utf8.encode(message);
    await AppGlobals.characteristic!.write(data);
    print("Data sent successfully!");
  } catch (error) {
    print("Error sending data: $error");
  }
}

void sendDataToBluetooth(String message) async {
  try {
    List<String> chunks = [];
    int chunkSize = 11;

    // Split the message into chunks of 11 characters
    for (int i = 0; i < message.length; i += chunkSize) {
      chunks.add(message.substring(i, i + chunkSize > message.length ? message.length : i + chunkSize));
    }

    // Function to send each chunk
    Future<void> sendChunk(int index) async {
      if (index < chunks.length) {
        try {
          List<int> data = utf8.encode(chunks[index]);
          await AppGlobals.characteristic!.write(data);
          print("Chunk ${index + 1}/${chunks.length} sent successfully: ${chunks[index]}");
        } catch (error) {
          print("Error sending chunk $index: $error");
        }
      }
    }

    // Send chunks sequentially with a delay between each
    for (int i = 0; i < chunks.length; i++) {
      await sendChunk(i);
      await Future.delayed(Duration(milliseconds: 200)); // Adjust delay as needed
    }

    print("Data sent successfully!");
  } catch (error) {
    print("Error sending data: $error");
  }
}

  @override
  Widget build(BuildContext context) {
    updateStatus();
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            context.pushNamed(
              'editAlarm',
              queryParameters: {
                'alarmName': serializeParam(
                  'Nueva Alarma',
                  ParamType.String,
                ),
                'alarmTime': serializeParam(
                  getCurrentTimestamp,
                  ParamType.DateTime,
                ),
                'alarmDays': serializeParam(
                  '',
                  ParamType.String,
                ),
                'alarmId': serializeParam(
                  FFAppState().idAlarmas.length,
                  ParamType.int,
                ),
                'isNew': serializeParam(
                  true,
                  ParamType.bool,
                ),
              }.withoutNulls,
            );
          },
          backgroundColor: FlutterFlowTheme.of(context).primary,
          elevation: 6.0,
          child: Icon(
            Icons.more_time,
            color: FlutterFlowTheme.of(context).info,
            size: 24.0,
          ),
        ),
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primary,
          automaticallyImplyLeading: false,
          title: Align(
            alignment: const AlignmentDirectional(0.0, 0.0),
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(56.0, 0.0, 0.0, 0.0),
              child: Text(
                'Timbre',
                style: FlutterFlowTheme.of(context).headlineMedium.override(
                      fontFamily: 'Outfit',
                      color: Colors.white,
                      fontSize: 22.0,
                      letterSpacing: 0.0,
                    ),
              ),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 16.0, 0.0),
              child: FlutterFlowIconButton(
                borderColor: FlutterFlowTheme.of(context).primary,
                borderRadius: 20.0,
                borderWidth: 1.0,
                buttonSize: 40.0,
                fillColor: FlutterFlowTheme.of(context).accent1,
                icon: const Icon(
                  Icons.info_outline,
                  color: Colors.white,
                  size: 24.0,
                ),
                onPressed: () async {
                  context.pushNamed('info');
                },
              ),
            ),
          ],
          centerTitle: false,
          elevation: 2.0,
        ),
        body: SafeArea(
          top: true,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 16.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 8.0, 0.0),
                        child: Icon(
                          Icons.bluetooth_audio,
                          color: FlutterFlowTheme.of(context).primaryText,
                          size: 32.0,
                        ),
                      ),
                      Text(
                        'Estado: ',
                        style: FlutterFlowTheme.of(context).labelLarge.override(
                              fontFamily: 'Readex Pro',
                              color: FlutterFlowTheme.of(context).primary,
                              letterSpacing: 0.0,
                            ),
                      ),
                      Text(
                        btStatus,
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Readex Pro',
                              color: FlutterFlowTheme.of(context).primaryText,
                              letterSpacing: 0.0,
                            ),
                      ),
                      Flexible(
                        child: Align(
                          alignment: const AlignmentDirectional(1.0, 0.0),
                          child: FlutterFlowIconButton(
                            borderRadius: 4.0,
                            borderWidth: 2.0,
                            buttonSize: 40.0,
                            icon: Icon(
                              Icons.settings,
                              color: FlutterFlowTheme.of(context).primaryText,
                              size: 24.0,
                            ),
                            onPressed: () async {
                              context.pushNamed('findDevices');
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 16.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: FFButtonWidget(
onPressed: () async {
  final currentDate = DateTime.now();
  
  // Mostrar DatePicker
  final datePicked = await showDatePicker(
    context: context,
    initialDate: currentDate,
    firstDate: DateTime(2000),
    lastDate: DateTime(2100),
    builder: (context, child) {
      return Theme(
        data: ThemeData.light().copyWith(
          primaryColor: FlutterFlowTheme.of(context).primary,
          colorScheme: ColorScheme.light(primary: FlutterFlowTheme.of(context).primary),
          buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
        ),
        child: child!,
      );
    },
  );

  if (datePicked != null) {
    // Mostrar TimePicker
    final timePicked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(currentDate),
      builder: (context, child) {
        return wrapInMaterialTimePickerTheme(
          context,
          child!,
          headerBackgroundColor: FlutterFlowTheme.of(context).primary,
          headerForegroundColor: FlutterFlowTheme.of(context).info,
          headerTextStyle: FlutterFlowTheme.of(context)
              .headlineLarge
              .override(
                fontFamily: 'Outfit',
                fontSize: 32.0,
                letterSpacing: 0.0,
                fontWeight: FontWeight.w600,
              ),
          pickerBackgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
          pickerForegroundColor: FlutterFlowTheme.of(context).primaryText,
          selectedDateTimeBackgroundColor: FlutterFlowTheme.of(context).primary,
          selectedDateTimeForegroundColor: FlutterFlowTheme.of(context).info,
          actionButtonForegroundColor: FlutterFlowTheme.of(context).primaryText,
          iconSize: 24.0,
        );
      },
    );

    if (timePicked != null) {
      String formattedDate = '${datePicked.day.toString().padLeft(2, '0')}${datePicked.month.toString().padLeft(2, '0')}${datePicked.year.toString().substring(2)}';
      String formattedTime = '${timePicked.hour.toString().padLeft(2, '0')}${timePicked.minute.toString().padLeft(2, '0')}';
      String formattedDateTime = '$formattedDate$formattedTime';
      sendDataToBluetooth("c$formattedDateTime  ");

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Enviado update tiempo $formattedDateTime',
            style: TextStyle(
              color: FlutterFlowTheme.of(context).primaryText,
            ),
          ),
          duration: const Duration(milliseconds: 4000),
          backgroundColor: FlutterFlowTheme.of(context).secondary,
        ),
      );
      print(formattedDateTime);
      HapticFeedback.lightImpact();
    }
  }
},
  text: 'Tiempo',
  icon: const Icon(
    Icons.schedule,
    size: 15.0,
  ),
  options: FFButtonOptions(
    height: 40.0,
    padding: const EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
    iconPadding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
    color: FlutterFlowTheme.of(context).primary,
    textStyle: FlutterFlowTheme.of(context)
        .labelMedium
        .override(
          fontFamily: 'Readex Pro',
          color: Colors.white,
          letterSpacing: 0.0,
        ),
    elevation: 3.0,
    borderSide: const BorderSide(
      color: Colors.transparent,
      width: 1.0,
    ),
    borderRadius: BorderRadius.circular(8.0),
  ),
),

                      ),
                      Expanded(
                        child: FFButtonWidget(
                          onPressed: () async {
                            sendDataToBluetooth(
                              valueOrDefault<String>(
                              functions.generarString(
                                  FFAppState().nombresAlarmas.length,
                                  FFAppState().horasAlarmas.toList(),
                                  FFAppState().diasAlarmas.toList()),
                              'No hay Alarmas',
                              )
                            ); //ARREGLAR PORFAVOR NATAN ARREGLAR - ARREGLADO
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Enviado',
                                  style: TextStyle(
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                  ),
                                ),
                                duration: const Duration(milliseconds: 4000),
                                backgroundColor:
                                    FlutterFlowTheme.of(context).secondary,
                              ),
                            );
                            HapticFeedback.lightImpact();
                          },
                          text: 'Enviar',
                          icon: const Icon(
                            Icons.send_rounded,
                            size: 15.0,
                          ),
                          options: FFButtonOptions(
                            height: 40.0,
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                24.0, 0.0, 24.0, 0.0),
                            iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color: FlutterFlowTheme.of(context).secondary,
                            textStyle: FlutterFlowTheme.of(context)
                                .labelMedium
                                .override(
                                  fontFamily: 'Readex Pro',
                                  color: Colors.white,
                                  letterSpacing: 0.0,
                                ),
                            elevation: 3.0,
                            borderSide: const BorderSide(
                              color: Colors.transparent,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                      Expanded(
                        child: FFButtonWidget(
                          onPressed: () async {
                            var confirmDialogResponse = await showDialog<bool>(
                                  context: context,
                                  builder: (alertDialogContext) {
                                    return AlertDialog(
                                      title: const Text('Reset'),
                                      content: const Text(
                                          '¿Resetear memoria de alarmas en dispositivo vinculado?'),
                                      actions: [
                                        TextButton(
                                          onPressed: () => Navigator.pop(
                                              alertDialogContext, false),
                                          child: const Text('CANCELAR'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                          sendDataToBluetooth("BORRAR;");
                                          Navigator.pop(alertDialogContext);
                                          },
                                          style: TextButton.styleFrom(
                                            foregroundColor: Colors.red, // Set the text color to red
                                          ),
                                          child: const Text('COMFIRMAR'),
                                        ),
                                      ],
                                    );
                                  },
                                ) ??
                                false;
                            if (confirmDialogResponse){
                              HapticFeedback.heavyImpact();
                              // if alert dialog 
                              sendDataToBluetooth("RESET;");
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Enviando señal reset',
                                    style: TextStyle(
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                    ),
                                  ),
                                  duration: const Duration(milliseconds: 4000),
                                  backgroundColor:
                                      FlutterFlowTheme.of(context).error,
                                ),
                              );
                            }
                          },
                          text: 'Reset',
                          icon: const Icon(
                            Icons.restart_alt,
                            size: 15.0,
                          ),
                          options: FFButtonOptions(
                            height: 40.0,
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                24.0, 0.0, 24.0, 0.0),
                            iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color: FlutterFlowTheme.of(context).error,
                            textStyle: FlutterFlowTheme.of(context)
                                .labelMedium
                                .override(
                                  fontFamily: 'Readex Pro',
                                  color: Colors.white,
                                  letterSpacing: 0.0,
                                ),
                            elevation: 3.0,
                            borderSide: const BorderSide(
                              color: Colors.transparent,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                    ].divide(const SizedBox(width: 4.0)),
                  ),
                ),
                Builder(
                  builder: (context) {
                    final nombre = FFAppState().nombresAlarmas.toList();
                    return ListView.separated(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: nombre.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 4.0),
                      itemBuilder: (context, nombreIndex) {
                        final nombreItem = nombre[nombreIndex];
                        return Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 4.0, 0.0, 4.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Align(
                                alignment: const AlignmentDirectional(-1.0, 0.0),
                                child: Text(
                                  FFAppState().nombresAlarmas[nombreIndex],
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ),
                              Align(
                                alignment: const AlignmentDirectional(-1.0, 0.0),
                                child: Text(
                                  dateTimeFormat('Hm',
                                      FFAppState().horasAlarmas[nombreIndex]),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        letterSpacing: 0.0,
                                      ),
                                ),
                              ),
                              Expanded(
                                child: Align(
                                  alignment: const AlignmentDirectional(-1.0, 0.0),
                                  child: Text(
                                    FFAppState().diasAlarmas[nombreIndex],
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Readex Pro',
                                          letterSpacing: 0.0,
                                        ),
                                  ),
                                ),
                              ),
                              Opacity(
                                opacity: 0.3,
                                child: Align(
                                  alignment: const AlignmentDirectional(1.0, 0.0),
                                  child: Text(
                                    FFAppState()
                                        .idAlarmas[nombreIndex]
                                        .toString(),
                                    textAlign: TextAlign.end,
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Readex Pro',
                                          letterSpacing: 0.0,
                                        ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Align(
                                  alignment: const AlignmentDirectional(1.0, 0.0),
                                  child: FlutterFlowIconButton(
                                    borderRadius: 4.0,
                                    borderWidth: 2.0,
                                    buttonSize: 40.0,
                                    icon: Icon(
                                      Icons.delete,
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      size: 24.0,
                                    ),
                                    onPressed: () async {
                                      setState(() {
                                        FFAppState()
                                            .removeAtIndexFromNombresAlarmas(
                                                nombreIndex);
                                        FFAppState()
                                            .removeAtIndexFromHorasAlarmas(
                                                nombreIndex);
                                        FFAppState()
                                            .removeAtIndexFromDiasAlarmas(
                                                nombreIndex);
                                        FFAppState().removeAtIndexFromIdAlarmas(
                                            nombreIndex);
                                      });
                                    },
                                  ),
                                ),
                              ),
                              Align(
                                alignment: const AlignmentDirectional(1.0, 0.0),
                                child: FlutterFlowIconButton(
                                  borderRadius: 4.0,
                                  borderWidth: 2.0,
                                  buttonSize: 40.0,
                                  icon: Icon(
                                    Icons.edit,
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    size: 24.0,
                                  ),
                                  onPressed: () async {
                                    context.pushNamed(
                                      'editAlarm',
                                      queryParameters: {
                                        'alarmName': serializeParam(
                                          FFAppState()
                                              .nombresAlarmas[nombreIndex],
                                          ParamType.String,
                                        ),
                                        'alarmTime': serializeParam(
                                          FFAppState()
                                              .horasAlarmas[nombreIndex],
                                          ParamType.DateTime,
                                        ),
                                        'alarmDays': serializeParam(
                                          FFAppState().diasAlarmas[nombreIndex],
                                          ParamType.String,
                                        ),
                                        'alarmId': serializeParam(
                                          nombreIndex,
                                          ParamType.int,
                                        ),
                                      }.withoutNulls,
                                    );
                                  },
                                ),
                              ),
                            ].divide(const SizedBox(width: 4.0)),
                          ),
                        );
                      },
                    );
                  },
                ),
                Divider(
                  thickness: 1.0,
                  color: FlutterFlowTheme.of(context).accent4,
                ),
                // Text(
                //   'String to be sent:',
                //   style: FlutterFlowTheme.of(context).bodyMedium.override(
                //         fontFamily: 'Readex Pro',
                //         letterSpacing: 0.0,
                //       ),
                // ),
                //Text(
                //  '${device.remoteId}',
                //),
                SelectionArea(
                    child: Text(
                  valueOrDefault<String>(
                    functions.generarString(
                        FFAppState().nombresAlarmas.length,
                        FFAppState().horasAlarmas.toList(),
                        FFAppState().diasAlarmas.toList()),
                    'No hay Alarmas',
                  ).maybeHandleOverflow(maxChars: 62),
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Readex Pro',
                        letterSpacing: 0.0,
                      ),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
