import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:v3l/core/core.dart';
import 'package:v3l/di/di.dart';
import 'package:v3l/feature/data/data_sources/datasources.dart';
import 'package:v3l/feature/data/data_sources/dio/dio_services/list_api.dart';
import 'package:v3l/feature/data/models/model.dart';

import '../../../../helpers/json_reader.dart';
import '../../../../helpers/paths.dart';

void main() {
  late DioAdapter dioAdapter;
  late DioDatasourceImpl dataSource;

  setUp(() async {
    await serviceLocator(isUnitTest: true);
    dioAdapter = DioAdapter(dio: sl<DioClient>().dio);
    dataSource = DioDatasourceImpl(sl<DioClient>());
  });

  group('Get live score', () {
    final liveScoreModel = LiveScoreModel.fromJson(json.decode(jsonReader(dioLiveScoreData)));

    test(
      'should return live score success model when response code is 200',
      () async {
        /// arrange
        dioAdapter.onGet(
          ListApi.livescore,
          (server) => server.reply(
            200,
            json.decode(jsonReader(dioLiveScoreData)),
          ),
          // data: _loginParams.toJson(),
        );

        /// act
        final result = await dataSource.liveScore();

        /// assert
        expect(liveScoreModel, equals(result));
      },
    );

    test(
      'should return live score unsuccessful model when response code is 400',
      () async {
        /// arrange
        dioAdapter.onGet(
          ListApi.livescore,
          (server) => server.reply(
            400,
            json.decode(jsonReader(dioLiveScoreErrorData)),
          ),
          // data: _loginParams.toJson(),
        );

        /// act
        final result = dataSource.liveScore();

        /// assert
        expect(result, throwsA(isA<ServerException>()));
      },
    );
  });
}
