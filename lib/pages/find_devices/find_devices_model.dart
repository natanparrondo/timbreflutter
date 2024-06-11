import '/flutter_flow/flutter_flow_util.dart';
import 'find_devices_widget.dart' show FindDevicesWidget;
import 'package:flutter/material.dart';

class FindDevicesModel extends FlutterFlowModel<FindDevicesWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}
