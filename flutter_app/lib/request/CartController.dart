import 'package:dio/dio.dart';
import 'package:flutter_app/config/service_url.dart';

class CartController {
  Dio _dio;

  CartController(this._dio);

  // 获取购物车
  Future<Response> getCartList() {
    return _dio.post(servicePath['Shop-Shopping_cart-index']);
  }

  // 加入购物车/立即购买
  Future<Response> join(data) {
    return _dio.post(servicePath['Shop-cart-join'], data: data);
  }

  //购物车数量操作
  Future<Response> changegoodsnumbe(data) {
    return _dio.post(servicePath['Shop-Shopping_cart-changeGoodsNumber'],
        data: data);
  }

  //购物车数量操作
  Future<Response> remove(data) {
    return _dio.post(servicePath['Shop-Shopping_cart-remove'],
        data:data
    );
  }

  //购物车全选/全不选
  Future<Response> ischeck(data) {
    return _dio.post(
        servicePath['Shop-Shopping_cart-selectOneShoppingCartGoods'],
        data: data);
  }
}
