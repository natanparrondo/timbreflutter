// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class AlarmasStruct extends BaseStruct {
  AlarmasStruct({
    String? nombredeAlarma,
    DateTime? horadeAlarma,
  })  : _nombredeAlarma = nombredeAlarma,
        _horadeAlarma = horadeAlarma;

  // "nombredeAlarma" field.
  String? _nombredeAlarma;
  String get nombredeAlarma => _nombredeAlarma ?? '';
  set nombredeAlarma(String? val) => _nombredeAlarma = val;
  bool hasNombredeAlarma() => _nombredeAlarma != null;

  // "horadeAlarma" field.
  DateTime? _horadeAlarma;
  DateTime? get horadeAlarma => _horadeAlarma;
  set horadeAlarma(DateTime? val) => _horadeAlarma = val;
  bool hasHoradeAlarma() => _horadeAlarma != null;

  static AlarmasStruct fromMap(Map<String, dynamic> data) => AlarmasStruct(
        nombredeAlarma: data['nombredeAlarma'] as String?,
        horadeAlarma: data['horadeAlarma'] as DateTime?,
      );

  static AlarmasStruct? maybeFromMap(dynamic data) =>
      data is Map ? AlarmasStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'nombredeAlarma': _nombredeAlarma,
        'horadeAlarma': _horadeAlarma,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'nombredeAlarma': serializeParam(
          _nombredeAlarma,
          ParamType.String,
        ),
        'horadeAlarma': serializeParam(
          _horadeAlarma,
          ParamType.DateTime,
        ),
      }.withoutNulls;

  static AlarmasStruct fromSerializableMap(Map<String, dynamic> data) =>
      AlarmasStruct(
        nombredeAlarma: deserializeParam(
          data['nombredeAlarma'],
          ParamType.String,
          false,
        ),
        horadeAlarma: deserializeParam(
          data['horadeAlarma'],
          ParamType.DateTime,
          false,
        ),
      );

  @override
  String toString() => 'AlarmasStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is AlarmasStruct &&
        nombredeAlarma == other.nombredeAlarma &&
        horadeAlarma == other.horadeAlarma;
  }

  @override
  int get hashCode => const ListEquality().hash([nombredeAlarma, horadeAlarma]);
}

AlarmasStruct createAlarmasStruct({
  String? nombredeAlarma,
  DateTime? horadeAlarma,
}) =>
    AlarmasStruct(
      nombredeAlarma: nombredeAlarma,
      horadeAlarma: horadeAlarma,
    );
