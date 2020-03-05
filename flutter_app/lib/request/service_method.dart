import "package:dio/dio.dart";
import 'dart:async';
import '../config/service_url.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';
import '../config/common.dart';
const httpHeaders = {
  'content-type': 'application/x-www-form-urlencoded'
};

Future request(url, {formData}) async {
  try {
    Response response;
    Dio dio = new Dio();
    var cookieJar=CookieJar();
    dio.interceptors.add(CookieManager(cookieJar));
    dio.options.headers = httpHeaders;

//    print(cookieJar.loadForRequest(Uri.parse(serviceUrl + servicePath[url])));
    print(serviceUrl + servicePath[url]);
    if (formData == null) {
      response = await dio.post(serviceUrl + servicePath[url]);
    } else {
      response = await dio.post(serviceUrl + servicePath[url], data: formData);
    }
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('后端接口出现异常，请检测代码和服务器情况.........');
    }
  } catch (e) {
    return print('ERROR:======>${e}');
  }
}
