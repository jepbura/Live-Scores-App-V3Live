import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rive/rive.dart';
import 'package:shamsi_date/shamsi_date.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:wear/wear.dart';
import '../../../../../core/core.dart';
import '../../../../../di/di.dart';
import '../../../../../generated/assets.dart';
import '../../../../data/data_sources/datasources.dart';
import '../../../presentation.dart';

///*********************************************
///*********************************************

class LeaguePage extends StatefulWidget {
  const LeaguePage({
    Key? key,
  }) : super(key: key);

  @override
  State<LeaguePage> createState() => _LeaguePageState();
}

class _LeaguePageState extends State<LeaguePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final controller = PageController(viewportFraction: 0.8, keepPage: true);
  int _selectIndex = 0;
  late Timer timer;
  late Timer timer2;
  bool loading = true;
  bool liveLoading = true;
  WearShape? wearShape;

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   // context
  //   //     .read<LiveScoreCubit>()
  //   //     .getLiveScoreData(NullParams());
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      _toggle();
      if (!sl<Socket>().getConnectCheck()) {
        Future.delayed(const Duration(seconds: 2), () {
          if (!sl<Socket>().getConnectCheck()) {
            context.read<LiveScoreCubit>().getLiveScoreData(NullParams());
          }
        });
      }
    });
    timer2 = Timer.periodic(const Duration(seconds: 1), (timer) {
      _toggle2();
    });
  }

  String format(Date d) {
    final f = d.formatter;
    return '${f.yyyy}/${f.mm}/${f.dd}';
  }

  _toggle() {
    setState(() {
      loading = !loading;
    });
  }

  _toggle2() {
    setState(() {
      liveLoading = !liveLoading;
    });
  }

  String format1(Date d) {
    final f = d.formatter;
    return f.wN;
  }

  @override
  void dispose() {
    controller.dispose();
    timer.cancel();
    timer2.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Parent(
      key: _scaffoldKey,
      child: WatchShape(
        builder: (BuildContext context, WearShape shape, Widget? child) {
          // return child!;
          return Stack(
            alignment: Alignment.center,
            children: [
              child!,
              // shape == WearShape.square
              //     ? Positioned(
              //         top: 0,
              //         left: Dimens.space2,
              //         child: IconButton(
              //           splashColor: Colors.transparent,
              //           highlightColor: Colors.transparent,
              //           iconSize: 24,
              //           icon: const Icon(
              //             Icons.arrow_back_ios_new,
              //           ),
              //           onPressed: () {
              //             context.goToReplace(AppRoute.homeScreen);
              //           },
              //         ))
              //     : Positioned(
              //         top: Responsive.isWare(context) ? 0 : Dimens.space16,
              //         child: IconButton(
              //           splashColor: Colors.transparent,
              //           highlightColor: Colors.transparent,
              //           iconSize: 24,
              //           icon: const Icon(
              //             Icons.arrow_back_ios_new,
              //           ),
              //           onPressed: () {
              //             context.goToReplace(AppRoute.homeScreen);
              //           },
              //         )),
              Positioned(
                  bottom: Dimens.space16,
                  child: AnimatedSwitcher(
                    duration: const Duration(seconds: 1),
                    switchInCurve: Curves.easeInOut,
                    switchOutCurve: Curves.easeInOut,
                    child: (loading)
                        ? Center(
                            key: const ValueKey<int>(0),
                            child: Text(
                              format(Jalali.now()),
                              style: const TextStyle(fontFamily: "En"),
                            ),
                          )
                        : Center(
                            key: const ValueKey<int>(1),
                            child: Text(
                              format1(Jalali.now()),
                            ),
                          ),
                  )),
            ],
          );
        },
        child: AmbientMode(builder: (BuildContext context, WearMode mode, Widget? child) {
          return BlocBuilder<LiveScoreCubit, LiveScoreState>(
            builder: (context, state) {
              if (state is LiveScoreInitial) {
                return const Center(
                  key: Key("liveScoreInitial_league_center"),
                  child: RiveAnimation.asset(
                    Assets.basketball,
                    fit: BoxFit.cover,
                  ),
                );
              } else if (state is LiveScoreData && state.status == ConnectionStatus.success) {
                return Center(
                  key: const Key("success_league_center_builder"),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: Dimens.space225,
                        width: Dimens.space225,
                        child: PageView.builder(
                          scrollDirection: Axis.vertical,
                          controller: controller,
                          onPageChanged: (index) {
                            setState(() {
                              _selectIndex = index;
                            });
                          },
                          itemCount: state.leagueId?.length,
                          itemBuilder: (_, index) {
                            var scale = _selectIndex == index ? 1.0 : 0.5;
                            DateTime dateTime = DateTime.now();
                            String matchDate = '-';
                            if (state.selectMatches![index % state.selectMatches!.length].scheduledStartOn != "") {
                              dateTime = DateTime.parse(state.selectMatches![index % state.selectMatches!.length].scheduledStartOn.toString());
                              matchDate = format(Jalali.fromDateTime(dateTime));
                            }
                            return TweenAnimationBuilder(
                                tween: Tween(begin: scale, end: scale),
                                duration: const Duration(milliseconds: 350),
                                curve: Curves.ease,
                                child: Container(
                                  height: Dimens.space150,
                                  width: Dimens.space150,
                                  // padding: const EdgeInsets.all(4),
                                  margin: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                                      border: Border.all(
                                        color: Theme.of(context).backgroundColor == const Color(0xffffffff) ? Colors.black : const Color(0xff3f51b5),
                                        width: Dimens.space2,
                                      )),
                                  child: Center(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            SizedBox(
                                              width: Dimens.space100,
                                              child: Center(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Text(matchDate,
                                                        maxLines: 1,
                                                        overflow: TextOverflow.ellipsis,
                                                        style: const TextStyle(
                                                          fontSize: 8,
                                                          fontFamily: "En",
                                                          fontWeight: FontWeight.w600,
                                                        )),
                                                    Text(
                                                        state.selectMatches![index % state.selectMatches!.length].time != null &&
                                                                state.selectMatches![index % state.selectMatches!.length].time != ""
                                                            ? state.selectMatches![index % state.selectMatches!.length].time.toString()
                                                            : "-",
                                                        maxLines: 1,
                                                        overflow: TextOverflow.ellipsis,
                                                        style: const TextStyle(
                                                          fontSize: 10,
                                                          fontFamily: "En",
                                                          fontWeight: FontWeight.w600,
                                                        )),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: Dimens.space50,
                                              child: Stack(
                                                alignment: Alignment.center,
                                                children: [
                                                  if (state.selectMatches![index % state.selectMatches!.length].isLive != null &&
                                                      state.selectMatches![index % state.selectMatches!.length].isLive == true)
                                                    Positioned(
                                                        top: 0,
                                                        right: 0,
                                                        child: AnimatedSwitcher(
                                                          duration: const Duration(milliseconds: 500),
                                                          switchInCurve: Curves.easeInOut,
                                                          switchOutCurve: Curves.easeInOut,
                                                          child: (liveLoading)
                                                              ? const Icon(
                                                                  key: ValueKey<int>(2),
                                                                  Icons.do_not_disturb_on_total_silence,
                                                                  size: 6,
                                                                  color: Colors.green,
                                                                )
                                                              : Container(),
                                                        )),
                                                  Text(
                                                      state.selectMatches![index % state.selectMatches!.length].liveTime != null &&
                                                              state.selectMatches![index % state.selectMatches!.length].liveTime != ""
                                                          ? "${state.selectMatches![index % state.selectMatches!.length].liveTime}"
                                                          : "-",
                                                      maxLines: 1,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                        fontFamily: "En",
                                                        fontWeight: FontWeight.w800,
                                                      )),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: Dimens.space8,
                                        ),
                                        SizedBox(
                                          width: Dimens.space100,
                                          child: Center(
                                            child: Text(
                                                state.selectMatches![index % state.selectMatches!.length].statusTitle != null &&
                                                        state.selectMatches![index % state.selectMatches!.length].statusTitle != ""
                                                    ? state.selectMatches![index % state.selectMatches!.length].statusTitle.toString()
                                                    : "",
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w600,
                                                )),
                                          ),
                                        ),
                                        SizedBox(
                                          height: Dimens.space8,
                                        ),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  width: Dimens.space50,
                                                  child: Center(
                                                    child: Tooltip(
                                                      message: state.selectMatches![index % state.selectMatches!.length].hostName != null &&
                                                              state.selectMatches![index % state.selectMatches!.length].hostName != ""
                                                          ? state.selectMatches![index % state.selectMatches!.length].hostName.toString()
                                                          : "-",
                                                      child: Text(state.selectMatches![index % state.selectMatches!.length].hostName.toString(),
                                                          maxLines: 1,
                                                          overflow: TextOverflow.ellipsis,
                                                          style: const TextStyle(
                                                            fontSize: 10,
                                                            fontWeight: FontWeight.w600,
                                                          )),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: Dimens.space50,
                                                  child: Center(
                                                    child: Text(
                                                        state.selectMatches![index % state.selectMatches!.length].hostGoals != null &&
                                                                state.selectMatches![index % state.selectMatches!.length].hostGoals != ""
                                                            ? state.selectMatches![index % state.selectMatches!.length].hostGoals.toString()
                                                            : state.selectMatches![index % state.selectMatches!.length].hostPoint != null &&
                                                                    state.selectMatches![index % state.selectMatches!.length].hostPoint != ""
                                                                ? state.selectMatches![index % state.selectMatches!.length].hostPoint.toString()
                                                                : "-",
                                                        maxLines: 1,
                                                        overflow: TextOverflow.ellipsis,
                                                        style: const TextStyle(
                                                          fontSize: 16,
                                                          fontFamily: "En",
                                                          fontWeight: FontWeight.w800,
                                                        )),
                                                  ),
                                                )
                                              ],
                                            ),
                                            Container(
                                              margin: const EdgeInsets.all(4),
                                              child: Image.asset(Assets.versus, width: Dimens.space24),
                                            ),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  width: Dimens.space50,
                                                  child: Center(
                                                    child: Tooltip(
                                                      message: state.selectMatches![index % state.selectMatches!.length].guestName.toString(),
                                                      child: Text(
                                                          state.selectMatches![index % state.selectMatches!.length].guestName != null &&
                                                                  state.selectMatches![index % state.selectMatches!.length].guestName != ""
                                                              ? state.selectMatches![index % state.selectMatches!.length].guestName.toString()
                                                              : "-",
                                                          maxLines: 1,
                                                          overflow: TextOverflow.ellipsis,
                                                          style: const TextStyle(
                                                            fontSize: 10,
                                                            fontWeight: FontWeight.w600,
                                                          )),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: Dimens.space50,
                                                  child: Center(
                                                    child: Text(
                                                        state.selectMatches![index % state.selectMatches!.length].guestGoals != null &&
                                                                state.selectMatches![index % state.selectMatches!.length].guestGoals != ""
                                                            ? state.selectMatches![index % state.selectMatches!.length].guestGoals.toString()
                                                            : state.selectMatches![index % state.selectMatches!.length].guestPoint != null &&
                                                                    state.selectMatches![index % state.selectMatches!.length].guestPoint != ""
                                                                ? state.selectMatches![index % state.selectMatches!.length].guestPoint.toString()
                                                                : "-",
                                                        maxLines: 1,
                                                        overflow: TextOverflow.ellipsis,
                                                        style: const TextStyle(
                                                          fontSize: 16,
                                                          fontFamily: "En",
                                                          fontWeight: FontWeight.w800,
                                                        )),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                builder: (context, value, child) {
                                  return Transform.scale(
                                    scale: value,
                                    child: child,
                                  );
                                });
                          },
                        ),
                      ),
                      SizedBox(width: Dimens.space4),
                      SmoothPageIndicator(
                          controller: controller,
                          axisDirection: Axis.vertical,
                          count: state.leagueId!.length,
                          effect: const ScrollingDotsEffect(
                            activeStrokeWidth: 2.6,
                            activeDotScale: 1.3,
                            maxVisibleDots: 5,
                            radius: 8,
                            spacing: 10,
                            dotHeight: 12,
                            dotWidth: 12,
                          )),
                    ],
                  ),
                );
              } else {
                return const Center(
                  key: Key("Error_league_center"),
                  child: RiveAnimation.asset(
                    Assets.E404,
                    fit: BoxFit.cover,
                  ),
                );
                // return Text(
                //   'Mode: ${mode == WearMode.active ? 'Active' : 'Ambient'}',
                // );
              }
            },
          );
        }),
      ),
    );
  }
}
