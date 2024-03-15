import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:v3l/core/core.dart';
import 'package:v3l/di/di.dart';
import 'package:v3l/feature/data/data.dart';
import 'package:v3l/feature/data/models/model.dart';

import '../../../helpers/json_reader.dart';
import '../../../helpers/mock/test_mock.mocks.dart';
import '../../../helpers/paths.dart';

void main() {
  late MockDioDatasource mockDioDatasource;
  late DioRepositoryImpl dioRepositoryImpl;
  late LiveScoreModel liveScoreModel;

  setUp(() async {
    await serviceLocator(isUnitTest: true);
    mockDioDatasource = MockDioDatasource();
    dioRepositoryImpl = DioRepositoryImpl(mockDioDatasource);
    liveScoreModel = LiveScoreModel.fromJson(json.decode(jsonReader(dioLiveScoreData)));
  });

  group("Get live score", () {
    test('should return live score when call data is successful', () async {
      // arrange
      when(mockDioDatasource.liveScore()).thenAnswer(
        (_) async => LiveScoreModel.fromJson(
          json.decode(jsonReader(dioLiveScoreData)),
        ),
      );

      // act
      final result = await dioRepositoryImpl.liveScore();

      // assert
      verify(mockDioDatasource.liveScore());
      expect(result, equals(Right(liveScoreModel)));
    });

    test(
      'should return live score failure when call data is unsuccessful',
      () async {
        // arrange
        when(mockDioDatasource.liveScore()).thenThrow(ServerException(''));

        // act
        final result = await dioRepositoryImpl.liveScore();

        // assert
        verify(mockDioDatasource.liveScore());
        expect(result, equals(const Left(ServerFailure(''))));
      },
    );
  });
}
