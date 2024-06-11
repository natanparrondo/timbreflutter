import '/flutter_flow/flutter_flow_util.dart';
import 'info_widget.dart' show InfoWidget;
import 'package:flutter/material.dart';

class InfoModel extends FlutterFlowModel<InfoWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}
