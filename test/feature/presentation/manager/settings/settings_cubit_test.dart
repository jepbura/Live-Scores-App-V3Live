import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:v3l/core/core.dart';
import 'package:v3l/feature/presentation/presentation.dart';

class MockSettingsCubit extends MockCubit<SettingsState> implements SettingsCubit {}

void main() {
  late SettingsCubit settingsCubit;
  late SettingsCubit settingsCubit2;

  setUp(() {
    settingsCubit = SettingsCubit();
    settingsCubit2 = MockSettingsCubit();
  });

  tearDown(() {
    settingsCubit.close();
  });

  group("SettingsCubit test1 pageCounter = 1", () {
    blocTest(
      "Return SettingsState",
      build: () {
        return settingsCubit;
      },
      act: (cubit) => cubit.pageCounter(1),
      verify: (cubit) {
        // print("pageCounter is : ${cubit.state.pageCounter == 1}")
        log.d(
          "PageCounter is => ${cubit.state.pageCounter == 1}",
        );
      },
      expect: () => [
        isA<SettingsState>(),
      ],
    );

    blocTest<SettingsCubit, SettingsState>(
      "settingsCubit test2 pageCounter = 1",
      build: () {
        return settingsCubit;
      },
      act: (cubit) => cubit.pageCounter(1),
      expect: () => [
        const SettingsState(pageCounter: 1, themeColor: 0, appRoute: AppRoute.splashScreen),
      ],
    );

    blocTest<SettingsCubit, SettingsState>(
      "settingsCubit test appRoute = AppRoute.leagueScreen",
      build: () {
        return settingsCubit;
      },
      act: (cubit) => cubit.appRouteSet(AppRoute.leagueScreen),
      expect: () => [
        const SettingsState(pageCounter: 0, themeColor: 0, appRoute: AppRoute.leagueScreen),
      ],
    );

    test("settingsCubit test themeColor = 3 - pageCounter = 6 - appRoute: AppRoute.leagueScreen", () {
      whenListen(settingsCubit2, Stream.fromIterable([const SettingsState(themeColor: 3, pageCounter: 6, appRoute: AppRoute.leagueScreen)]));
      expectLater(
          settingsCubit2.stream, emitsInOrder(<SettingsState>[const SettingsState(themeColor: 3, pageCounter: 6, appRoute: AppRoute.leagueScreen)]));
    });
  });
}
