import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:rive/rive.dart';
import '../../../../core/core.dart';
import '../../../../di/di.dart';
import '../../../../generated/assets.dart';
import '../../../data/data_sources/datasources.dart';
import '../../presentation.dart';

///*********************************************

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  // late final Socket socket;
  bool loading = true;
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
  );

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
    // socket = sl<Socket>();
    // socket.send(ConnectSendApi(protocol: "json", version: 1));
    // sl<Socket>().send(apiParams: ConnectSendApi(protocol: "json", version: 1), context: context);

    context.read<LiveScoreCubit>().getLiveScoreData(NullParams());
    Future.delayed(const Duration(seconds: 5), () {
      _initData();
    });
    Future.delayed(const Duration(milliseconds: 1500), () {
      _toggle();
    });
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  void _initData() {
    if (sl<PrefManager>().isFirst) {
      context.read<SettingsCubit>().appRouteSet(AppRoute.homeScreen);
      context.goToReplace(AppRoute.homeScreen);
    } else {
      context.read<SettingsCubit>().appRouteSet(AppRoute.guideScreen);
      context.goToReplace(AppRoute.guideScreen);
    }
  }

  _toggle() {
    setState(() {
      loading = !loading;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Parent(
      scaffoldKey: _scaffoldKey,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              // color: const Color(0x0044475a),
              width: Dimens.space100,
              height: Dimens.space100,
              // child: SvgPicture.asset(
              //   // Images.icLogo,
              //   Assets.iconsLogo,
              //   width: context.widthInPercent(60),
              // ),
              child: const RiveAnimation.asset(
                Assets.V3Live,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: Dimens.space12,
            ),
            AnimatedSwitcher(
              duration: const Duration(seconds: 1),
              switchInCurve: Curves.easeInOut,
              switchOutCurve: Curves.easeInOut,
              child: (loading)
                  ? const Center(
                      key: ValueKey<int>(0),
                      child: Text(
                        "www.varzesh3.com",
                        style: TextStyle(fontFamily: "En", fontSize: 12),
                      ),
                    )
                  : const Center(
                      key: ValueKey<int>(1),
                      child: Text(
                        "www.bura.dev",
                        style: TextStyle(fontFamily: "En", fontSize: 12),
                      ),
                    ),
            ),
            SizedBox(
              height: Dimens.space6,
            ),
            Text(
              "v${_packageInfo.version}",
              style: const TextStyle(
                fontFamily: "En",
                fontSize: 6,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
