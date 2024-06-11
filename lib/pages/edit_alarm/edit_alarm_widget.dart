import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'edit_alarm_model.dart';
export 'edit_alarm_model.dart';

class EditAlarmWidget extends StatefulWidget {
  const EditAlarmWidget({
    super.key,
    required this.alarmName,
    required this.alarmTime,
    String? alarmDays,
    required this.alarmId,
    bool? isNew,
  })  : alarmDays = alarmDays ?? '',
        isNew = isNew ?? false;

  final String? alarmName;
  final DateTime? alarmTime;
  final String alarmDays;
  final int? alarmId;
  final bool isNew;

  @override
  State<EditAlarmWidget> createState() => _EditAlarmWidgetState();
}

class _EditAlarmWidgetState extends State<EditAlarmWidget> {
  late EditAlarmModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EditAlarmModel());

    _model.textController ??= TextEditingController(text: widget.alarmName);
    _model.textFieldFocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primary,
          automaticallyImplyLeading: false,
          title: Align(
            alignment: const AlignmentDirectional(0.0, 0.0),
            child: Text(
              'Editar alarma',
              style: FlutterFlowTheme.of(context).headlineMedium.override(
                    fontFamily: 'Outfit',
                    color: Colors.white,
                    fontSize: 22.0,
                    letterSpacing: 0.0,
                  ),
            ),
          ),
          actions: const [],
          centerTitle: false,
          elevation: 2.0,
        ),
        body: SafeArea(
          top: true,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  TextFormField(
                    controller: _model.textController,
                    focusNode: _model.textFieldFocusNode,
                    onChanged: (_) => EasyDebounce.debounce(
                      '_model.textController',
                      const Duration(milliseconds: 2000),
                      () => setState(() {}),
                    ),
                    autofocus: true,
                    obscureText: false,
                    decoration: InputDecoration(
                      labelText: 'Nombre',
                      labelStyle:
                          FlutterFlowTheme.of(context).labelMedium.override(
                                fontFamily: 'Readex Pro',
                                letterSpacing: 0.0,
                              ),
                      hintStyle:
                          FlutterFlowTheme.of(context).labelMedium.override(
                                fontFamily: 'Readex Pro',
                                letterSpacing: 0.0,
                              ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).alternate,
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).primary,
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).error,
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).error,
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      suffixIcon: _model.textController!.text.isNotEmpty
                          ? InkWell(
                              onTap: () async {
                                _model.textController?.clear();
                                setState(() {});
                              },
                              child: const Icon(
                                Icons.clear,
                                size: 22,
                              ),
                            )
                          : null,
                    ),
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Readex Pro',
                          letterSpacing: 0.0,
                        ),
                    maxLength: 32,
                    maxLengthEnforcement: MaxLengthEnforcement.none,
                    buildCounter: (context,
                            {required currentLength,
                            required isFocused,
                            maxLength}) =>
                        null,
                    validator:
                        _model.textControllerValidator.asValidator(context),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(-1.0, 0.0),
                    child: FFButtonWidget(
                      onPressed: () async {
                        final datePickedTime = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.fromDateTime(
                              (widget.alarmTime ?? DateTime.now())),
                          builder: (context, child) {
                            return wrapInMaterialTimePickerTheme(
                              context,
                              child!,
                              headerBackgroundColor:
                                  FlutterFlowTheme.of(context).primary,
                              headerForegroundColor:
                                  FlutterFlowTheme.of(context).info,
                              headerTextStyle: FlutterFlowTheme.of(context)
                                  .headlineLarge
                                  .override(
                                    fontFamily: 'Outfit',
                                    fontSize: 32.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                              pickerBackgroundColor:
                                  FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                              pickerForegroundColor:
                                  FlutterFlowTheme.of(context).primaryText,
                              selectedDateTimeBackgroundColor:
                                  FlutterFlowTheme.of(context).primary,
                              selectedDateTimeForegroundColor:
                                  FlutterFlowTheme.of(context).info,
                              actionButtonForegroundColor:
                                  FlutterFlowTheme.of(context).primaryText,
                              iconSize: 24.0,
                            );
                          },
                        );
                        if (datePickedTime != null) {
                          safeSetState(() {
                            _model.datePicked = DateTime(
                              (widget.alarmTime ?? DateTime.now()).year,
                              (widget.alarmTime ?? DateTime.now()).month,
                              (widget.alarmTime ?? DateTime.now()).day,
                              datePickedTime.hour,
                              datePickedTime.minute,
                            );
                          });
                        }
                      },
                      text: valueOrDefault<String>(
                        dateTimeFormat('Hm', _model.datePicked),
                        'Seleccionar Hora',
                      ),
                      icon: Icon(
                        Icons.alarm,
                        color: FlutterFlowTheme.of(context).primaryText,
                        size: 18.0,
                      ),
                      options: FFButtonOptions(
                        width: double.infinity,
                        height: 40.0,
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            24.0, 0.0, 24.0, 0.0),
                        iconPadding:
                            const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        color: FlutterFlowTheme.of(context).primaryBackground,
                        textStyle:
                            FlutterFlowTheme.of(context).bodyMedium.override(
                                  fontFamily: 'Readex Pro',
                                  letterSpacing: 0.0,
                                ),
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).primary,
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                  Text(
                    'alarmId ',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Readex Pro',
                          letterSpacing: 0.0,
                        ),
                  ),
                  Text(
                    valueOrDefault<String>(
                      widget.alarmId?.toString(),
                      '-',
                    ),
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Readex Pro',
                          letterSpacing: 0.0,
                        ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SwitchListTile.adaptive(
                        value: _model.lunesSwitchValue ??= (String var1) {
                          return var1.contains('L');
                        }(widget.alarmDays),
                        onChanged: (newValue) async {
                          setState(() => _model.lunesSwitchValue = newValue);
                        },
                        title: Text(
                          'Lunes',
                          style: FlutterFlowTheme.of(context)
                              .labelMedium
                              .override(
                                fontFamily: 'Readex Pro',
                                color: FlutterFlowTheme.of(context).primaryText,
                                letterSpacing: 0.0,
                              ),
                        ),
                        tileColor:
                            FlutterFlowTheme.of(context).secondaryBackground,
                        activeColor: FlutterFlowTheme.of(context).accent1,
                        activeTrackColor: FlutterFlowTheme.of(context).primary,
                        dense: false,
                        controlAffinity: ListTileControlAffinity.trailing,
                      ),
                      SwitchListTile.adaptive(
                        value: _model.martesSwitchValue ??= (String var1) {
                          return var1.contains('M');
                        }(widget.alarmDays),
                        onChanged: (newValue) async {
                          setState(() => _model.martesSwitchValue = newValue);
                        },
                        title: Text(
                          'Martes',
                          style: FlutterFlowTheme.of(context)
                              .labelMedium
                              .override(
                                fontFamily: 'Readex Pro',
                                color: FlutterFlowTheme.of(context).primaryText,
                                letterSpacing: 0.0,
                              ),
                        ),
                        tileColor:
                            FlutterFlowTheme.of(context).secondaryBackground,
                        activeColor: FlutterFlowTheme.of(context).accent1,
                        activeTrackColor: FlutterFlowTheme.of(context).primary,
                        dense: false,
                        controlAffinity: ListTileControlAffinity.trailing,
                      ),
                      SwitchListTile.adaptive(
                        value: _model.miercolesSwitchValue ??= (String var1) {
                          return var1.contains('X');
                        }(widget.alarmDays),
                        onChanged: (newValue) async {
                          setState(
                              () => _model.miercolesSwitchValue = newValue);
                        },
                        title: Text(
                          'Miércoles',
                          style: FlutterFlowTheme.of(context)
                              .labelMedium
                              .override(
                                fontFamily: 'Readex Pro',
                                color: FlutterFlowTheme.of(context).primaryText,
                                letterSpacing: 0.0,
                              ),
                        ),
                        tileColor:
                            FlutterFlowTheme.of(context).secondaryBackground,
                        activeColor: FlutterFlowTheme.of(context).accent1,
                        activeTrackColor: FlutterFlowTheme.of(context).primary,
                        dense: false,
                        controlAffinity: ListTileControlAffinity.trailing,
                      ),
                      SwitchListTile.adaptive(
                        value: _model.juevesSwitchValue ??= (String var1) {
                          return var1.contains('J');
                        }(widget.alarmDays),
                        onChanged: (newValue) async {
                          setState(() => _model.juevesSwitchValue = newValue);
                        },
                        title: Text(
                          'Jueves',
                          style: FlutterFlowTheme.of(context)
                              .labelMedium
                              .override(
                                fontFamily: 'Readex Pro',
                                color: FlutterFlowTheme.of(context).primaryText,
                                letterSpacing: 0.0,
                              ),
                        ),
                        tileColor:
                            FlutterFlowTheme.of(context).secondaryBackground,
                        activeColor: FlutterFlowTheme.of(context).accent1,
                        activeTrackColor: FlutterFlowTheme.of(context).primary,
                        dense: false,
                        controlAffinity: ListTileControlAffinity.trailing,
                      ),
                      SwitchListTile.adaptive(
                        value: _model.viernesSwitchValue ??= (String var1) {
                          return var1.contains('V');
                        }(widget.alarmDays),
                        onChanged: (newValue) async {
                          setState(() => _model.viernesSwitchValue = newValue);
                        },
                        title: Text(
                          'Viernes',
                          style: FlutterFlowTheme.of(context)
                              .labelMedium
                              .override(
                                fontFamily: 'Readex Pro',
                                color: FlutterFlowTheme.of(context).primaryText,
                                letterSpacing: 0.0,
                              ),
                        ),
                        tileColor:
                            FlutterFlowTheme.of(context).secondaryBackground,
                        activeColor: FlutterFlowTheme.of(context).accent1,
                        activeTrackColor: FlutterFlowTheme.of(context).primary,
                        dense: false,
                        controlAffinity: ListTileControlAffinity.trailing,
                      ),
                      SwitchListTile.adaptive(
                        value: _model.sabadoSwitchValue ??= (String var1) {
                          return var1.contains('S');
                        }(widget.alarmDays),
                        onChanged: (newValue) async {
                          setState(() => _model.sabadoSwitchValue = newValue);
                        },
                        title: Text(
                          'Sabado de flojera',
                          style: FlutterFlowTheme.of(context)
                              .labelMedium
                              .override(
                                fontFamily: 'Readex Pro',
                                color: FlutterFlowTheme.of(context).primaryText,
                                letterSpacing: 0.0,
                              ),
                        ),
                        tileColor:
                            FlutterFlowTheme.of(context).secondaryBackground,
                        activeColor: FlutterFlowTheme.of(context).accent1,
                        activeTrackColor: FlutterFlowTheme.of(context).primary,
                        dense: false,
                        controlAffinity: ListTileControlAffinity.trailing,
                      ),
                      SwitchListTile.adaptive(
                        value: _model.domingoSwitchValue ??= (String var1) {
                          return var1.contains('D');
                        }(widget.alarmDays),
                        onChanged: (newValue) async {
                          setState(() => _model.domingoSwitchValue = newValue);
                        },
                        title: Text(
                          'Domingo',
                          style: FlutterFlowTheme.of(context)
                              .labelMedium
                              .override(
                                fontFamily: 'Readex Pro',
                                color: FlutterFlowTheme.of(context).primaryText,
                                letterSpacing: 0.0,
                              ),
                        ),
                        tileColor:
                            FlutterFlowTheme.of(context).secondaryBackground,
                        activeColor: FlutterFlowTheme.of(context).accent1,
                        activeTrackColor: FlutterFlowTheme.of(context).primary,
                        dense: false,
                        controlAffinity: ListTileControlAffinity.trailing,
                      ),
                    ].divide(const SizedBox(height: 1.0)),
                  ),
                  FFButtonWidget(
                    onPressed: () async {
                      context.safePop();
                      setState(() {
                        FFAppState()
                            .addToNombresAlarmas(_model.textController.text);
                        FFAppState().addToHorasAlarmas(widget.alarmTime!);
                        FFAppState().addToDiasAlarmas(valueOrDefault<String>(
                          '${_model.lunesSwitchValue! ? 'L' : '-'}${_model.martesSwitchValue! ? 'M' : '-'}${_model.miercolesSwitchValue! ? 'X' : '-'}${_model.juevesSwitchValue! ? 'J' : '-'}${_model.viernesSwitchValue! ? 'V' : '-'}${_model.sabadoSwitchValue! ? 'S' : '-'}${_model.domingoSwitchValue! ? 'D' : '-'}',
                          'LVJ',
                        ));
                        FFAppState().addToIdAlarmas(widget.alarmId!);
                      });
                    },
                    text: 'Guardar',
                    icon: const Icon(
                      Icons.done,
                      size: 18.0,
                    ),
                    options: FFButtonOptions(
                      width: double.infinity,
                      height: 40.0,
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                      iconPadding:
                          const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      color: FlutterFlowTheme.of(context).primary,
                      textStyle:
                          FlutterFlowTheme.of(context).bodyMedium.override(
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
                ].divide(const SizedBox(height: 8.0)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
