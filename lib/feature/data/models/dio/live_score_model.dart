import '../../../domain/domain.dart';

class LiveScoreModel extends LiveScoreEntity {
  LiveScoreModel({
    List<Leagues>? leagues,
    List<Matches>? matches,
    List<dynamic>? standings,
  }) : super(leagues: leagues, matches: matches, standings: standings);

  LiveScoreModel.fromJson(Map<String, dynamic> json) {
    leagues = List.from(json['leagues']).map((e) => Leagues.fromJson(e)).toList();
    matches = List.from(json['matches']).map((e) => Matches.fromJson(e)).toList();
    standings = List.castFrom<dynamic, dynamic>(json['standings']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['leagues'] = leagues?.map((e) => e.toJson()).toList();
    data['matches'] = matches?.map((e) => e.toJson()).toList();
    data['standings'] = standings;
    return data;
  }
}

class Leagues {
  Leagues({
    required this.id,
    required this.logo,
    required this.title,
    required this.sport,
    this.link,
    required this.dates,
  });
  late final int id;
  late final String logo;
  late final String title;
  late final int sport;
  late final String? link;
  late final List<Dates> dates;

  Leagues.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    logo = json['logo'];
    title = json['title'];
    sport = json['sport'];
    link = null;
    dates = List.from(json['dates']).map((e) => Dates.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['logo'] = logo;
    data['title'] = title;
    data['sport'] = sport;
    data['link'] = link;
    data['dates'] = dates.map((e) => e.toJson()).toList();
    return data;
  }
}

class Dates {
  Dates({
    required this.date,
    required this.matchIds,
  });
  late final String date;
  late final List<String> matchIds;

  Dates.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    matchIds = List.castFrom<dynamic, String>(json['matchIds']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['date'] = date;
    data['matchIds'] = matchIds;
    return data;
  }
}

class Matches {
  Matches({
    this.sport,
    this.hostPoint,
    this.guestPoint,
    this.setPoints1,
    this.setPoints2,
    this.setPoints3,
    this.setPoints4,
    this.setPoints5,
    this.scheduledStartDate,
    this.scheduledStartTime,
    this.predictionLink,
    this.predictionUrl,
    this.round,
    this.penaltyGoals,
    this.videoId,
    this.referee,
    this.matchGoals,
    this.hostLogo,
    this.guestLogo,
    this.id,
    this.title,
    this.sportId,
    this.hostName,
    this.hostLink,
    this.guestName,
    this.guestLink,
    this.hostId,
    this.guestId,
    this.status,
    this.statusDescription,
    this.statusTitle,
    this.isLive,
    this.time,
    this.hasEvents,
    this.liveStreamSource,
    this.videoLink,
    this.matchPageLink,
    this.matchApi,
    this.eventsApi,
    this.scheduledStartOn,
    this.stadium,
    this.hostGoals,
    this.guestGoals,
    this.liveTime,
    this.hasPenalty,
  });
  late final int? sport;
  late final String? hostPoint;
  late final String? guestPoint;
  late final SetPoints1? setPoints1;
  late final SetPoints2? setPoints2;
  late final SetPoints3? setPoints3;
  late final SetPoints4? setPoints4;
  late final SetPoints5? setPoints5;
  late final String? scheduledStartDate;
  late final String? scheduledStartTime;
  late final dynamic predictionLink;
  late final dynamic predictionUrl;
  late final int? round;
  late final dynamic penaltyGoals;
  late final dynamic videoId;
  late final dynamic referee;
  late final MatchGoals? matchGoals;
  late final dynamic hostLogo;
  late final dynamic guestLogo;
  late final int? id;
  late final dynamic title;
  late final String? sportId;
  late final String? hostName;
  late final dynamic hostLink;
  late final String? guestName;
  late final dynamic guestLink;
  late final int? hostId;
  late final int? guestId;
  late final int? status;
  late final dynamic statusDescription;
  late final String? statusTitle;
  late final bool? isLive;
  late final String? time;
  late final bool? hasEvents;
  late final String? liveStreamSource;
  late final dynamic videoLink;
  late final String? matchPageLink;
  late final String? matchApi;
  late final dynamic eventsApi;
  late final String? scheduledStartOn;
  late final dynamic stadium;
  late final String? hostGoals;
  late final String? guestGoals;
  late final dynamic liveTime;
  late final bool? hasPenalty;

