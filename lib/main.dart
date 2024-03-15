import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/core.dart';
import 'di/di.dart';
import 'feature/data/data_sources/datasources.dart';
import 'feature/presentation/presentation.dart';

Future<void> main() async {
  /// Register Service locator
  await serviceLocator();

  WidgetsFlutterBinding.ensureInitialized();

  runZonedGuarded(
    /// Lock device orientation to portrait
    () => SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ],
    ).then((_) async {
      /// Load SharedPref before load My App Widget
      SharedPreferences.getInstance().then((value) {
        initPrefManager(value);
        runApp(const MyApp());
      });
    }),
    (error, stackTrace) async {
      // FirebaseCrashlytics.instance.recordError(error, stackTrace);
    },
  );

  // await SharedPreferences.getInstance().then((value) {
  //   initPrefManager(value);
  //   runApp(const MyApp());
  // });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => sl<LiveScoreCubit>(),
          ),
          BlocProvider(
            create: (context) => SettingsCubit(),
          ),
        ],
        child: ScreenUtilInit(
            designSize: const Size(300, 300),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (context, state) =>
                BlocBuilder<SettingsCubit, SettingsState>(
                    builder: (context, state) => MaterialApp(
                          debugShowCheckedModeBanner: false,
                          title: 'V3Live',
                          // theme: buildShrineTheme(),
                          theme: themeLight,
                          darkTheme: themeDark,
                          themeMode:

                              /// Check if theme is light or dark first before srart
                              sl<PrefManager>().theme ==
                                      ActiveTheme.light.description
                                  ? ThemeMode.light
                                  : sl<PrefManager>().theme ==
                                          ActiveTheme.dark.description
                                      ? ThemeMode.dark

                                      /// Set default theme is System
                                      : ThemeMode.system,
                          locale: Locale(sl<PrefManager>().locale),
                          supportedLocales: L10n.all,
                          localizationsDelegates: const [
                            Strings.delegate,
                            GlobalMaterialLocalizations.delegate,
                            GlobalWidgetsLocalizations.delegate,
                            GlobalCupertinoLocalizations.delegate,
                          ],
                          builder: (BuildContext context, Widget? child) {
                            final MediaQueryData data = MediaQuery.of(context);
                            return MediaQuery(
                              data: data.copyWith(
                                textScaleFactor: 1,
                                alwaysUse24HourFormat: true,
                              ),
                              child: child!,
                            );
                          },
                          onGenerateRoute: (RouteSettings settings) {
                            final routes =
                                AppRoute.getRoutes(settings: settings);
                            final WidgetBuilder? builder =
                                routes[settings.name];

                            return MaterialPageRoute(
                              builder: (context) => builder!(context),
                              settings: settings,
                            );
                          },
                          initialRoute: AppRoute.splashScreen,
                        ))));
  }
}
