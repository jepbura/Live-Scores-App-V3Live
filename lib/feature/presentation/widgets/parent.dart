import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:v3l/core/core.dart';

import '../../../di/di.dart';
import '../../data/data_sources/datasources.dart';
import '../presentation.dart';

///*********************************************
///*********************************************
/// © 2020 | All Right Reserved
class Parent extends StatefulWidget {
  final Widget? child;
  final PreferredSize? appBar;
  final bool avoidBottomInset;
  final Widget? floatingButton;
  final Widget? bottomNavigation;
  final Widget? drawer;
  final Widget? endDrawer;
  final Color? backgroundColor;
  final Key? scaffoldKey;
  final bool extendBodyBehindAppBar;
  final bool isUnitTest;

  const Parent({
    Key? key,
    this.isUnitTest = false,
    this.child,
    this.appBar,
    this.avoidBottomInset = true,
    this.floatingButton,
    this.backgroundColor,
    this.bottomNavigation,
    this.drawer,
    this.scaffoldKey,
    this.endDrawer,
    this.extendBodyBehindAppBar = false,
  }) : super(key: key);

  @override
  State<Parent> createState() => _ParentState();
}

class _ParentState extends State<Parent> {
  late SettingsCubit _settingsCubit;
  late ActiveTheme activeTheme;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _settingsCubit = context.read<SettingsCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: const Key("gesture_detector"),
      behavior: HitTestBehavior.translucent,
      onDoubleTap: () {
        if (!widget.isUnitTest && _settingsCubit.state.appRoute != AppRoute.homeScreen && _settingsCubit.state.appRoute != AppRoute.guideScreen) {
          _settingsCubit.appRouteSet(AppRoute.homeScreen);
          context.goToReplace(AppRoute.homeScreen);
        } else if (widget.isUnitTest) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Test success"),
            duration: Duration(seconds: 1),
          ));
        }
      },
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      onLongPress: () {
        if (sl<PrefManager>().theme == ActiveTheme.light.description) {
          activeTheme = ActiveTheme.dark;
        } else if (sl<PrefManager>().theme == ActiveTheme.dark.description) {
          activeTheme = ActiveTheme.light;
        } else {
          activeTheme = ActiveTheme.dark;
        }

        /// Update theme status in sharedPref
        sl<PrefManager>().theme = activeTheme.description;

        /// Reload theme
        _settingsCubit.reloadWidget();
      },
      child: Scaffold(
        key: widget.scaffoldKey,
        backgroundColor: widget.backgroundColor,
        resizeToAvoidBottomInset: widget.avoidBottomInset,
        extendBodyBehindAppBar: widget.extendBodyBehindAppBar,
        appBar: widget.appBar,
        body: widget.child,
        drawer: widget.drawer,
        endDrawer: widget.endDrawer,
        floatingActionButton: widget.floatingButton,
        bottomNavigationBar: widget.bottomNavigation,
      ),
    );
  }
}
