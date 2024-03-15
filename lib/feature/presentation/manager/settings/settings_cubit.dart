import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../presentation.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(const SettingsState(pageCounter: 0, themeColor: 0, appRoute: AppRoute.splashScreen));

  void reloadWidget() {
    emit(SettingsState(pageCounter: state.pageCounter, themeColor: Random().nextInt(1000), appRoute: state.appRoute));
  }

  void pageCounter(index) {
    emit(SettingsState(pageCounter: index, themeColor: state.themeColor, appRoute: state.appRoute));
  }

  void appRouteSet(appRoute) {
    emit(SettingsState(pageCounter: state.pageCounter, themeColor: state.themeColor, appRoute: appRoute));
  }
}
