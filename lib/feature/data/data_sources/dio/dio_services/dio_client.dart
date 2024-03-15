import 'package:dio/dio.dart';
import '../../../../../core/core.dart';
import 'dio_interceptor.dart';
// import 'package:http/http.dart' as http;

class DioClient {
  bool _isUnitTest = false;
  late Dio _dio;

  DioClient({bool isUnitTest = false}) {
    _isUnitTest = isUnitTest;

    _dio = _createDio();

    if (!_isUnitTest) _dio.interceptors.add(DioInterceptor());
  }

  Dio get dio {
    if (_isUnitTest) {
      /// Return static dio if is unit test
      return _dio;
    } else {
      _dio = _createDio();

      if (!_isUnitTest) _dio.interceptors.add(DioInterceptor());

      return _dio;
    }
  }

  Dio _createDio() => Dio(
        BaseOptions(
          baseUrl: baseUrl,
          headers: {
            // 'Content-Type': 'application/json',
            // 'Accept': 'application/json',
            // 'authority': authority,
            // 'origin': 'https://www.varzesh3.com',
            // 'referer': 'https://www.varzesh3.com/',
          },
          receiveTimeout: const Duration(milliseconds: 60000),
          connectTimeout: const Duration(milliseconds: 60000),
          validateStatus: (int? status) {
            return status! > 0;
          },
        ),
      );

  Future<dynamic> getRequest(
    String url, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      return await dio.get(
        url,
        queryParameters: queryParameters,
      );

      // return await http.get(
      //   Uri.parse('https://livescore-api.varzesh3.com/v1.0/livescore/today'),
      //   // Send authorization headers to the backend.
      //   headers: {
      //     'Content-Type': 'application/json',
      //     'Accept': 'application/json',
      //     'authority': 'livescore-api.varzesh3.com',
      //     'origin': 'https://www.varzesh3.com',
      //     'referer': 'https://www.varzesh3.com/'
      //   },
      // );

    } on DioError catch (e) {
      throw Exception(e.message);
    }
  }

  Future<Response> postRequest(
    String url, {
    Map<String, dynamic>? data,
  }) async {
    try {
      return await dio.post(url, data: data);
    } on DioError catch (e) {
      throw Exception(e.message);
    }
  }
}
