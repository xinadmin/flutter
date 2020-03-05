import 'package:dio/dio.dart';
import 'package:flutter_app/config/service_url.dart';

class GoodsController {
  Dio _dio;

  GoodsController(this._dio);

//搜索商品
  Future<Response> searchGoods(data) {
    return _dio.post(servicePath['Shop-Shop-search'], data: data);
  }

// 获取底部商品列表
  Future<Response> goodsList(data) {
    return _dio.post(servicePath['Shop-Shop-goodsList'], data: data);
  }

// 获取推荐商品
  Future<Response> goodsrecommond(data) {
    return _dio.post(servicePath['Shop-Shop-getRecommend'],
        data: data);
  }

// 获取商品详情
  Future<Response> goodsdetail(data) {
    return _dio.post(servicePath['Shop-Shop-getGoodsInfo'],
        data: data);
  }

// 获取商品评价
  Future<Response> getComment(data) {
    return _dio.post(servicePath['Shop-Shop-getComment'],
        data: data);
  }

// 获取评价的商品信息
  Future<Response> getcomments(data) {
    return _dio.post(servicePath['User-Order-getcomment'],
        data: data);
  }

  Future<Response> comment(data) {
    return _dio.post(servicePath['User-Order-comment'], data: data);
  }

//获取商品运费
  Future<Response> getFreight(data) {
    return _dio.post(servicePath['Shop-Shopping_step-getFreight'],
        data: data);
  }

//获取商品参数
  Future<Response> getAttr(data) {
    return _dio.post(servicePath['Shop-Shop-getAttr'], data: data);
  }
}
