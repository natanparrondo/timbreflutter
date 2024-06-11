import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'item_alarm_model.dart';
export 'item_alarm_model.dart';

class ItemAlarmWidget extends StatefulWidget {
  const ItemAlarmWidget({
    super.key,
    this.name,
    this.time,
    String? days,
  }) : days = days ?? 'LMXJV';

  final String? name;
  final DateTime? time;
  final String days;

  @override
  State<ItemAlarmWidget> createState() => _ItemAlarmWidgetState();
}

class _ItemAlarmWidgetState extends State<ItemAlarmWidget> {
  late ItemAlarmModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ItemAlarmModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Align(
          alignment: const AlignmentDirectional(-1.0, 0.0),
          child: Text(
            widget.name!,
            style: FlutterFlowTheme.of(context).bodyMedium.override(
                  fontFamily: 'Readex Pro',
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        Align(
          alignment: const AlignmentDirectional(-1.0, 0.0),
          child: Text(
            valueOrDefault<String>(
              widget.time?.toString(),
              '09:40',
            ),
            style: FlutterFlowTheme.of(context).bodyMedium.override(
                  fontFamily: 'Readex Pro',
                  letterSpacing: 0.0,
                ),
          ),
        ),
        Expanded(
          child: Align(
            alignment: const AlignmentDirectional(-1.0, 0.0),
            child: Text(
              widget.days,
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: 'Readex Pro',
                    letterSpacing: 0.0,
                  ),
            ),
          ),
        ),
        FlutterFlowIconButton(
          borderColor: FlutterFlowTheme.of(context).primary,
          borderRadius: 4.0,
          borderWidth: 2.0,
          buttonSize: 40.0,
          icon: Icon(
            Icons.edit,
            color: FlutterFlowTheme.of(context).primaryText,
            size: 24.0,
          ),
          onPressed: () async {
            context.pushNamed(
              'editAlarm',
              queryParameters: {
                'alarmName': serializeParam(
                  widget.name,
                  ParamType.String,
                ),
                'alarmTime': serializeParam(
                  widget.time,
                  ParamType.DateTime,
                ),
                'alarmDays': serializeParam(
                  widget.days,
                  ParamType.String,
                ),
                'alarmId': serializeParam(
                  0,
                  ParamType.int,
                ),
              }.withoutNulls,
            );
          },
        ),
      ].divide(const SizedBox(width: 8.0)),
    );
  }
}
