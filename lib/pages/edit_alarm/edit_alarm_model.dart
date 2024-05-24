import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'edit_alarm_widget.dart' show EditAlarmWidget;
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class EditAlarmModel extends FlutterFlowModel<EditAlarmWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  DateTime? datePicked;
  // State field(s) for lunesSwitch widget.
  bool? lunesSwitchValue;
  // State field(s) for martesSwitch widget.
  bool? martesSwitchValue;
  // State field(s) for miercolesSwitch widget.
  bool? miercolesSwitchValue;
  // State field(s) for juevesSwitch widget.
  bool? juevesSwitchValue;
  // State field(s) for viernesSwitch widget.
  bool? viernesSwitchValue;
  // State field(s) for sabadoSwitch widget.
  bool? sabadoSwitchValue;
  // State field(s) for domingoSwitch widget.
  bool? domingoSwitchValue;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
