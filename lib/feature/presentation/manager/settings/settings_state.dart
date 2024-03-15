part of 'settings_cubit.dart';

class SettingsState extends Equatable {
  final int? pageCounter;
  final int? themeColor;
  final String? appRoute;

  const SettingsState({this.pageCounter, this.themeColor, this.appRoute});

  @override
  // TODO: implement props
  List<Object?> get props => [pageCounter, themeColor, appRoute];

  SettingsState copyWith({
    int? pageCounter,
    int? themeColor,
    String? appRoute,
  }) {
    return SettingsState(
      pageCounter: pageCounter ?? this.pageCounter,
      themeColor: themeColor ?? this.themeColor,
      appRoute: appRoute ?? this.appRoute,
    );
  }
}
