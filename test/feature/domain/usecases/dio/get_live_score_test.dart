import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:v3l/core/core.dart';
import 'package:v3l/feature/data/models/model.dart';
import 'package:v3l/feature/domain/domain.dart';
import '../../../../helpers/json_reader.dart';
import '../../../../helpers/mock/test_mock.mocks.dart';
import '../../../../helpers/paths.dart';

void main() {
  late MockDioRepository mockDioRepository;
  late GetLiveScore getLiveScore;
  late LiveScoreModel liveScoreModel;

  setUp(() {
    liveScoreModel = LiveScoreModel.fromJson(json.decode(jsonReader(dioLiveScoreData)));
    mockDioRepository = MockDioRepository();
    getLiveScore = GetLiveScore(mockDioRepository);
  });

  test("should get live score dio from the repository", () async {
    /// arrange
    when(mockDioRepository.liveScore()).thenAnswer((_) async => Right(liveScoreModel));

    /// act
    final result = await getLiveScore.call(NullParams());

    /// assert
    verify(mockDioRepository.liveScore());
    expect(result, equals(Right(liveScoreModel)));
  });
}
