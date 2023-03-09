import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;

  static void init() {
   
    dio = Dio(
      BaseOptions(
          baseUrl: "https://student.valuxapps.com/api/",
          receiveDataWhenStatusError: true),
    );
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? queryparemeter,
    String lang = 'en',
    String? token,
  }) async {
    dio.options.headers = {
      "Content-Type": "application/json",
      'lang': lang,
      "Authorization": token,
    };
    return await dio.get(url, queryParameters: queryparemeter);
  }

  static Future<Response> postData({
    required String url,
    required dynamic data,
    Map<String, dynamic>? queryparemeter,
    String lang = 'en',
    String? token,
  }) async {
    dio.options.headers = {
      "Content-Type": "application/json",
      "lang": lang,
      "Authorization": token,
    };
    return dio.post(url, data: data, queryParameters: queryparemeter);
  }

  static Future<Response> putData({
    required String url,
    required dynamic data,
    Map<String, dynamic>? queryparemeter,
    String lang = 'en',
    String? token,
  }) async {
    dio.options.headers = {
      "Content-Type": "application/json",
      "lang": lang,
      "Authorization": token,
    };
    return dio.put(url, data: data, queryParameters: queryparemeter);
  }
}
