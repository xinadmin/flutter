import 'package:dio/dio.dart';
import 'package:flutter_app/config/service_url.dart';

class IndexController {
    Dio _dio;

    IndexController(this._dio);
//  登录
  Future<Response> login(data) {
    return _dio.post(servicePath['Shop-Login-login'],data: data);
  }
  // 注册
  Future<Response> registerPhone(data) {
    return _dio.post(servicePath['Shop-register-register'],data: data);
  }


//忘记密码
  Future<Response> forgetPassword(data) {
    return _dio.post(servicePath['Shop-Lostpwd-send'],data: data);
  }

//登出
  Future<Response> logout() {
    return _dio.post(servicePath['Shop-Login-logout']);
  }

//首页轮播广告图
  Future<Response> index() {
    return _dio.post(servicePath['Shop-Index-index']);
  }

//分类
  Future<Response>  category() {
    return _dio.post(servicePath['Shop-Index-category']);
  }

// 切换语言
  Future<Response>  setlanguage(data) {
    return _dio.post(servicePath['Shop-Index-setlanguage'],data: data);
  }

//活动商品列表
  Future<Response>   actlist() {
    return _dio.post(servicePath['Shop-Index-actlist']);
  }

//用户今日是否已签到
  Future<Response>  isSignIn() {
    return _dio.post(servicePath['User-User-issignin']);
  }

//用户每日签到
  Future<Response>  userSign() {
    return _dio.post(servicePath['User-User-usersignin']);
  }
}