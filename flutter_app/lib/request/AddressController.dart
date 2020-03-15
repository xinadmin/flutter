import 'package:dio/dio.dart';
import 'package:flutter_app/config/service_url.dart';

class AddressController {
  Dio _dio;

  AddressController(this._dio);

// 获取收货地址
  Future<Response> getconsignee() {
    return _dio.post(servicePath['Shop-Shopping_step-getConsignee']);
  }
//更改默认收货地址
  Future<Response> ChangeDefault(data) {
    return _dio.post(servicePath['User-consignee-default'], data: data);
  }

//增加收货地址
  Future<Response> addConsignee(data) {
    return _dio.post(servicePath['User-consignee-add'], data: data);
  }


//修改收货地址
  Future<Response> changeConsignee(data) {
    return _dio.post(servicePath['User-consignee-edit'], data: data);
  }


//删除收货地址
  Future<Response> delConsignee(data) {
    return _dio.post(servicePath['User-consignee-del'], data: data);
  }

}