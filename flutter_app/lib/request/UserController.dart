import 'package:dio/dio.dart';
import 'package:flutter_app/config/service_url.dart';

class UserController {
  Dio _dio;

  UserController(this._dio);

  // 获取个人信息
  Future<Response> index() {
    return _dio.post(servicePath['User-Profile-index']);
  }

  //发送个人资料
  Future<Response> personalData(data) {
    return _dio.post(servicePath['User-profile-profile'],data:data);
  }

  //发送头像
    Future<Response> uploadPhoto(data) {
      return _dio.post(servicePath['User-uploader-upload'],data:data);
    }
  //修改登陆密码
  Future<Response> loginPassword(data) {
    return _dio.post(servicePath['User-profile-changepassword'],data:data);
  }
  //修改安全密码
  Future<Response> safePassword(data) {
    return _dio.post(servicePath['User-profile-changesecuritypassword'],data:data);
  }
  //获取复消积分
  Future<Response> getSpecial(data) {
    return _dio.post(servicePath['Shop-Index-getUserInfo'],data:data);
  }
  //获取复消积分
  Future<Response> aboutMall(data) {
    return _dio.post(servicePath['Shop-Article-index'],data:data);
  }

  //获取用户推荐链接
  Future<Response> getrecommend(data) {
    return _dio.post(servicePath['User-User-recommend1'],data:data);
  }

}
