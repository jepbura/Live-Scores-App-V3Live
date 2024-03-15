import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wear/wear.dart';
import '../../../../core/core.dart';
import '../../../../di/di.dart';
import '../../../../generated/assets.dart';
import '../../../data/data_sources/datasources.dart';
import '../../presentation.dart';

///*********************************************
///*********************************************

class GuidePage extends StatefulWidget {
  const GuidePage({
    Key? key,
  }) : super(key: key);

  @override
  State<GuidePage> createState() => _GuidePageState();
}

class _GuidePageState extends State<GuidePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late final Timer timer;
  bool up = false;
  bool up2 = false;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      _toggle();
    });
    Future.delayed(const Duration(milliseconds: 1500), () {
      _toggle2();
    });
  }

  _toggle() {
    setState(() {
      up = !up;
    });
  }

  _toggle2() {
    setState(() {
      up2 = !up2;
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Parent(
      key: _scaffoldKey,
      child: WatchShape(
        builder: (BuildContext context, WearShape shape, Widget? child) {
          return Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                  bottom: Dimens.space4,
                  child: TextButton(
                    onPressed: () {
                      sl<PrefManager>().isFirst = true;
                      context.read<SettingsCubit>().appRouteSet(AppRoute.guideScreen);
                      context.goToReplace(AppRoute.homeScreen);
                    },
                    child: Text(
                      Strings.of(context)!.ok,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).backgroundColor == const Color(0xffffffff) ? Colors.black : const Color(0xff3f51b5)),
                    ),
                  )),
              child!,
            ],
          );
        },
        child: AmbientMode(builder: (BuildContext context, WearMode mode, Widget? child) {
          return Center(
              child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: Dimens.space150,
                padding: const EdgeInsets.all(4),
                margin: const EdgeInsets.all(4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedContainer(
                      padding: const EdgeInsets.all(10.0),
                      curve: Curves.decelerate,
                      duration: const Duration(milliseconds: 500),
                      // Animation speed
                      transform: Transform.translate(
                        offset: Offset(0, up2 == true ? 0 : -50), // Change -100 for the y offset
                      ).transform,
                      child: const Image(image: AssetImage(Assets.down), width: 35),
                    ),
                    Text(Strings.of(context)!.theme),
                    SizedBox(
                      height: Dimens.space6,
                    ),
                    Text(
                      Strings.of(context)!.themeGuide,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 6),
                    ),
                  ],
                ),
              ),
              Container(
                height: Dimens.space150,
                padding: const EdgeInsets.all(4),
                margin: const EdgeInsets.all(4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedContainer(
                      padding: const EdgeInsets.all(10.0),
                      curve: up != true ? Curves.bounceOut : Curves.decelerate,
                      duration: const Duration(milliseconds: 500),
                      // Animation speed
                      transform: Transform.translate(
                        offset: Offset(0, up == true ? -50 : 0), // Change -100 for the y offset
                      ).transform,
                      child: const Image(image: AssetImage(Assets.down), width: 35),
                    ),
                    Text(Strings.of(context)!.back),
                    SizedBox(
                      height: Dimens.space6,
                    ),
                    Text(
                      Strings.of(context)!.backGuide,
                      style: const TextStyle(fontSize: 6),
                    ),
                  ],
                ),
              ),
            ],
          ));
        }),
      ),
    );
  }
}
