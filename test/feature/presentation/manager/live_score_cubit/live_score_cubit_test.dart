import 'dart:convert';

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:v3l/core/core.dart';
import 'package:v3l/di/di.dart';
import 'package:v3l/feature/data/data_sources/datasources.dart';
import 'package:v3l/feature/data/models/dio/live_score_model.dart';
import 'package:v3l/feature/domain/domain.dart';
import 'package:v3l/feature/presentation/presentation.dart';

import '../../../../helpers/json_reader.dart';
import '../../../../helpers/paths.dart';
import 'live_score_cubit_test.mocks.dart';

@GenerateMocks([GetLiveScore])
void main() {
  late LiveScoreCubit liveScoreCubit;
  late LiveScoreModel liveScoreModel;
  late MockGetLiveScore mockGetLiveScore;
  late Socket socket;

  final nullParams = NullParams();
  const errorMessage = "ServerFailure";

  /// Initialize data
  setUp(() async {
    await serviceLocator(isUnitTest: true);
    liveScoreModel = LiveScoreModel.fromJson(json.decode(jsonReader(dioLiveScoreData)));
    mockGetLiveScore = MockGetLiveScore();
    socket = Socket();
    liveScoreCubit = LiveScoreCubit(socket, mockGetLiveScore);
  });

  /// Dispose bloc
  tearDown(() {
    liveScoreCubit.close();
  });

  ///  Initial data should be loading
  test("Initial data should be ConnectionStatus.loading", () {
    expect(liveScoreCubit.state, equals(LiveScoreInitial()));
  });

  blocTest<LiveScoreCubit, LiveScoreState>(
    "When repo success get data should be return LiveScoreData",
    build: () {
      when(mockGetLiveScore.call(nullParams)).thenAnswer((_) async => Right(liveScoreModel));

      return liveScoreCubit;
    },
    act: (cubit) => cubit.getLiveScoreData(nullParams),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      // const LiveScoreData(),
      LiveScoreData(status: ConnectionStatus.success, message: "Socket send success", data: liveScoreModel),
    ],
  );

  blocTest<LiveScoreCubit, LiveScoreState>(
    "When user input wrong credential should be return ServerFailure",
    build: () {
      when(mockGetLiveScore.call(nullParams)).thenAnswer((_) async => const Left(ServerFailure(errorMessage)));

      return liveScoreCubit;
    },
    act: (LiveScoreCubit liveScoreCubit) => liveScoreCubit.getLiveScoreData(nullParams),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      const LiveScoreData(status: ConnectionStatus.failure, message: "ServerFailure"),
    ],
  );
}
