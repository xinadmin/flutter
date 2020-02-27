import 'package:flutter/material.dart';

import 'package:provide/provide.dart';
import './provide/child_category.dart';
import './provide/category_goods_list.dart';
import './provide/details_info.dart';
import './provide/cart.dart';
import './provide/currentIndex.dart';
import './provide/counter.dart';
import './routers/routes.dart';
import './config/common.dart';
import './service/service_method.dart';
import 'dart:convert';
void main(){
  var childCategory= ChildCategory();
  var categoryGoodsListProvide= CategoryGoodsListProvide();
  var detailsInfoProvide= DetailsInfoProvide();
  var cartProvide  =CartProvide();
  var currentIndexProvide  =CurrentIndexProvide();
  var counter =Counter();
  var providers  =Providers();

  providers
    ..provide(Provider<ChildCategory>.value(childCategory))
    ..provide(Provider<CategoryGoodsListProvide>.value(categoryGoodsListProvide))
    ..provide(Provider<DetailsInfoProvide>.value(detailsInfoProvide))
    ..provide(Provider<CartProvide>.value(cartProvide))
    ..provide(Provider<CurrentIndexProvide>.value(currentIndexProvide))
    ..provide(Provider<Counter>.value(counter));



  runApp(ProviderNode(child:MyApp(),providers:providers));
}

class MyApp extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    getUserInfo(context);
    return Container(

      child: MaterialApp(
         initialRoute: '/',
          debugShowCheckedModeBanner: false,
          onGenerateRoute:onGenerateRoute,
          theme: ThemeData(
            primaryColor:Color.fromRGBO(236, 56, 56, 1),
          ),
//          home:IndexPage()
      ),
    );
  }
  void getUserInfo(context) async {
    Future<bool> islogin = formBool('isLogin');
    islogin.then((var item){
      print(item);
      if(item==true){
        request('User-Profile-index').then((val) {
          if (val['status'] == 0) {
            print(val['data']["user"]['id']);
            Provide.value<CurrentIndexProvide>(context).changeUserinfo(val['data']["user"]);
          }
        });
      }else {
        print("当前未登陆");
      }
    });
  }

}