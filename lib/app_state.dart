import 'package:flutter/material.dart';
import '/backend/schema/structs/index.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _safeInit(() {
      _nombresAlarmas =
          prefs.getStringList('ff_nombresAlarmas') ?? _nombresAlarmas;
    });
    _safeInit(() {
      _horasAlarmas = prefs
              .getStringList('ff_horasAlarmas')
              ?.map((x) => DateTime.fromMillisecondsSinceEpoch(int.parse(x)))
              .toList() ??
          _horasAlarmas;
    });
    _safeInit(() {
      _diasAlarmas = prefs.getStringList('ff_diasAlarmas') ?? _diasAlarmas;
    });
    _safeInit(() {
      _idAlarmas =
          prefs.getStringList('ff_idAlarmas')?.map(int.parse).toList() ??
              _idAlarmas;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  List<String> _nombresAlarmas = ['Alarma Semana', 'Alarma Finde'];
  List<String> get nombresAlarmas => _nombresAlarmas;
  set nombresAlarmas(List<String> _value) {
    _nombresAlarmas = _value;
    prefs.setStringList('ff_nombresAlarmas', _value);
  }

  void addToNombresAlarmas(String _value) {
    _nombresAlarmas.add(_value);
    prefs.setStringList('ff_nombresAlarmas', _nombresAlarmas);
  }

  void removeFromNombresAlarmas(String _value) {
    _nombresAlarmas.remove(_value);
    prefs.setStringList('ff_nombresAlarmas', _nombresAlarmas);
  }

  void removeAtIndexFromNombresAlarmas(int _index) {
    _nombresAlarmas.removeAt(_index);
    prefs.setStringList('ff_nombresAlarmas', _nombresAlarmas);
  }

  void updateNombresAlarmasAtIndex(
    int _index,
    String Function(String) updateFn,
  ) {
    _nombresAlarmas[_index] = updateFn(_nombresAlarmas[_index]);
    prefs.setStringList('ff_nombresAlarmas', _nombresAlarmas);
  }

  void insertAtIndexInNombresAlarmas(int _index, String _value) {
    _nombresAlarmas.insert(_index, _value);
    prefs.setStringList('ff_nombresAlarmas', _nombresAlarmas);
  }

  List<DateTime> _horasAlarmas = [
    DateTime.fromMillisecondsSinceEpoch(1716385500000),
    DateTime.fromMillisecondsSinceEpoch(1716423300000)
  ];
  List<DateTime> get horasAlarmas => _horasAlarmas;
  set horasAlarmas(List<DateTime> _value) {
    _horasAlarmas = _value;
    prefs.setStringList('ff_horasAlarmas',
        _value.map((x) => x.millisecondsSinceEpoch.toString()).toList());
  }

  void addToHorasAlarmas(DateTime _value) {
    _horasAlarmas.add(_value);
    prefs.setStringList('ff_horasAlarmas',
        _horasAlarmas.map((x) => x.millisecondsSinceEpoch.toString()).toList());
  }

  void removeFromHorasAlarmas(DateTime _value) {
    _horasAlarmas.remove(_value);
    prefs.setStringList('ff_horasAlarmas',
        _horasAlarmas.map((x) => x.millisecondsSinceEpoch.toString()).toList());
  }

  void removeAtIndexFromHorasAlarmas(int _index) {
    _horasAlarmas.removeAt(_index);
    prefs.setStringList('ff_horasAlarmas',
        _horasAlarmas.map((x) => x.millisecondsSinceEpoch.toString()).toList());
  }

  void updateHorasAlarmasAtIndex(
    int _index,
    DateTime Function(DateTime) updateFn,
  ) {
    _horasAlarmas[_index] = updateFn(_horasAlarmas[_index]);
    prefs.setStringList('ff_horasAlarmas',
        _horasAlarmas.map((x) => x.millisecondsSinceEpoch.toString()).toList());
  }

  void insertAtIndexInHorasAlarmas(int _index, DateTime _value) {
    _horasAlarmas.insert(_index, _value);
    prefs.setStringList('ff_horasAlarmas',
        _horasAlarmas.map((x) => x.millisecondsSinceEpoch.toString()).toList());
  }

  List<String> _diasAlarmas = ['LMXJV--', '-----SD'];
  List<String> get diasAlarmas => _diasAlarmas;
  set diasAlarmas(List<String> _value) {
    _diasAlarmas = _value;
    prefs.setStringList('ff_diasAlarmas', _value);
  }

  void addToDiasAlarmas(String _value) {
    _diasAlarmas.add(_value);
    prefs.setStringList('ff_diasAlarmas', _diasAlarmas);
  }

  void removeFromDiasAlarmas(String _value) {
    _diasAlarmas.remove(_value);
    prefs.setStringList('ff_diasAlarmas', _diasAlarmas);
  }

  void removeAtIndexFromDiasAlarmas(int _index) {
    _diasAlarmas.removeAt(_index);
    prefs.setStringList('ff_diasAlarmas', _diasAlarmas);
  }

  void updateDiasAlarmasAtIndex(
    int _index,
    String Function(String) updateFn,
  ) {
    _diasAlarmas[_index] = updateFn(_diasAlarmas[_index]);
    prefs.setStringList('ff_diasAlarmas', _diasAlarmas);
  }

  void insertAtIndexInDiasAlarmas(int _index, String _value) {
    _diasAlarmas.insert(_index, _value);
    prefs.setStringList('ff_diasAlarmas', _diasAlarmas);
  }

  List<int> _idAlarmas = [1, 2];
  List<int> get idAlarmas => _idAlarmas;
  set idAlarmas(List<int> _value) {
    _idAlarmas = _value;
    prefs.setStringList(
        'ff_idAlarmas', _value.map((x) => x.toString()).toList());
  }

  void addToIdAlarmas(int _value) {
    _idAlarmas.add(_value);
    prefs.setStringList(
        'ff_idAlarmas', _idAlarmas.map((x) => x.toString()).toList());
  }

  void removeFromIdAlarmas(int _value) {
    _idAlarmas.remove(_value);
    prefs.setStringList(
        'ff_idAlarmas', _idAlarmas.map((x) => x.toString()).toList());
  }

  void removeAtIndexFromIdAlarmas(int _index) {
    _idAlarmas.removeAt(_index);
    prefs.setStringList(
        'ff_idAlarmas', _idAlarmas.map((x) => x.toString()).toList());
  }

  void updateIdAlarmasAtIndex(
    int _index,
    int Function(int) updateFn,
  ) {
    _idAlarmas[_index] = updateFn(_idAlarmas[_index]);
    prefs.setStringList(
        'ff_idAlarmas', _idAlarmas.map((x) => x.toString()).toList());
  }

  void insertAtIndexInIdAlarmas(int _index, int _value) {
    _idAlarmas.insert(_index, _value);
    prefs.setStringList(
        'ff_idAlarmas', _idAlarmas.map((x) => x.toString()).toList());
  }
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}
