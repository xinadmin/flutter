import 'package:dio/dio.dart';
import 'package:flutter_app/config/service_url.dart';

class OrderController {
  Dio _dio;

  OrderController(this._dio);


//优惠卷支付
  Future<Response> payVoucher() {
    return _dio.post(servicePath['payway-voucher-index.php?u=/Pay']);
  }

  //获取优惠卷
  Future<Response> getVoucherlist() {
    return _dio.post(servicePath['Shop-step-getvoucherlist']);
  }

  //获取订单信息

  Future<Response> step3(data) {
    return _dio.post(servicePath['Shop-Shopping_step-step3'],data:data);
  }

  // 获得购物车中的商品信息列表
  Future<Response> step1() {
    return _dio.post(servicePath['Shop-Shopping_step-step1']);
  }

  //提交订单
  Future<Response> step2(data) {
    return _dio.post(servicePath['Shop-Shopping_step-step2'],data:data);
  }
  //获取订单列表
  Future<Response> getAllOrder(data) {
    return _dio.post(servicePath['User-Order-list'],data:data);
  }
  //获取订单详情
  Future<Response> getAllOrderDetail(data) {
    return _dio.post(servicePath['User-Order-detail'],data:data);
  }
  //获取运费
  Future<Response> getFreight(data) {
    print(data);
    return _dio.post(servicePath['Shop-Shopping_step-getFreight'],data:data);
  }
  //确认收货
    Future<Response> confirmReceipt(data) {
      return _dio.post(servicePath['User-Order-deliveryConfirm'],data:data);
    }

  //猜你喜欢
  Future<Response> guessLike(data) {
    return _dio.post(servicePath['Shop-Shop-getRecommend'],data:data);
  }
}
