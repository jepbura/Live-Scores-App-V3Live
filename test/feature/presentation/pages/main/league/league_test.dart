import 'dart:convert';
import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rive/rive.dart';
import 'package:v3l/core/core.dart';
import 'package:v3l/di/di.dart';
import 'package:v3l/feature/data/data_sources/datasources.dart';
import 'package:v3l/feature/data/models/model.dart';
import 'package:v3l/feature/domain/domain.dart';
import 'package:v3l/feature/presentation/presentation.dart';

import '../../../../../helpers/json_reader.dart';
import '../../../../../helpers/paths.dart';

class MockSettingsCubit extends MockCubit<SettingsState> implements SettingsCubit {}

class MockLiveScoreCubit extends MockCubit<LiveScoreState> implements LiveScoreCubit {}

class FakeLiveScoreState extends Fake implements LiveScoreState {}

void main() {
  late SettingsCubit settingsCubit;
  late LiveScoreCubit liveScoreCubit;
  late LiveScoreEntity liveScoreModel;

  setUpAll(() {
    HttpOverrides.global = null;
    registerFallbackValue(FakeLiveScoreState());
    registerFallbackValue(NullParams());
  });

  setUp(() async {
    await serviceLocator(isUnitTest: true);
    settingsCubit = MockSettingsCubit();
    liveScoreCubit = MockLiveScoreCubit();
    liveScoreModel = LiveScoreModel.fromJson(json.decode(jsonReader(dioLiveScoreData)));
  });

  Widget rootWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => liveScoreCubit,
        ),
        BlocProvider(
          create: (context) => settingsCubit,
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(300, 300),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, __) => MaterialApp(
          localizationsDelegates: const [
            Strings.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          locale: Locale(sl<PrefManager>().locale),
          home: body,
        ),
      ),
    );
  }

  testWidgets(
    'renders LeaguePage for LiveScoreInitial',
    (tester) async {
      when(() => settingsCubit.state).thenReturn(const SettingsState(themeColor: 0, pageCounter: 0, appRoute: AppRoute.leagueScreen));
      when(() => liveScoreCubit.state).thenReturn(LiveScoreInitial());
      await tester.pumpWidget(rootWidget(const LeaguePage()));
      // expect(find.byKey(const Key("liveScoreInitial_center")), findsOneWidget);
      expect(find.descendant(of: find.byKey(const Key('liveScoreInitial_league_center')), matching: find.byType(RiveAnimation)), findsOneWidget);
    },
  );

  testWidgets(
    'renders LeaguePage for Error LiveScoreData',
    (tester) async {
      when(() => settingsCubit.state).thenReturn(const SettingsState(themeColor: 0, pageCounter: 0, appRoute: AppRoute.leagueScreen));
      when(() => liveScoreCubit.state).thenReturn(const LiveScoreData(status: ConnectionStatus.failure, message: "ServerFailure"));
      await tester.pumpWidget(rootWidget(const LeaguePage()));
      expect(find.descendant(of: find.byKey(const Key('Error_league_center')), matching: find.byType(RiveAnimation)), findsOneWidget);
    },
  );

  testWidgets(
    'renders LeaguePage for Success LiveScoreData page 1',
    (tester) async {
      List<Matches> selectMatches = [];
      List<String>? matchIds = liveScoreModel.leagues?[0].dates[0].matchIds;

      liveScoreModel.matches?.forEach((element) {
        for (var element2 in matchIds!) {
          if (element.sportId != null && element2 == element.sportId) {
            selectMatches.add(element);
          }
        }
      });

      when(() => settingsCubit.state).thenReturn(const SettingsState(themeColor: 0, pageCounter: 0, appRoute: AppRoute.leagueScreen));
      when(() => liveScoreCubit.state).thenReturn(LiveScoreData(
          status: ConnectionStatus.success, message: "Socket send success", data: liveScoreModel, leagueId: matchIds, selectMatches: selectMatches));
      await tester.pumpWidget(rootWidget(const LeaguePage()));
      var liveScoreState = liveScoreCubit.state as LiveScoreData;

      expect(
          find.descendant(
              of: find.byKey(const Key('success_league_center_builder')), matching: find.text(liveScoreState.selectMatches?[0].hostName ?? "")),
          findsOneWidget);
    },
  );
}
