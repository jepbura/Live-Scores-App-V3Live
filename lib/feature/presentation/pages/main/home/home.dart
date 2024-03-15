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

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late PageController controller;
  late int _selectIndex;
  late final Timer timer;
  bool loading = true;

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

    _selectIndex = context.read<SettingsCubit>().state.pageCounter!;
    controller = PageController(viewportFraction: 0.8, keepPage: true, initialPage: context.read<SettingsCubit>().state.pageCounter!);

    timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      // print("dddddddddddddddddd");
      _toggle();
      // print("aaaaaaaaaaaaaa ${sl<Socket>().getConnectCheck()} ::: ");
      // if (!sl<Socket>().getConnectCheck()) {
      //   Future.delayed(const Duration(seconds: 2), () {
      //     if (!sl<Socket>().getConnectCheck()) {
      //       context.read<LiveScoreCubit>().getLiveScoreData(NullParams());
      //     }
      //   });
      // }
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

  String format1(Date d) {
    final f = d.formatter;
    return f.wN;
  }

  @override
  void dispose() {
    controller.dispose();
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Parent(
      key: _scaffoldKey,
      child: WatchShape(
        builder: (BuildContext context, WearShape shape, Widget? child) {
          // return child!;
          // return Column(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: <Widget>[
          //     // Text(
          //     //   'Shape: ${shape == WearShape.round ? "round" : 'square'}',
          //     // ),
          //     child!,
          //   ],
          // );
          return Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                  top: Dimens.space16,
                  child: const Text(
                    "VARZESH3",
                    style: TextStyle(fontFamily: "En"),
                  )),
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
              child!,
            ],
          );
        },
        child: AmbientMode(builder: (BuildContext context, WearMode mode, Widget? child) {
          return BlocBuilder<LiveScoreCubit, LiveScoreState>(
            builder: (context, state) {
              if (state is LiveScoreInitial) {
                return const Center(
                  key: Key("liveScoreInitial_center"),
                  child: RiveAnimation.asset(
                    Assets.basketball,
                    fit: BoxFit.cover,
                  ),
                );
              } else if (state is LiveScoreData && state.status == ConnectionStatus.success) {
                return Center(
                  key: const Key("success_center_builder"),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: Dimens.space225,
                        width: Dimens.space200,
                        child: PageView.builder(
                          scrollDirection: Axis.vertical,
                          controller: controller,
                          onPageChanged: (index) {
                            setState(() {
                              _selectIndex = index;
                            });
                            context.read<SettingsCubit>().pageCounter(index);
                          },
                          itemCount: state.data?.leagues?.length,
                          itemBuilder: (_, index) {
                            var scale = _selectIndex == index ? 1.0 : 0.5;
                            return TweenAnimationBuilder(
                                key: const Key("success_pageView_builder"),
                                tween: Tween(begin: scale, end: scale),
                                duration: const Duration(milliseconds: 350),
                                curve: Curves.ease,
                                child: Center(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: Dimens.space175,
                                        child: Center(
                                          child: Tooltip(
                                            message: state.data!.leagues![index % state.data!.leagues!.length].title,
                                            child: Text(state.data!.leagues![index % state.data!.leagues!.length].title,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w600,
                                                )),
                                          ),
                                        ),
                                      ),
                                      ConstrainedBox(
                                          constraints: const BoxConstraints(maxWidth: 300, maxHeight: 300),
                                          child: Container(
                                            height: Dimens.space150,
                                            width: Dimens.space150,
                                            padding: const EdgeInsets.all(4),
                                            // margin: const EdgeInsets.all(4),
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.white,
                                                side: BorderSide(
                                                  width: Dimens.space2,
                                                  color: Theme.of(context).backgroundColor == const Color(0xffffffff)
                                                      ? Colors.black
                                                      : const Color(0xff3f51b5),
                                                ),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(Dimens.space100),
                                                ),
                                              ),
                                              onPressed: () {
                                                context.read<SettingsCubit>().appRouteSet(AppRoute.leagueScreen);
                                                context
                                                    .read<LiveScoreCubit>()
                                                    // .leagueSelected(state.data!.leagues![index % state.data!.leagues!.length].dates[0].matchIds);
                                                    .leagueSelected(state.data!.leagues![index % state.data!.leagues!.length].dates);
                                                context.goToReplace(AppRoute.leagueScreen);
                                              },
                                              child: Image.network(
                                                state.data?.leagues?[index % state.data!.leagues!.length].logo ?? "",
                                                fit: BoxFit.cover,
                                                // height: Dimens.space50,
                                                width: Dimens.space75,
                                              ),
                                            ),
                                          )),
                                    ],
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
                      const SizedBox(height: 16),
                      SmoothPageIndicator(
                          controller: controller,
                          axisDirection: Axis.vertical,
                          count: state.data?.leagues?.length ?? 0,
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
                  key: Key("Error_center"),
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
