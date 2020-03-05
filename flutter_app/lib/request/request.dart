import 'package:dio/dio.dart';
import 'package:flutter_app/request/init_dio.dart';
import 'package:flutter_app/request/IndexController.dart';
import 'package:flutter_app/request/GoodsController.dart';
import 'package:flutter_app/request/CartController.dart';
import 'package:flutter_app/request/UserController.dart';

import 'package:flutter_app/request/OrderController.dart';

class Request {
  Dio _dio;

  Request() {
    _dio = initDio();
  }
//  首页
  IndexController get index => IndexController(_dio);
 //商品列表详情
  GoodsController get goods => GoodsController(_dio);
//购物车
  CartController get cart => CartController(_dio);
// 用户信息
  UserController get user => UserController(_dio);

  OrderController get order => OrderController(_dio);


}
