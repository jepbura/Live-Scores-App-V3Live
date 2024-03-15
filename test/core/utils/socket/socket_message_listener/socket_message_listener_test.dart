import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:v3l/core/core.dart';
import 'package:v3l/feature/data/data_sources/datasources.dart';
import 'package:v3l/feature/data/models/model.dart';
import 'package:v3l/feature/presentation/presentation.dart';

import '../../../../helpers/json_reader.dart';
import '../../../../helpers/paths.dart';
import '../../../../helpers/socket_data/socket_data.dart';

void main() {
  late Socket socket;
  late LiveScoreData liveScoreData;
  final Map<String, dynamic> jsonMap = json.decode(jsonReader(dioLiveScoreData));
  late LiveScoreModel liveScoreModel;
  setUp(() {
    socket = Socket();
    liveScoreModel = LiveScoreModel.fromJson(jsonMap);
    liveScoreData = const LiveScoreData().copyWith(status: ConnectionStatus.success, message: "Socket send success", data: liveScoreModel);
  });
  group("SocketMessageListener class test", () {
    test("socketMessageChecker time update test with socket json data", () {
      var message = socket.dataConverter(timeUpdate);
      MatchesReturnClass data = SocketMessageListener(liveScoreData: liveScoreData).socketMessageChecker(message: message);
      expect(data.matches?[2].liveTime, "45");
    });
    test("socketMessageChecker football match changed test with socket json data", () {
      var message = socket.dataConverter(footballMatchChanged);
      MatchesReturnClass data = SocketMessageListener(liveScoreData: liveScoreData).socketMessageChecker(message: message);
      expect(data.matches?[2].hostGoals, "4");
    });
  });
}
