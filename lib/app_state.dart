import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  set nombresAlarmas(List<String> value) {
    _nombresAlarmas = value;
    prefs.setStringList('ff_nombresAlarmas', value);
  }

  void addToNombresAlarmas(String value) {
    _nombresAlarmas.add(value);
    prefs.setStringList('ff_nombresAlarmas', _nombresAlarmas);
  }

  void removeFromNombresAlarmas(String value) {
    _nombresAlarmas.remove(value);
    prefs.setStringList('ff_nombresAlarmas', _nombresAlarmas);
  }

  void removeAtIndexFromNombresAlarmas(int index) {
    _nombresAlarmas.removeAt(index);
    prefs.setStringList('ff_nombresAlarmas', _nombresAlarmas);
  }

  void updateNombresAlarmasAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    _nombresAlarmas[index] = updateFn(_nombresAlarmas[index]);
    prefs.setStringList('ff_nombresAlarmas', _nombresAlarmas);
  }

  void insertAtIndexInNombresAlarmas(int index, String value) {
    _nombresAlarmas.insert(index, value);
    prefs.setStringList('ff_nombresAlarmas', _nombresAlarmas);
  }

  List<DateTime> _horasAlarmas = [
    DateTime.fromMillisecondsSinceEpoch(1716385500000),
    DateTime.fromMillisecondsSinceEpoch(1716423300000)
  ];
  List<DateTime> get horasAlarmas => _horasAlarmas;
  set horasAlarmas(List<DateTime> value) {
    _horasAlarmas = value;
    prefs.setStringList('ff_horasAlarmas',
        value.map((x) => x.millisecondsSinceEpoch.toString()).toList());
  }

  void addToHorasAlarmas(DateTime value) {
    _horasAlarmas.add(value);
    prefs.setStringList('ff_horasAlarmas',
        _horasAlarmas.map((x) => x.millisecondsSinceEpoch.toString()).toList());
  }

  void removeFromHorasAlarmas(DateTime value) {
    _horasAlarmas.remove(value);
    prefs.setStringList('ff_horasAlarmas',
        _horasAlarmas.map((x) => x.millisecondsSinceEpoch.toString()).toList());
  }

  void removeAtIndexFromHorasAlarmas(int index) {
    _horasAlarmas.removeAt(index);
    prefs.setStringList('ff_horasAlarmas',
        _horasAlarmas.map((x) => x.millisecondsSinceEpoch.toString()).toList());
  }

  void updateHorasAlarmasAtIndex(
    int index,
    DateTime Function(DateTime) updateFn,
  ) {
    _horasAlarmas[index] = updateFn(_horasAlarmas[index]);
    prefs.setStringList('ff_horasAlarmas',
        _horasAlarmas.map((x) => x.millisecondsSinceEpoch.toString()).toList());
  }

  void insertAtIndexInHorasAlarmas(int index, DateTime value) {
    _horasAlarmas.insert(index, value);
    prefs.setStringList('ff_horasAlarmas',
        _horasAlarmas.map((x) => x.millisecondsSinceEpoch.toString()).toList());
  }

  List<String> _diasAlarmas = ['LMXJV--', '-----SD'];
  List<String> get diasAlarmas => _diasAlarmas;
  set diasAlarmas(List<String> value) {
    _diasAlarmas = value;
    prefs.setStringList('ff_diasAlarmas', value);
  }

  void addToDiasAlarmas(String value) {
    _diasAlarmas.add(value);
    prefs.setStringList('ff_diasAlarmas', _diasAlarmas);
  }

  void removeFromDiasAlarmas(String value) {
    _diasAlarmas.remove(value);
    prefs.setStringList('ff_diasAlarmas', _diasAlarmas);
  }

  void removeAtIndexFromDiasAlarmas(int index) {
    _diasAlarmas.removeAt(index);
    prefs.setStringList('ff_diasAlarmas', _diasAlarmas);
  }

  void updateDiasAlarmasAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    _diasAlarmas[index] = updateFn(_diasAlarmas[index]);
    prefs.setStringList('ff_diasAlarmas', _diasAlarmas);
  }

  void insertAtIndexInDiasAlarmas(int index, String value) {
    _diasAlarmas.insert(index, value);
    prefs.setStringList('ff_diasAlarmas', _diasAlarmas);
  }

  List<int> _idAlarmas = [1, 2];
  List<int> get idAlarmas => _idAlarmas;
  set idAlarmas(List<int> value) {
    _idAlarmas = value;
    prefs.setStringList(
        'ff_idAlarmas', value.map((x) => x.toString()).toList());
  }

  void addToIdAlarmas(int value) {
    _idAlarmas.add(value);
    prefs.setStringList(
        'ff_idAlarmas', _idAlarmas.map((x) => x.toString()).toList());
  }

  void removeFromIdAlarmas(int value) {
    _idAlarmas.remove(value);
    prefs.setStringList(
        'ff_idAlarmas', _idAlarmas.map((x) => x.toString()).toList());
  }

  void removeAtIndexFromIdAlarmas(int index) {
    _idAlarmas.removeAt(index);
    prefs.setStringList(
        'ff_idAlarmas', _idAlarmas.map((x) => x.toString()).toList());
  }

  void updateIdAlarmasAtIndex(
    int index,
    int Function(int) updateFn,
  ) {
    _idAlarmas[index] = updateFn(_idAlarmas[index]);
    prefs.setStringList(
        'ff_idAlarmas', _idAlarmas.map((x) => x.toString()).toList());
  }

  void insertAtIndexInIdAlarmas(int index, int value) {
    _idAlarmas.insert(index, value);
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
