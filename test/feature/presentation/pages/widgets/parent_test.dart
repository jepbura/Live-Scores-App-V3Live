import 'dart:io';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:v3l/core/core.dart';
import 'package:v3l/di/di.dart';
import 'package:v3l/feature/data/data_sources/datasources.dart';
import 'package:v3l/feature/presentation/presentation.dart';

class MockSettingsCubit extends MockCubit<SettingsState> implements SettingsCubit {}

void main() {
  late SettingsCubit settingsCubit;

  setUpAll(() {
    HttpOverrides.global = null;
  });

  setUp(() async {
    await serviceLocator(isUnitTest: true);
    settingsCubit = MockSettingsCubit();
  });

  Widget rootWidget(Widget body) {
    return BlocProvider<SettingsCubit>.value(
      value: settingsCubit,
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
    'Gesture detector on longPress theme change ',
    (tester) async {
      // when(() => settingsCubit.state).thenReturn(const SettingsState(pageCounter: 0, themeColor: 1, appRoute: AppRoute.homeScreen));

      await tester.pumpWidget(rootWidget(const Parent(isUnitTest: true)));
      final gestureDetector = find.byKey(const Key("gesture_detector")).last;
      await tester.longPress(gestureDetector);
      await tester.pumpAndSettle();

      verify(() => settingsCubit.reloadWidget()).called(1);
    },
  );

  testWidgets(
    'Gesture detector on double tab back page',
    (tester) async {
      await tester.pumpWidget(rootWidget(const Parent(isUnitTest: true)));
      final gestureDetector = find.byKey(const Key("gesture_detector")).last;
      await tester.tap(gestureDetector);
      await tester.pumpAndSettle();
      await tester.pump(kDoubleTapMinTime);
      await tester.tap(gestureDetector);
      await tester.pumpAndSettle();
      expect(find.text("Test success"), findsOneWidget);
    },
  );
}
