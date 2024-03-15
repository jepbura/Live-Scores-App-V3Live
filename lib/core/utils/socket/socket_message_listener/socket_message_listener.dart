import '../../../../feature/data/models/model.dart';
import '../../../../feature/presentation/presentation.dart';

class SocketMessageListener {
  late final LiveScoreData liveScoreData;

  SocketMessageListener({required this.liveScoreData});

  MatchesReturnClass socketMessageChecker({required dynamic message}) {
    List<Matches>? matches = liveScoreData.data?.matches;
    List<Matches>? selectMatches = liveScoreData.selectMatches;
    switch (message["target"]) {
      case "time-update":
        if (message["arguments"][0] != null && message["arguments"][0].containsKey("matches")) {
          liveScoreData.data?.matches?.asMap().forEach((index, element) {
            for (var element2 in message["arguments"][0]["matches"]) {
              if (element2.containsKey("id") && element2["id"] == element.sportId) {
                var temp = element.copyWith(liveTime: element2["time"] ?? "-");
                matches?[index] = temp;
              }
            }
          });
          liveScoreData.selectMatches?.asMap().forEach((index, element) {
            for (var element2 in message["arguments"][0]["matches"]) {
              if (element2.containsKey("id") && element2["id"] == element.sportId) {
                var temp = element.copyWith(liveTime: element2["time"] ?? "-");
                selectMatches?[index] = temp;
              }
            }
          });
        }
        break;
      case "upsert-event":
        break;
      case "football-match-changed":
        if (message["arguments"] != null && message["arguments"].length != 0) {
          liveScoreData.data?.matches?.asMap().forEach((index, element) {
            for (var element2 in message["arguments"]) {
              if (element2.containsKey("id") && element2["id"] == element.sportId) {
                var temp = element.copyWith(
                    liveTime: element2["liveTime"] ?? "-",
                    isLive: element2["isLive"] ?? element.isLive,
                    statusTitle: element2["statusTitle"] ?? element.statusTitle,
                    hostGoals: element2["hostGoals"] ?? element.hostGoals,
                    guestGoals: element2["guestGoals"] ?? element.guestGoals,
                    status: element2["status"] ?? element.status,
                    statusDescription: element2["statusDescription"] ?? element.statusDescription);
                matches?[index] = temp;
              }
            }
          });
          liveScoreData.selectMatches?.asMap().forEach((index, element) {
            for (var element2 in message["arguments"]) {
              if (element2.containsKey("id") && element2["id"] == element.sportId) {
                var temp = element.copyWith(
                    liveTime: element2["liveTime"] ?? "-",
                    isLive: element2["isLive"] ?? element.isLive,
                    statusTitle: element2["statusTitle"] ?? element.statusTitle,
                    hostGoals: element2["hostGoals"] ?? element.hostGoals,
                    guestGoals: element2["guestGoals"] ?? element.guestGoals,
                    status: element2["status"] ?? element.status,
                    statusDescription: element2["statusDescription"] ?? element.statusDescription);
                selectMatches?[index] = temp;
              }
            }
          });
        }

        break;
      default:
    }

    // var temp = liveScoreData.data?.copyWith(matches: matches);
    // print("yyyyyyyyyyyyyyyy ${temp?.matches?[18].liveTime}");
    // return {"matches": matches, "selectMatches": selectMatches};
    return MatchesReturnClass(matches: matches, selectMatches: selectMatches);
  }
}

class MatchesReturnClass {
  List<Matches>? matches;
  List<Matches>? selectMatches;

  MatchesReturnClass({this.matches, this.selectMatches});
}
