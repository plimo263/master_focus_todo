import 'dart:async';
import 'dart:convert';

class TodoTimer {
  int _secondsElapsed;
  final int secondsTotal;
  bool isRunning = false;

  TodoTimer({required int secondsElapsed, required this.secondsTotal})
      : _secondsElapsed = secondsElapsed;

  TodoTimer.fromMap(Map<String, dynamic> map)
      : _secondsElapsed = map['seconds_elapsed'],
        secondsTotal = map['seconds_total'];

  factory TodoTimer.fromJson(String json) {
    final map = jsonDecode(json);
    return TodoTimer.fromMap(map);
  }

  int get secondsElapsed => _secondsElapsed;

  Map<String, dynamic> toMap() {
    return {
      'seconds_total': secondsTotal,
      'seconds_elapsed': _secondsElapsed,
    };
  }

  String toJson() {
    return jsonEncode(toMap());
  }

  /// Gera o incremento do tempo decorrido, quando o tempo
  /// se esgota uma Exception TimeoutException é lançada
  /// O tempo só incrementa se isRunning estiver ativo
  void ticTac() {
    if (_secondsElapsed >= secondsTotal) {
      isRunning = false;
      throw TimeoutException('O tempo se esgotou');
    }

    if (isRunning) {
      _secondsElapsed++;
    }
  }

  /// Retorna o tempo decorrido
  void reset() {
    _secondsElapsed = 0;
  }

  /// Retorna o tempo restante para finalização
  int remainingTime() {
    return secondsTotal - _secondsElapsed;
  }

  /// Converte os segundos em minutos em formato MM:SS
  String formatTime(int seconds) {
    int resultMinutes = calculateMinutes(seconds);
    int resultSeconds = calculateSeconds(seconds);
    return '${resultMinutes.toString().padLeft(2, '0')}'
        ':'
        '${resultSeconds.toString().padLeft(2, '0')}';
  }

  /// Calcula os minutos retornando entre 0 e 59
  int calculateMinutes(int seconds) {
    return seconds ~/ 60;
  }

  /// Calcula os segundos retornando entre 0 e 59
  int calculateSeconds(int seconds) {
    return (seconds % 60).toInt();
  }
}
