import 'package:dartz/dartz.dart';
import '../../../core/core.dart';
import '../domain.dart';

abstract class DioRepository {
  Future<Either<Failure, LiveScoreEntity>> liveScore();
}
