import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_app/utils/global.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';

import 'package:flutter_app/config/common.dart';
import 'package:flutter_app/config/service_url.dart';
import 'package:flutter_app/request/Api.dart';

const httpHeaders = {
  'content-type': 'application/x-www-form-urlencoded',
  'origin':'http://192.168.10.100'
};

/// 初始化dio
//List<Cookie> cookies = [];

Dio initDio() {

  BaseOptions _baseOptions = BaseOptions(
    baseUrl: serviceUrl,
  );
  Dio dio = Dio(_baseOptions);
  dio.options.headers = httpHeaders;
  dio.interceptors.add(
      InterceptorsWrapper(
          onRequest: (RequestOptions options) async {
            dio.interceptors.add(CookieManager(await Api.cookieJar));
            return options;
          },
          onResponse: (Response response) async {
//            print(response.data);
            return response;
          },
          onError: (DioError e) async {
            G.toast(e.message);
            return e; //continue
          }
      )
  );

  return dio;
}