  Matches.fromJson(Map<String, dynamic> json) {
    sport = json['sport'];
    hostPoint = json['hostPoint'];
    guestPoint = json['guestPoint'];
    setPoints1 = SetPoints1.fromJson(json['setPoints1'] ?? {"host": 0, "guest": 0});
    setPoints2 = SetPoints2.fromJson(json['setPoints2'] ?? {"host": 0, "guest": 0});
    setPoints3 = SetPoints3.fromJson(json['setPoints3'] ?? {"host": 0, "guest": 0});
    setPoints4 = SetPoints4.fromJson(json['setPoints4'] ?? {"host": 0, "guest": 0});
    setPoints5 = SetPoints5.fromJson(json['setPoints5'] ?? {"host": 0, "guest": 0});
    matchGoals = MatchGoals.fromJson(json['matchGoals'] ?? {"host": 0, "guest": 0});
    scheduledStartDate = json['scheduledStartDate'];
    scheduledStartTime = json['scheduledStartTime'];
    predictionLink = json['predictionLink'];
    predictionUrl = json['predictionUrl'];
    round = json['round'];
    penaltyGoals = json['penaltyGoals'];
    videoId = json['videoId'];
    referee = json['referee'];
    hostLogo = json['hostLogo'];
    guestLogo = json['guestLogo'];
    id = json['id'];
    title = json['title'];
    sportId = json['sportId'];
    hostName = json['hostName'];
    hostLink = json['hostLink'];
    guestName = json['guestName'];
    guestLink = json['guestLink'];
    hostId = json['hostId'];
    guestId = json['guestId'];
    status = json['status'];
    statusDescription = json['statusDescription'];
    statusTitle = json['statusTitle'];
    isLive = json['isLive'];
    time = json['time'];
    hasEvents = json['hasEvents'];
    liveStreamSource = json['liveStreamSource'];
    videoLink = json['videoLink'];
    matchPageLink = json['matchPageLink'];
    matchApi = json['matchApi'];
    eventsApi = json['eventsApi'];
    scheduledStartOn = json['scheduledStartOn'];
    stadium = json['stadium'];
    hostGoals = json['hostGoals'];
    guestGoals = json['guestGoals'];
    liveTime = json['liveTime'];
    hasPenalty = json['hasPenalty'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['sport'] = sport;
    data['hostPoint'] = hostPoint;
    data['guestPoint'] = guestPoint;
    data['setPoints1'] = setPoints1?.toJson();
    data['setPoints2'] = setPoints2?.toJson();
    data['setPoints3'] = setPoints3?.toJson();
    data['setPoints4'] = setPoints4?.toJson();
    data['setPoints5'] = setPoints5?.toJson();
    data['matchGoals'] = matchGoals?.toJson();
    data['scheduledStartDate'] = scheduledStartDate;
    data['scheduledStartTime'] = scheduledStartTime;
    data['predictionLink'] = predictionLink;
    data['predictionUrl'] = predictionUrl;
    data['round'] = round;
    data['penaltyGoals'] = penaltyGoals;
    data['videoId'] = videoId;
    data['referee'] = referee;
    data['hostLogo'] = hostLogo;
    data['guestLogo'] = guestLogo;
    data['id'] = id;
    data['title'] = title;
    data['sportId'] = sportId;
    data['hostName'] = hostName;
    data['hostLink'] = hostLink;
    data['guestName'] = guestName;
    data['guestLink'] = guestLink;
    data['hostId'] = hostId;
    data['guestId'] = guestId;
    data['status'] = status;
    data['statusDescription'] = statusDescription;
    data['statusTitle'] = statusTitle;
    data['isLive'] = isLive;
    data['time'] = time;
    data['hasEvents'] = hasEvents;
    data['liveStreamSource'] = liveStreamSource;
    data['videoLink'] = videoLink;
    data['matchPageLink'] = matchPageLink;
    data['matchApi'] = matchApi;
    data['eventsApi'] = eventsApi;
    data['scheduledStartOn'] = scheduledStartOn;
    data['stadium'] = stadium;
    data['hostGoals'] = hostGoals;
    data['guestGoals'] = guestGoals;
    data['liveTime'] = liveTime;
    data['hasPenalty'] = hasPenalty;
    return data;
  }

  Matches copyWith({
    int? sport,
    String? hostPoint,
    String? guestPoint,
    SetPoints1? setPoints1,
    SetPoints2? setPoints2,
    SetPoints3? setPoints3,
    SetPoints4? setPoints4,
    SetPoints5? setPoints5,
    String? scheduledStartDate,
    String? scheduledStartTime,
    dynamic predictionLink,
    dynamic predictionUrl,
    int? round,
    dynamic penaltyGoals,
    dynamic videoId,
    dynamic referee,
    MatchGoals? matchGoals,
    dynamic hostLogo,
    dynamic guestLogo,
    int? id,
    dynamic title,
    String? sportId,
    String? hostName,
    dynamic hostLink,
    String? guestName,
    dynamic guestLink,
    int? hostId,
    int? guestId,
    int? status,
    dynamic statusDescription,
    String? statusTitle,
    bool? isLive,
    String? time,
    bool? hasEvents,
    String? liveStreamSource,
    dynamic videoLink,
    String? matchPageLink,
    String? matchApi,
    dynamic eventsApi,
    String? scheduledStartOn,
    dynamic stadium,
    String? hostGoals,
    String? guestGoals,
    dynamic liveTime,
    bool? hasPenalty,
  }) {
    return Matches(
      sport: sport ?? this.sport,
      hostPoint: hostPoint ?? this.hostPoint,
      guestPoint: guestPoint ?? this.guestPoint,
      setPoints1: setPoints1 ?? this.setPoints1,
      setPoints2: setPoints2 ?? this.setPoints2,
      setPoints3: setPoints3 ?? this.setPoints3,
      setPoints4: setPoints4 ?? this.setPoints4,
      setPoints5: setPoints5 ?? this.setPoints5,
      scheduledStartDate: scheduledStartDate ?? this.scheduledStartDate,
      scheduledStartTime: scheduledStartTime ?? this.scheduledStartTime,
      predictionLink: predictionLink ?? this.predictionLink,
      predictionUrl: predictionUrl ?? this.predictionUrl,
      round: round ?? this.round,
      penaltyGoals: penaltyGoals ?? this.penaltyGoals,
      matchGoals: matchGoals ?? this.matchGoals,
      videoId: videoId ?? this.videoId,
      referee: referee ?? this.referee,
      hostLogo: hostLogo ?? this.hostLogo,
      guestLogo: guestLogo ?? this.guestLogo,
      id: id ?? this.id,
      title: title ?? this.title,
      sportId: sportId ?? this.sportId,
      hostName: hostName ?? this.hostName,
      hostLink: hostLink ?? this.hostLink,
      guestName: guestName ?? this.guestName,
      guestLink: guestLink ?? this.guestLink,
      hostId: hostId ?? this.hostId,
      guestId: guestId ?? this.guestId,
      status: status ?? this.status,
      statusDescription: statusDescription ?? this.statusDescription,
      statusTitle: statusTitle ?? this.statusTitle,
      isLive: isLive ?? this.isLive,
      time: time ?? this.time,
      hasEvents: hasEvents ?? this.hasEvents,
      liveStreamSource: liveStreamSource ?? this.liveStreamSource,
      videoLink: videoLink ?? this.videoLink,
      matchPageLink: matchPageLink ?? this.matchPageLink,
      matchApi: matchApi ?? this.matchApi,
      eventsApi: eventsApi ?? this.eventsApi,
      scheduledStartOn: scheduledStartOn ?? this.scheduledStartOn,
      stadium: stadium ?? this.stadium,
      hostGoals: hostGoals ?? this.hostGoals,
      guestGoals: guestGoals ?? this.guestGoals,
      liveTime: liveTime ?? this.liveTime,
      hasPenalty: hasPenalty ?? this.hasPenalty,
    );
  }
}

class MatchGoals {
  MatchGoals({
    required this.host,
    required this.guest,
  });
  late final int host;
  late final int guest;

