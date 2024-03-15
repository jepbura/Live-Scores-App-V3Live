import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import '../../../core/core.dart';
import '../../../di/di.dart';
import '../../domain/domain.dart';
import '../data_sources/datasources.dart';

class DioRepositoryImpl implements DioRepository {
  /// Data Source
  final DioDatasource dioDatasource;

  const DioRepositoryImpl(this.dioDatasource);

  @override
  Future<Either<Failure, LiveScoreEntity>> liveScore() async {
    try {
      final response = await dioDatasource.liveScore();

      sl<Socket>().send(apiParams: ConnectSendApi(protocol: "json", version: 1));

      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
