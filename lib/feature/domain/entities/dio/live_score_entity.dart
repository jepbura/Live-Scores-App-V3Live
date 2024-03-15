import 'package:equatable/equatable.dart';
import '../../../data/models/model.dart';

class LiveScoreEntity extends Equatable {
  List<Leagues>? leagues;
  List<Matches>? matches;
  List<dynamic>? standings;

  LiveScoreEntity({this.leagues, this.matches, this.standings});

  @override
  // TODO: implement props
  List<Object?> get props => [leagues?[0].id];

  @override
  // TODO: implement stringify
  bool? get stringify => true;

  LiveScoreEntity copyWith({
    List<Leagues>? leagues,
    List<Matches>? matches,
    List<dynamic>? standings,
  }) {
    return LiveScoreEntity(
      leagues: leagues ?? this.leagues,
      matches: matches ?? this.matches,
      standings: standings ?? this.standings,
    );
  }
}
