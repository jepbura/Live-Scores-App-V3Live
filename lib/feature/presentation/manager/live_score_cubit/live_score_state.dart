part of 'live_score_cubit.dart';

abstract class LiveScoreState extends Equatable {
  const LiveScoreState();
}

class LiveScoreInitial extends LiveScoreState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class LiveScoreRefreshing extends LiveScoreState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class LiveScoreData extends LiveScoreState {
  final ConnectionStatus? status;
  final LiveScoreEntity? data;
  final String? message;
  final List<String>? leagueId;
  final List<Matches>? selectMatches;

  const LiveScoreData({
    this.status = ConnectionStatus.loading,
    this.data,
    this.message = '',
    this.leagueId = const [],
    this.selectMatches = const [],
  }) : super();

  LiveScoreData copyWith({
    ConnectionStatus? status,
    LiveScoreEntity? data,
    String? message,
    List<String>? leagueId,
    List<Matches>? selectMatches,
  }) {
    return LiveScoreData(
      status: status ?? this.status,
      data: data ?? this.data,
      message: message ?? this.message,
      leagueId: leagueId ?? this.leagueId,
      selectMatches: selectMatches ?? this.selectMatches,
    );
  }

  @override
  List<Object> get props => [];
}
