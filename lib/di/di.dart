import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../feature/data/data.dart';
import '../feature/data/data_sources/datasources.dart';
import '../feature/domain/domain.dart';
import '../feature/presentation/presentation.dart';

GetIt sl = GetIt.instance;

Future<void> serviceLocator({bool isUnitTest = false}) async {
  /// For unit testing only
  if (isUnitTest) {
    WidgetsFlutterBinding.ensureInitialized();
    await sl.reset();
    // ignore: invalid_use_of_visible_for_testing_member
    SharedPreferences.setMockInitialValues({});
    await SharedPreferences.getInstance().then((value) {
      initPrefManager(value);
    });
    sl.registerSingleton<DioClient>(DioClient(isUnitTest: true));
    sl.registerSingleton<Socket>(Socket());
    dataSources();
    repositories();
    useCase();
    cubit();
  } else {
    sl.registerSingleton<DioClient>(DioClient());
    sl.registerSingleton<Socket>(Socket());
    dataSources();
    repositories();
    useCase();
    cubit();
  }
}

// Live Score prefManager
void initPrefManager(SharedPreferences initPrefManager) {
  sl.registerLazySingleton<PrefManager>(() => PrefManager(initPrefManager));
}

/// Live Score dataSources
void dataSources() {
  sl.registerLazySingleton<DioDatasource>(
    () => DioDatasourceImpl(sl()),
  );
}

/// Live Score repositories
void repositories() {
  sl.registerLazySingleton<DioRepository>(() => DioRepositoryImpl(sl()));
}

void useCase() {
  /// Live Score
  sl.registerLazySingleton(() => GetLiveScore(sl()));
}

void cubit() {
  sl.registerFactory(() => LiveScoreCubit(sl(), sl()));
}
