enum ConnectionStatus {
  loading,
  success,
  failure;

  bool get isLoading => this == ConnectionStatus.loading;

  bool get isSuccess => this == ConnectionStatus.success;

  bool get isFailure => this == ConnectionStatus.failure;
}
// https://web-api.varzesh3.com/v1.0/livescore/today
// wss://ksocket.varzesh3.com/live
String baseUrl = 'https://web-api.varzesh3.com';
String authority = 'web-api.varzesh3.com';
String url = 'https://web-api.varzesh3.com/v1.0/livescore/today';
String v3webSocket = 'wss://ksocket.varzesh3.com/live';
String preposition1 = '';
String preposition2 = '▼';

class NullParams {
  NullParams();
}