  MatchGoals.fromJson(Map<String, dynamic> json) {
    host = json['host'];
    guest = json['guest'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['host'] = host;
    data['guest'] = guest;
    return data;
  }
}

class SetPoints1 {
  SetPoints1({
    required this.host,
    required this.guest,
  });
  late final int host;
  late final int guest;

  SetPoints1.fromJson(Map<String, dynamic> json) {
    host = json['host'];
    guest = json['guest'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['host'] = host;
    data['guest'] = guest;
    return data;
  }
}

class SetPoints2 {
  SetPoints2({
    required this.host,
    required this.guest,
  });
  late final int host;
  late final int guest;

  SetPoints2.fromJson(Map<String, dynamic> json) {
    host = json['host'];
    guest = json['guest'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['host'] = host;
    data['guest'] = guest;
    return data;
  }
}

class SetPoints3 {
  SetPoints3({
    required this.host,
    required this.guest,
  });
  late final int host;
  late final int guest;

  SetPoints3.fromJson(Map<String, dynamic> json) {
    host = json['host'];
    guest = json['guest'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['host'] = host;
    data['guest'] = guest;
    return data;
  }
}

class SetPoints4 {
  SetPoints4({
    required this.host,
    required this.guest,
  });
  late final int host;
  late final int guest;

  SetPoints4.fromJson(Map<String, dynamic> json) {
    host = json['host'];
    guest = json['guest'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['host'] = host;
    data['guest'] = guest;
    return data;
  }
}

class SetPoints5 {
  SetPoints5({
    required this.host,
    required this.guest,
  });
  late final int host;
  late final int guest;

  SetPoints5.fromJson(Map<String, dynamic> json) {
    host = json['host'];
    guest = json['guest'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['host'] = host;
    data['guest'] = guest;
    return data;
  }
}
