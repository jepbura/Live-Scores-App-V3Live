import 'dart:convert';

import '../../../../core/core.dart';
import '../../models/model.dart';
import '../datasources.dart';
import 'dio_services/list_api.dart';

abstract class DioDatasource {
  Future<LiveScoreModel> liveScore();
}

class DioDatasourceImpl implements DioDatasource {
  final DioClient _client;

  DioDatasourceImpl(this._client);

  @override
  Future<LiveScoreModel> liveScore() async {
    try {
      final response = await _client.getRequest(
        ListApi.livescore,
      );

      if (response.statusCode == 200) {
        final result = LiveScoreModel.fromJson(response.data);

        // var decode = json.decode(response.body);
        // print("3333 $decode");
        // final result = LiveScoreModel.fromJson(decode);
        // print("4444 $result");

        return result;
      } else {
        throw ServerException("error");
      }
    } on ServerException catch (e) {
      throw ServerException(e.message);
    }
  }
}
