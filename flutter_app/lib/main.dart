import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:provide/provide.dart';
//import 'package:flutter _app/provide/child_category.dart';
import 'package:flutter_app/provide/category_goods_list.dart';
import 'package:flutter_app/provide/details_info.dart';
import 'package:flutter_app/provide/cart.dart';
import 'package:flutter_app/provide/currentIndex.dart';
import 'package:flutter_app/provide/counter.dart';
import 'package:flutter_app/routers/routes.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_app/utils/global.dart';
import 'package:flutter_app/request/Api.dart';
import 'package:flutter_app/config/common.dart';

void main() {
//  var childCategory = ChildCategory();
  var categoryGoodsListProvide = CategoryGoodsListProvide();
  var detailsInfoProvide = DetailsInfoProvide();
  var cartProvide = CartProvide();
  var currentIndexProvide = CurrentIndexProvide();
  var counter = Counter();
  var providers = Providers();

  providers
//    ..provide(Provider<ChildCategory>.value(childCategory))
    ..provide(
        Provider<CategoryGoodsListProvide>.value(categoryGoodsListProvide))
    ..provide(Provider<DetailsInfoProvide>.value(detailsInfoProvide))
    ..provide(Provider<CartProvide>.value(cartProvide))
    ..provide(Provider<CurrentIndexProvide>.value(currentIndexProvide))
    ..provide(Provider<Counter>.value(counter));

  runApp(ProviderNode(child: MyApp(), providers: providers));
}

class MyApp extends StatelessWidget {
  @override
  List<Cookie> cookies = [];

  Widget build(BuildContext context) {
//    debugPaintSizeEnabled = true;
//    formClean();
    getUserInfo(context);
    return Container(
      child: MaterialApp(
        initialRoute: '/',

        debugShowCheckedModeBanner: false,
        onGenerateRoute: onGenerateRoute,
        theme: ThemeData(
          primaryColor: Color.fromRGBO(236, 56, 56, 1),
        ),
//          home:IndexPage()
      ),
    );
  }

   getUserInfo(context) async {
    cookies = (await Api.cookieJar)
        .loadForRequest(Uri.parse('http://192.168.10.100/m/login/login'));
    if (cookies.length > 0) {
      (await Api.cookieJar).saveFromResponse(
          Uri.parse('http://102.168.10.100/m/login/login'), cookies);
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String user = prefs.getString('user');
    if (user != null && user.isNotEmpty) {
      /// 初始化user
      await G.user.init(json.decode(user));
//      await getUserDetail();
      await Provide.value<CurrentIndexProvide>(context).changelogin(true);
    }
  }
  getUserDetail() async {
    var res = await G.req.user.index();
    var data = res.data;
    Map json = data['data']['user'];
    G.user.init(json);
  }
}
//import 'dart:async';
//
//import 'package:flutter/material.dart';
//import 'package:flutter_easyrefresh/easy_refresh.dart';
////import 'package:flutter_localizations/flutter_localizations.dart';
//
//void main() => runApp(MyApp());
//
//class MyApp extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return new MaterialApp(
//      // App名字
//      title: 'EasyRefresh',
//      // App主题
//      theme: new ThemeData(
//        primarySwatch: Colors.orange,
//      ),
//      // 主页
//      home: _Example(),
//      localizationsDelegates: [
//        GlobalEasyRefreshLocalizations.delegate,
////        GlobalCupertinoLocalizations.delegate,
////        GlobalMaterialLocalizations.delegate,
////        GlobalWidgetsLocalizations.delegate
//      ],
//    );
//  }
//}
//
//class _Example extends StatefulWidget {
//  @override
//  _ExampleState createState() {
//    return _ExampleState();
//  }
//}
//
//class _ExampleState extends State<_Example> {
//  EasyRefreshController _controller;
//
//  // 条目总数
//  int _count = 20;
//
//  @override
//  void initState() {
//    super.initState();
//    _controller = EasyRefreshController();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//        appBar: AppBar(
//          title: Text("EasyRefresh"),
//        ),
//        body:
//        EasyRefresh.custom(
//          enableControlFinishRefresh: false,
//          enableControlFinishLoad: true,
//          controller: _controller,
//          header: ClassicalHeader(),
//          footer: ClassicalFooter(),
//          onRefresh: () async {
//            await Future.delayed(Duration(seconds: 2), () {
//              print('onRefresh');
//              setState(() {
//                _count = 20;
//              });
//              _controller.resetLoadState();
//            });
//          },
//          onLoad: () async {
//            await Future.delayed(Duration(seconds: 2), () {
//              print('onLoad');
//              setState(() {
//                _count += 10;
//              });
//              _controller.finishLoad(noMore: _count >= 40);
//            });
//          },
//          slivers: <Widget>[
//            SliverList(
//              delegate: SliverChildBuilderDelegate(
//                    (context, index) {
//                  return Container(
//                    width: 60.0,
//                    height: 60.0,
//                    child: Center(
//                      child: Text('$index'),
//                    ),
//                    color:
//                    index % 2 == 0 ? Colors.grey[300] : Colors.transparent,
//                  );
//                },
//                childCount: _count,
//              ),
//            ),
//          ],
//        ),
//
//
//        persistentFooterButtons: <Widget>[
//          FlatButton(
//              onPressed: () {
//                _controller.callRefresh();
//              },
//              child: Text("Refresh", style: TextStyle(color: Colors.black))),
//          FlatButton(
//              onPressed: () {
//                _controller.callLoad();
//              },
//              child: Text("Load more", style: TextStyle(color: Colors.black))),
//        ])
//    ;
//  }
//}