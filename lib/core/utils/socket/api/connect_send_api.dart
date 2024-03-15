import 'base_send_api.dart';

class ConnectSendApi extends SendApi {
  ConnectSendApi({
    required this.protocol,
    required this.version,
  });
  late final String protocol;
  late final int version;

  ConnectSendApi.fromJson(Map<String, dynamic> json) {
    protocol = json['protocol'];
    version = json['version'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['protocol'] = protocol;
    _data['version'] = version;
    return _data;
  }
}
