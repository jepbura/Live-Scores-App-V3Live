import 'package:v3l/feature/data/models/model.dart';

var liveScoreResponse = LiveScoreModel(leagues: [
  Leagues(id: 52, logo: "https://static.farakav.com/files/pictures/01381337.png", title: "دوستانه", sport: 1, link: null, dates: [
    Dates(date: "1401/07/02", matchIds: [
      "football-325929",
    ])
  ]),
], matches: [
  Matches(
    sport: 1,
    hostGoals: "3",
    guestGoals: "0",
    guestPoint: "",
    hostPoint: "",
    liveTime: null,
    hostLogo: null,
    guestLogo: null,
    hasPenalty: false,
    scheduledStartDate: " 9 خرداد 1402",
    scheduledStartTime: "20:30",
    predictionLink: null,
    predictionUrl: null,
    round: 36,
    penaltyGoals: null,
    matchGoals: MatchGoals(guest: 0, host: 3),
    videoId: null,
    referee: null,
    id: 325929,
    title: null,
    sportId: "football-325929",
    hostName: "آرژانتین",
    hostLink: null,
    guestName: "هندوراس",
    guestLink: null,
    hostId: 354,
    guestId: 456,
    status: 7,
    statusDescription: null,
    statusTitle: "نتیجه نهایی",
    isLive: false,
    time: "03:30",
    hasEvents: true,
    liveStreamSource: "",
    videoLink: "https://video.varzesh3.com/video/260884/",
    matchPageLink: "/football/match/325929/بازی-آرژانتین-هندوراس",
    matchApi: "https://livescore-api.varzesh3.com/v1.0/football/matches/325929",
    eventsApi: "https://livescore-api.varzesh3.com/v1.0/football/matches/325929/events",
    scheduledStartOn: "2022-09-24T00:00:00Z",
    stadium: null,
    setPoints1: SetPoints1(guest: 0, host: 0),
    setPoints2: SetPoints2(guest: 0, host: 0),
    setPoints3: SetPoints3(guest: 0, host: 0),
    setPoints4: SetPoints4(guest: 0, host: 0),
    setPoints5: SetPoints5(guest: 0, host: 0),
  )
], standings: const []);

final exceptedJson = {
  "leagues": [
    {
      "id": 52,
      "logo": "https://static.farakav.com/files/pictures/01381337.png",
      "title": "دوستانه",
      "sport": 1,
      "link": null,
      "dates": [
        {
          "date": "1401/07/02",
          "matchIds": ["football-325929"]
        }
      ]
    }
  ],
  "matches": [
    {
      "sport": 1,
      "hostGoals": "3",
      "guestGoals": "0",
      "guestPoint": "",
      "hostPoint": "",
      "liveTime": null,
      "hostLogo": null,
      "guestLogo": null,
      "hasPenalty": false,
      "scheduledStartDate": " 9 خرداد 1402",
      "scheduledStartTime": "20:30",
      "predictionLink": null,
      "predictionUrl": null,
      "round": 36,
      "penaltyGoals": null,
      "matchGoals": {
        "host": 3,
        "guest": 0
      },
      "videoId": null,
      "referee": null,
      "id": 325929,
      "title": null,
      "sportId": "football-325929",
      "hostName": "آرژانتین",
      "hostLink": null,
      "guestName": "هندوراس",
      "guestLink": null,
      "hostId": 354,
      "guestId": 456,
      "status": 7,
      "statusDescription": null,
      "statusTitle": "نتیجه نهایی",
      "isLive": false,
      "time": "03:30",
      "hasEvents": true,
      "liveStreamSource": "",
      "videoLink": "https://video.varzesh3.com/video/260884/",
      "matchPageLink": "/football/match/325929/بازی-آرژانتین-هندوراس",
      "matchApi": "https://livescore-api.varzesh3.com/v1.0/football/matches/325929",
      "eventsApi": "https://livescore-api.varzesh3.com/v1.0/football/matches/325929/events",
      "scheduledStartOn": "2022-09-24T00:00:00Z",
      "stadium": null,
      "setPoints1": {"host": 0, "guest": 0},
      "setPoints2": {"host": 0, "guest": 0},
      "setPoints3": {"host": 0, "guest": 0},
      "setPoints4": {"host": 0, "guest": 0},
      "setPoints5": {"host": 0, "guest": 0},
    }
  ],
  "standings": []
};
