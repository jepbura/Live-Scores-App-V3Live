import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:v3l/feature/data/models/dio/live_score_model.dart';
import '../../../../core/core.dart';
import '../../../data/data_sources/datasources.dart';
import '../../../domain/domain.dart';

part 'live_score_state.dart';

class LiveScoreCubit extends Cubit<LiveScoreState> {
  final Socket socket;
  final GetLiveScore getLiveScore;

  LiveScoreCubit(this.socket, this.getLiveScore) : super(LiveScoreInitial());

  Future<void> getLiveScoreData(NullParams params) async {
    // emit(LiveScoreInitial());
    final data = await getLiveScore.call(params);
    // print("dddddddddddddddddd: $data");
    data.fold(
      (l) {
        if (l is ServerFailure) {
          emit(const LiveScoreData().copyWith(status: ConnectionStatus.failure, message: "ServerFailure"));
        }
      },
      (r) {
        /// Set isLogin true
        emit(const LiveScoreData().copyWith(status: ConnectionStatus.success, message: "Socket send success", data: r));
        socketListener();
      },
    );
  }

  void socketListener() {
    socket.getSocketStream().listen((receiveApi) {
      receiveApi.fold(
        (l) {
          if (l is ServerFailure) {
            emit(const LiveScoreData().copyWith(status: ConnectionStatus.failure, message: l.message));
          }
        },
        (r) async {
          if (state is LiveScoreData) {
            var myState = state as LiveScoreData;

            MatchesReturnClass data = SocketMessageListener(liveScoreData: myState).socketMessageChecker(message: r);

            // print("yyyyyyyyyyyyyyyy ${data.selectMatches?.length}");
            stateRefreshing();
            emit(myState.copyWith(
              leagueId: myState.leagueId,
              data: myState.data?.copyWith(matches: data.matches),
              status: myState.status,
              message: myState.message,
              selectMatches: data.selectMatches,
            ));
          }
          // log.d(
          //   "Socket Data is ► $r",
          // );
        },
      );
    },
        onDone: () => emit(const LiveScoreData().copyWith(status: ConnectionStatus.failure, message: "Socket receive onDone")),
        onError: (error) => emit(const LiveScoreData().copyWith(status: ConnectionStatus.failure, message: "Socket receive onError")));
  }

  // void socketListener2() {
  //   socket.getSocketStream().listen((receiveApi) {
  //     receiveApi.fold(
  //       (l) {
  //         if (l is ServerFailure) {
  //           emit(const LiveScoreData().copyWith(status: ConnectionStatus.failure, message: l.message));
  //         }
  //       },
  //       (r) async {
  //         if (state is LiveScoreData) {
  //           var myState = state as LiveScoreData;
  //           List<Matches>? matches = myState.data?.matches;
  //           List<Matches>? selectMatches = myState.selectMatches;
  //           switch (r["target"]) {
  //             case "time-update":
  //               if (r["arguments"][0] != null && r["arguments"][0].containsKey("matches")) {
  //                 myState.data?.matches?.asMap().forEach((index, element) {
  //                   for (var element2 in r["arguments"][0]["matches"]) {
  //                     if (element2.containsKey("id") && element2["id"] == element.sportId) {
  //                       var temp = element.copyWith(liveTime: element2["time"] ?? "-");
  //                       matches?[index] = temp;
  //                     }
  //                   }
  //                 });
  //                 myState.selectMatches?.asMap().forEach((index, element) {
  //                   for (var element2 in r["arguments"][0]["matches"]) {
  //                     if (element2.containsKey("id") && element2["id"] == element.sportId) {
  //                       var temp = element.copyWith(liveTime: element2["time"] ?? "-");
  //                       selectMatches?[index] = temp;
  //                     }
  //                   }
  //                 });
  //               }
  //               break;
  //             case "upsert-event":
  //               break;
  //             case "football-match-changed":
  //               if (r["arguments"] != null && r["arguments"].length != 0) {
  //                 myState.data?.matches?.asMap().forEach((index, element) {
  //                   for (var element2 in r["arguments"]) {
  //                     if (element2.containsKey("id") && element2["id"] == element.sportId) {
  //                       var temp = element.copyWith(
  //                           liveTime: element2["liveTime"] ?? "-",
  //                           isLive: element2["isLive"] ?? element.isLive,
  //                           statusTitle: element2["statusTitle"] ?? element.statusTitle,
  //                           hostGoals: element2["hostGoals"] ?? element.hostGoals,
  //                           guestGoals: element2["guestGoals"] ?? element.guestGoals,
  //                           status: element2["status"] ?? element.status,
  //                           statusDescription: element2["statusDescription"] ?? element.statusDescription);
  //                       matches?[index] = temp;
  //                     }
  //                   }
  //                 });
  //                 myState.selectMatches?.asMap().forEach((index, element) {
  //                   for (var element2 in r["arguments"]) {
  //                     if (element2.containsKey("id") && element2["id"] == element.sportId) {
  //                       var temp = element.copyWith(
  //                           liveTime: element2["liveTime"] ?? "-",
  //                           isLive: element2["isLive"] ?? element.isLive,
  //                           statusTitle: element2["statusTitle"] ?? element.statusTitle,
  //                           hostGoals: element2["hostGoals"] ?? element.hostGoals,
  //                           guestGoals: element2["guestGoals"] ?? element.guestGoals,
  //                           status: element2["status"] ?? element.status,
  //                           statusDescription: element2["statusDescription"] ?? element.statusDescription);
  //                       selectMatches?[index] = temp;
  //                     }
  //                   }
  //                 });
  //               }
  //
  //               break;
  //             default:
  //           }
  //
  //           // var temp = myState.data?.copyWith(matches: matches);
  //           // print("yyyyyyyyyyyyyyyy ${temp?.matches?[18].liveTime}");
  //           stateRefreshing();
  //           emit(myState.copyWith(
  //             leagueId: myState.leagueId,
  //             data: myState.data?.copyWith(matches: matches),
  //             status: myState.status,
  //             message: myState.message,
  //             selectMatches: selectMatches,
  //           ));
  //         }
  //
  //         // log.d(
  //         //   "Socket Data is ► $r",
  //         // );
  //       },
  //     );
  //   },
  //       onDone: () => emit(const LiveScoreData().copyWith(status: ConnectionStatus.failure, message: "Socket receive onDone")),
  //       onError: (error) => emit(const LiveScoreData().copyWith(status: ConnectionStatus.failure, message: "Socket receive onError")));
  // }

  leagueSelected(List<Dates> id) {
    List<String> newId = [];
    List<Matches> selectMatches = [];

    if (state is LiveScoreData) {
      final myState = state as LiveScoreData;

      for (var element in id) {
        myState.data?.matches?.forEach((element1) {
          for (var element2 in element.matchIds) {
            if (element1.sportId != null && element2 == element1.sportId) {
              selectMatches.add(element1);
              newId.add(element2);
            }
          }
        });
      }

      stateRefreshing();
      emit(myState.copyWith(
        leagueId: newId,
        data: myState.data,
        status: myState.status,
        message: myState.message,
        selectMatches: selectMatches,
      ));
    }
  }

  stateRefreshing() {
    emit(LiveScoreRefreshing());
  }

  stateInitial() {
    emit(LiveScoreInitial());
  }
}
