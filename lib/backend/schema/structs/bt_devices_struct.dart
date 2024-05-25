// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class BtDevicesStruct extends BaseStruct {
  BtDevicesStruct({
    List<String>? btAddress,
    List<String>? btName,
  })  : _btAddress = btAddress,
        _btName = btName;

  // "btAddress" field.
  List<String>? _btAddress;
  List<String> get btAddress => _btAddress ?? const [];
  set btAddress(List<String>? val) => _btAddress = val;
  void updateBtAddress(Function(List<String>) updateFn) =>
      updateFn(_btAddress ??= []);
  bool hasBtAddress() => _btAddress != null;

  // "btName" field.
  List<String>? _btName;
  List<String> get btName => _btName ?? const [];
  set btName(List<String>? val) => _btName = val;
  void updateBtName(Function(List<String>) updateFn) =>
      updateFn(_btName ??= []);
  bool hasBtName() => _btName != null;

  static BtDevicesStruct fromMap(Map<String, dynamic> data) => BtDevicesStruct(
        btAddress: getDataList(data['btAddress']),
        btName: getDataList(data['btName']),
      );

  static BtDevicesStruct? maybeFromMap(dynamic data) => data is Map
      ? BtDevicesStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'btAddress': _btAddress,
        'btName': _btName,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'btAddress': serializeParam(
          _btAddress,
          ParamType.String,
          true,
        ),
        'btName': serializeParam(
          _btName,
          ParamType.String,
          true,
        ),
      }.withoutNulls;

  static BtDevicesStruct fromSerializableMap(Map<String, dynamic> data) =>
      BtDevicesStruct(
        btAddress: deserializeParam<String>(
          data['btAddress'],
          ParamType.String,
          true,
        ),
        btName: deserializeParam<String>(
          data['btName'],
          ParamType.String,
          true,
        ),
      );

  @override
  String toString() => 'BtDevicesStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is BtDevicesStruct &&
        listEquality.equals(btAddress, other.btAddress) &&
        listEquality.equals(btName, other.btName);
  }

  @override
  int get hashCode => const ListEquality().hash([btAddress, btName]);
}

BtDevicesStruct createBtDevicesStruct() => BtDevicesStruct();
