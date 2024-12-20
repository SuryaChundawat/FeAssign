import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../utils/app_constants.dart';
import 'logging_interceptor.dart';

class DioClient {
  final String baseUrl;

  Dio? dio;

  DioClient(this.baseUrl,
      Dio? dioC) {
    dio =  Dio(
      BaseOptions(
        baseUrl: "https://jsonplaceholder.typicode.com/",
      ),
    );
  }

  Future<Response> get(String uri, {
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      debugPrint('URL: ${baseUrl + uri}');
      debugPrint('apiCall ==> url=> $uri ');
      var response = await dio!.get(
        baseUrl+uri,
        onReceiveProgress: onReceiveProgress,
      );
      debugPrint('apiCall ==> url=> $uri \nresponse --->\n$response');
      return response;
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (e) {
      rethrow;
    }
  }


}
