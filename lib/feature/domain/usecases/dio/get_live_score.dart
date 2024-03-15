import 'package:dartz/dartz.dart';
import '../../../../core/core.dart';
import '../../domain.dart';

class GetLiveScore extends UseCase<LiveScoreEntity, NullParams> {
  final DioRepository _repo;

  GetLiveScore(this._repo);

  @override
  Future<Either<Failure, LiveScoreEntity>> call(NullParams params) =>
      _repo.liveScore();
}
