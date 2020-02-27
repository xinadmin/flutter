import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:flutter/cupertino.dart';
import '../../provide/details_info.dart';
import '../../provide/currentIndex.dart';
import '../product/BaseDialog.dart';

import 'package:flutter_app/config/common.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:convert';

//商品详情页的首屏区域，包括图片、商品名称，商品价格，商品编号的UI展示
var url = "https://panda36.com";
var num = 1;

class ProductDeatail extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Provide<DetailsInfoProvide>(builder: (context, child, val) {
      var attr = Provide.value<DetailsInfoProvide>(context).goodsInfo["goodsInfo"]['attr'];
      var goodsInfo = Provide.value<DetailsInfoProvide>(context).goodsInfo["goodsInfo"];
      var goodsParam = Provide.value<DetailsInfoProvide>(context).goodsInfo["goodsParam"];
      var index = Provide.value<DetailsInfoProvide>(context).goodsInfo["specindex"];

      var checkvalue = Provide.value<DetailsInfoProvide>(context).goodsInfo["checkvalue"];

      if (attr.length > 0) {
        return Container(
          width: ScreenUtil().setWidth(750),
          child: Column(
            children: <Widget>[
              Container(
                width: ScreenUtil().setWidth(750),
                child: Text(
                  goodsInfo['localeGoodsName'],
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Color.fromRGBO(48, 49, 51, 1),
                  ),
                ),
                color: Colors.white,
                padding: EdgeInsets.fromLTRB(15, 0, 15, 5),
              ),
              Container(
                color: Colors.white,
                padding: EdgeInsets.fromLTRB(15, 0, 15, 5),
                child: Row(
                  children: <Widget>[
                    Text(
                      'Цена товара：',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Color.fromRGBO(236, 56, 56, 1),
                      ),
                    ),
                    Text(
                      tranFrom(attr[index]['goods_price']),
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Color.fromRGBO(236, 56, 56, 1),
                      ),
                    ),
                    Text(
                      '(БАЛЛОВ：',
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Color.fromRGBO(48, 49, 51, 1),
                      ),
                    ),
                    Text(
                      attr[index]['goods_price'] + '）',
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Color.fromRGBO(48, 49, 51, 1),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: ScreenUtil().setHeight(50),
                width: ScreenUtil().setWidth(1250),
                child: Stack(
                  children: <Widget>[
                    Container(
                      child: Text(
                        'Объем продаж: ' + attr[index]['sales_sum'],
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Color.fromRGBO(144, 147, 153, 1),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Text(
                        'Запас:' + attr[index]['inventory_quantity'],
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Color.fromRGBO(144, 147, 153, 1),
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
                color: Colors.white,
                padding: EdgeInsets.fromLTRB(15, 0, 15, 5),
              ),
              _otherPoint(context, attr),
              _spec(checkvalue),
              SizedBox(
                height: 10.0,
              ),
              _goodsparms(context:context,goodsParam:goodsParam),
              SizedBox(
                height: 10.0,
              ),
              Container(
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    Padding(
                      child: Text(
                        'Описание товара',
                        style: TextStyle(
                          color: Color.fromRGBO(236, 56, 56, 1),
                          fontSize: 22.0,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    ),
                    Html(
                      data: goodsInfo["localeGoodsDesc"],
//            data:changeImg(localeGoodsDesc)
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      } else {
        return AspectRatio(
          aspectRatio: 1,
          child: Image.network(
            'https://panda36.com/static/panda36/assets/img/m/panda.png',
            fit: BoxFit.fill,
          ),
        );
      }
    }
    );
  }
  Widget _goodsparms({BuildContext context,var goodsParam}){
    if(goodsParam.length==0){
      return Container(
        height: 0,
      );
    }
    return Container(
      color: Colors.white,
      child: InkWell(
        onTap: () {
          _showDialog(context: context, index: 0, goodsParam: goodsParam);
        },
        child: ListTile(
          title: Text(
            'Характеристики продукта',
            style: TextStyle(
              fontSize: 18.0,
              color: Color.fromRGBO(96, 98, 102, 1),
            ),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            color: Color.fromRGBO(136, 136, 136, 1),
            size: 17.0,
          ),),
      ),

    );
  }
  Widget _spec(var checkvalue) {
    if (checkvalue != "") {
      return Column(
        children: <Widget>[
          SizedBox(
            height: 10.0,
          ),
          Container(
            color: Colors.white,
            child: ListTile(
              title: Text(
                'Выбранные：' + checkvalue.toString(),
                style: TextStyle(
                  fontSize: 18.0,
                  color: Color.fromRGBO(96, 98, 102, 1),
                ),
              ),
            ),
          ),
        ],
      );
    } else {
      return Container();
    }
  }
//所有积分类型
  Widget _otherPoint(BuildContext context, List item) {
    var userInfo = Provide
        .value<CurrentIndexProvide>(context)
        .userinfo;
    var isLogin = Provide
        .value<CurrentIndexProvide>(context)
        .isLogin;
    if (!isLogin) {
      return Container(
        height: 2.0,
        color: Colors.white,
      );
    } else {
      return Column(
        children: <Widget>[
          _point(
            int.parse(userInfo['member_level']),
            item,
            'system_award_integral',
            '可用奖励积分',
            0,
          ),
          _point(int.parse(userInfo['member_level']), item, 'award_integral',
              '可返还奖励积分', 0),
          _point(
              int.parse(userInfo['member_level']), item, 'money', '可返还现金积分:',
              '1'),
          _point(
              int.parse(userInfo['member_level']), item, 'goods_pv', 'pv',
              '1')
        ],
      );
    }
  }
//遍历积分，返还积分，现金积分，pv
  Widget _point(var level, var item, var title, var subtitle, var isshow) {
    print(level);
    if (level == 0) {
      if (isshow == 0) {
        print(level);
        return Container(
          width: ScreenUtil().setWidth(1250),
          child: Text(
            subtitle + ': ' + item[index][title].toString(),
            style: TextStyle(
              fontSize: 16.0,
              color: Color.fromRGBO(144, 147, 153, 1),
            ),
          ),
          color: Colors.white,
          padding: EdgeInsets.fromLTRB(15, 0, 15, 10),
        );
      } else {
        return SizedBox(
          height: 0,
        );
      }
    } else {
      return Container(
        width: ScreenUtil().setWidth(1250),
        child: Text(
          subtitle + ': ' + item[index][title].toString(),
          style: TextStyle(
            fontSize: 16.0,
            color: Color.fromRGBO(144, 147, 153, 1),
          ),
        ),
        color: Colors.white,
        padding: EdgeInsets.fromLTRB(15, 0, 15, 10),
      );
    }
  }
//  显示商品参数
  _showDialog({BuildContext context, var attr, int index, var goodsParam}) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return SureDialog(item: attr, isSelectDiglog: index,goodsParam:goodsParam,isbuy:"");
        });
  }
}

//class DetailsBottom extends StatefulWidget {
//  @override
//  DetailsBottomState createState() => new DetailsBottomState();
//}
//
//class DetailsBottomState extends State<DetailsBottom> {
//  @override
//  Widget build(BuildContext context) {
//    return Provide<DetailsInfoProvide>(builder: (context, child, val) {
//      var attr = Provide
//          .value<DetailsInfoProvide>(context)
//          .goodsInfo["goodsInfo"]['attr'];
//      var isLogin = Provide
//          .value<CurrentIndexProvide>(context)
//          .isLogin;
//       return Container(
//        decoration: BoxDecoration(
//          color: Color.fromRGBO(255, 255, 255, 0.9),
//          borderRadius: BorderRadius.circular(8.0),
//        ),
//        width: ScreenUtil().setWidth(670),
//        margin: EdgeInsets.fromLTRB(25, 0, 25, 0),
//        padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
//        height: ScreenUtil().setHeight(110),
//        child: Row(
//          children: <Widget>[
//            InkWell(
//              onTap: () {
//                Provide.value<CurrentIndexProvide>(context).changeIndex(0);
//                Navigator.pushNamed(context, '/');
//              },
//              child: Container(
//                  alignment: Alignment.center,
//                  child: Column(
//                    mainAxisAlignment: MainAxisAlignment.center,
//                    crossAxisAlignment: CrossAxisAlignment.center,
//                    children: <Widget>[
//                      Icon(
//                        CupertinoIcons.home,
//                        size: 25,
//                        color: Color.fromRGBO(144, 147, 153, 1),
//                      ),
//                      Text(
//                        'Главная',
//                        style: TextStyle(
//                          color: Color.fromRGBO(144, 147, 153, 1),
//                          fontSize: 15.0,
//                        ),
//                      ),
//                    ],
//                  )),
//            ),
//            InkWell(
//              onTap: () {
//                Navigator.pushNamed(context, '/cart');
//              },
//              child: Container(
//                  alignment: Alignment.center,
//                  padding: EdgeInsets.fromLTRB(3, 0, 3, 0),
//                  child: Column(
//                    mainAxisAlignment: MainAxisAlignment.center,
//                    crossAxisAlignment: CrossAxisAlignment.center,
//                    children: <Widget>[
//                      Icon(
//                        Icons.shopping_cart,
//                        size: 25,
//                        color: Color.fromRGBO(144, 147, 153, 1),
//                      ),
//                      Text(
//                        'Корзина',
//                        style: TextStyle(
//                          color: Color.fromRGBO(144, 147, 153, 1),
//                          fontSize: 15.0,
//                        ),
//                      ),
//                    ],
//                  )),
//            ),
//            Container(
//              decoration: BoxDecoration(
//                gradient: const LinearGradient(colors: [
//                  Color.fromRGBO(255, 172, 48, 1),
//                  Color.fromRGBO(250, 67, 106, 1),
//                  Color.fromRGBO(245, 108, 108, 1)
//                ]),
//                borderRadius: BorderRadius.circular(20.0),
//              ),
//              child: Row(
//                children: <Widget>[
//                  InkWell(
//                    onTap: () {
//                      _showDialog(attr: attr, index: 2);
//
////              await Provide.value<CartProvide>(context).save(goodsID,goodsName,count,price,images);
//                    },
//                    child: Container(
//                      alignment: Alignment.center,
//                      width: ScreenUtil().setWidth(200),
//                      height: ScreenUtil().setHeight(80),
//                      padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
//                      child: Text(
//                        'Купить сейчас',
//                        style: TextStyle(
//                          color: Colors.white,
//                          fontSize: ScreenUtil().setSp(28),
//                        ),
//                        textAlign: TextAlign.center,
//                      ),
//                    ),
//                  ),
//                  InkWell(
//                    onTap: () {
//                      _showDialog(attr: attr, index: 1);
////              await Provide.value<CartProvide>(context).remove();
//                    },
//                    child: Container(
//                      alignment: Alignment.center,
//                      width: ScreenUtil().setWidth(200),
//                      height: ScreenUtil().setHeight(80),
//                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
//                      child: Text(
//                        'Добавить в корзину',
//                        style: TextStyle(
//                            color: Colors.white,
//                            fontSize: ScreenUtil().setSp(28)),
//                      ),
//                    ),
//                  ),
//                ],
//              ),
//            ),
//          ],
//        ),
//      );
//    });
//  }
//
//  _showDialog({var attr, int index = 1, var goodsParam}) {
//    showDialog(
//        context: context,
//        barrierDismissible: false,
//        builder: (BuildContext context) {
//          return SureDialog(
//              item: attr, isSelectDiglog: index, goodsParam: goodsParam);
//        });
//  }
//
//  @override
//  void initState() {
//    // TODO: implement initState
//    super.initState();
//  }
//
//  @override
//  void dispose() {
//    // TODO: implement dispose
//    super.dispose();
//  }
//
//  @override
//  void didUpdateWidget(DetailsBottom oldWidget) {
//    // TODO: implement didUpdateWidget
//    super.didUpdateWidget(oldWidget);
//  }
//
//  @override
//  void didChangeDependencies() {
//    // TODO: implement didChangeDependencies
//    super.didChangeDependencies();
//  }
//}

//class SureDialog extends Dialog {
//  String message;
//  Function onCloseEvent;
//  Function sureEvent;
//  int isSelectDiglog = 1;
//  Set goodsParam = {};
//  var item;
//
//  SureDialog({this.item, this.isSelectDiglog, this.goodsParam});
//
//  @override
//  Widget build(BuildContext context) {
//    // TODO: implement build
//    return DigContent(context);
//  }
//
////  规格组件
//  Widget attrWidget(BuildContext context, var attr) {
////    List<String> Morespec = [];
////    var goods_attr_key = Provide
////        .value<DetailsInfoProvide>(context)
////        .goodsInfo["goodsInfo"]['goods_attr_key'];
////    if (goods_attr_key == "") {
////      return Container(
////        height: 0,
////      );
////    }
////    var isMore = goods_attr_key.contains("_");
////    print(isMore);
////    if(!isMore){
////
////    }
////    else {
////       Morespec=goods_attr_key.split("_");
////    }
////    var series = {};
////    List<String> series_key = goods_attr_key.split('_');
////    print(series_key);
////    var selected = true;
////    for(var i = 0;i<series_key.length;i++){
////      series[i] = [];
//////      print(i.toString() + ' - ' + series_key[i].toString());
////      series[i] = attr.map((value) {
////        for (var j = 0; j < series[i].length; j++) {
////          if (series[item][j]['value'] == value.goods_attr_value.split('_')[i]) {
////            return;
////          }
////        }
////        if (key == 0) {
////          var selected = true;
////        } else {
////          var selected = false;
////        }
////        return series[key].push({
////          'value': value.goods_attr_value.split('_')[key],
////          'selected': selected
////        });
////      }).toList();
////    }
////    series_key.forEach((key, val) {
////       print(key + ' - ' + val.toString());
////    });
////    series_key.forEach((key, val) {
////      series[key] = [];
////      attr.forEach((key, value) {
////        for (var i = 0; i < series[key].length; i++) {
////          if (series[item][i]['value'] ==
////              value.goods_attr_value.split('_')[key]) {
////            return;
////          }
////        }
////        if (key == 0) {
////          var selected = true;
////        } else {
////          var selected = false;
////        }
////        series[key].push({
////          'value': value.goods_attr_value.split('_')[key],
////          'selected': selected
////        });
////      });
////    });
////    print(series);
//
//    return Container(
//      child: Container(
//        width: ScreenUtil().setWidth(750),
//        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
//        alignment: Alignment.topLeft,
//        margin: EdgeInsets.only(top: 5),
//        child: Column(
//          children: <Widget>[
//            Container(
//              alignment: Alignment.topLeft,
//              padding: EdgeInsets.fromLTRB(0, 3, 0, 3),
//              child: Text(
//                '123132',
//                style: TextStyle(
//                    fontSize: ScreenUtil().setSp(36), color: Colors.black),
//              ),
//            ),
//            Container(
//              alignment: Alignment.topLeft,
//              child: Wrap(
//                children: <Widget>[
//                  Container(
//                    width: 80.0,
//                    margin: EdgeInsets.fromLTRB(0, 0, 4, 4),
//                    child: OutlineButton(
//                      child: Text('L'),
//                      onPressed: () {},
//                    ),
//                  ),
//                  Container(
//                    width: 80.0,
//                    margin: EdgeInsets.fromLTRB(0, 0, 4, 4),
//                    child: OutlineButton(
//                      child: Text('L'),
//                      onPressed: () {},
//                    ),
//                  ),
//                  Container(
//                    width: 80.0,
//                    margin: EdgeInsets.fromLTRB(0, 0, 4, 4),
//                    child: OutlineButton(
//                      child: Text('L'),
//                      onPressed: () {},
//                    ),
//                  ),
//                ],
//              ),
//            )
//          ],
//        ),
//      ),
//    );
//  }
//
////  输入框组件
//  Widget NumWidget(BuildContext context, var attr) {
//    return Container(
//      width: ScreenUtil().setWidth(750),
//      padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
//      height: 90.0,
//      child: Stack(
//        children: <Widget>[
//          Container(
//            alignment: Alignment.topLeft,
//            padding: EdgeInsets.fromLTRB(0, 3, 0, 3),
//            child: Text(
//              'Число',
//              style: TextStyle(
//                  fontSize: ScreenUtil().setSp(36), color: Colors.black),
//            ),
//          ),
//          Positioned(
//            right: 0,
//            child: Wrap(
//              children: <Widget>[
//                Container(
//                  width: 40.0,
//                  height: 40.0,
//                  alignment: Alignment.center,
//                  decoration:
//                  BoxDecoration(color: Color.fromRGBO(245, 245, 245, 1)),
//                  child: IconButton(
//                    icon: Icon(Icons.remove),
//                    padding: EdgeInsets.all(0),
//                    color: Color.fromRGBO(85, 85, 85, 1),
//                    onPressed: () {},
//                  ),
//                ),
//                Container(
//                  width: 50.0,
//                  height: 40.0,
//                  decoration:
//                  BoxDecoration(color: Color.fromRGBO(245, 245, 245, 1)),
//                  child: TextField(
//                    decoration: InputDecoration(
//                      contentPadding: const EdgeInsets.symmetric(vertical: 5.0),
//                      hintText: '1',
//                      border: OutlineInputBorder(borderSide: BorderSide.none),
//                    ),
//                    textAlign: TextAlign.center,
//                    onChanged: (value) {},
//                  ),
//                ),
//                Container(
//                  width: 40.0,
//                  height: 40.0,
//                  alignment: Alignment.center,
//                  decoration:
//                  BoxDecoration(color: Color.fromRGBO(245, 245, 245, 1)),
//                  child: IconButton(
//                    icon: Icon(Icons.add),
//                    color: Color.fromRGBO(85, 85, 85, 1),
//                    padding: EdgeInsets.all(0),
//                    onPressed: () {},
//                  ),
//                ),
//              ],
//            ),
//          )
//        ],
//      ),
//    );
//  }
//
////  弹窗内部内容
//  Widget DigContentInner(BuildContext context) {
//    print(isSelectDiglog);
//    if (isSelectDiglog == 0) {
//      return Container(
//        decoration: BoxDecoration(
//          color: Colors.white,
//          borderRadius: new BorderRadius.vertical(
//              top: Radius.elliptical(10, 10)),
//        ),
//        child: Column(
//          children: <Widget>[
//            Container(
//              width: ScreenUtil().setWidth(750),
//              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
//              child: ListView(
//                children: <Widget>[
//                ],
//              ),
//            ),
//            DigButtonContent(context) //弹窗底部按钮
//          ],
//        ),
//      );
//    }
//    return Container(
//      decoration: BoxDecoration(
//        color: Colors.white,
//        borderRadius: new BorderRadius.vertical(top: Radius.elliptical(10, 10)),
//      ),
//      child: Column(
//        children: <Widget>[
//          Container(
//            child: Row(
//              children: <Widget>[
//                Container(
//                  child: Image.network(
//                    url + item[index]['goods_image'],
//                    height: ScreenUtil().setHeight(140),
//                    width: ScreenUtil().setWidth(140),
//                  ),
//                  margin: EdgeInsets.fromLTRB(10, 0, 15, 10),
//                ),
//                Container(
//                  alignment: Alignment.centerLeft,
//                  child: Column(
//                      crossAxisAlignment: CrossAxisAlignment.start,
//                      children: <Widget>[
//                        Text(
//                          tranFrom(item[index]['goods_price']),
//                          style: TextStyle(
//                            color: Color.fromRGBO(236, 56, 56, 1),
//                            fontSize: 20.0,
//                          ),
//                          textAlign: TextAlign.left,
//                        ),
//                        Padding(
//                          padding: EdgeInsets.fromLTRB(0, 4, 0, 0),
//                          child: Text(
//                            'Запас:' + item[index]['inventory_quantity'],
//                            style: TextStyle(
//                              color: Color.fromRGBO(96, 98, 102, 1),
//                              fontSize: 16.0,
//                            ),
//                            textAlign: TextAlign.left,
//                          ),
//                        ),
//                        Padding(
//                          padding: EdgeInsets.fromLTRB(0, 4, 0, 0),
//                          child: Text(
//                            'Выбранные:' + item[index]['goods_attr_value'],
//                            style: TextStyle(
//                              color: Color.fromRGBO(96, 98, 102, 1),
//                              fontSize: 16.0,
//                            ),
//                            textAlign: TextAlign.left,
//                          ),
//                        ),
//                      ]),
//                )
//              ],
//            ),
//          ),
//          attrWidget(context, item), //规格组件
//          NumWidget(context, item), //输入框组件
//          DigButtonContent(context) //弹窗底部按钮
//        ],
//      ),
//    );
//  }
//
////  弹窗内容
//  Widget DigContent(BuildContext context) {
//    return GestureDetector(
//      onTap: () {
//        Navigator.pop(context);
//      },
//      child: Material(
//        type: MaterialType.transparency, //设置透明的效果
//        child: Stack(
//          children: <Widget>[
//            Positioned(
//              left: 0,
//              bottom: 0,
//              child: SizedBox(
//                //比较常用的一个控件，设置具体尺寸
//                  width: ScreenUtil().setWidth(750),
//                  child: DigContentInner(context)),
//            ),
//          ], // 让子控件显示到中间
//        ),
//      ),
//    );
//  }
//
//  //弹窗底部按钮
//  Widget DigButtonContent(BuildContext context, {int isdefault = 1}) {
//    if (isdefault == 1) {
//      return Container(
//        margin: EdgeInsets.only(bottom: 13),
//        padding: EdgeInsets.only(left: 6, right: 6),
//        child: ButtonContent(context, () {
//          Navigator.pop(context);
//        }, '确定'),
//      );
//    }
//    return Container(
//      margin: EdgeInsets.only(bottom: 13),
//      padding: EdgeInsets.only(left: 6, right: 6),
//      child: Column(
//        mainAxisAlignment: MainAxisAlignment.spaceBetween,
//        children: <Widget>[
//          Container(
//            width: ScreenUtil().setWidth(750),
//            height: ScreenUtil().setHeight(85),
//            decoration: BoxDecoration(
//              borderRadius: BorderRadius.circular(65.0),
//            ),
//            margin:
//            EdgeInsets.only(left: 20, top: 14, right: 20, bottom: 14),
//            child: RaisedButton(
//              onPressed: () {
//                print("123");
//              },
//              elevation: 12,
//              shape: RoundedRectangleBorder(
//                borderRadius: BorderRadius.circular(25),
//              ),
//              color: Color.fromRGBO(236, 56, 56, 1),
//              child: Text(
//                '加入购物车',
//                style: TextStyle(
//                  color: Colors.white,
//                  fontSize: ScreenUtil().setSp(36),
//                ),
//              ),
//            ),
//          ),
//          Container(
//            width: ScreenUtil().setWidth(750),
//            height: ScreenUtil().setHeight(85),
//            decoration: BoxDecoration(
//              borderRadius: BorderRadius.circular(65.0),
//            ),
//            margin:
//            EdgeInsets.only(left: 20, top: 14, right: 20, bottom: 14),
//            child: RaisedButton(
//              onPressed: () {
//                print("123");
//              },
//              elevation: 12,
//              shape: RoundedRectangleBorder(
//                borderRadius: BorderRadius.circular(25),
//              ),
//              color: Color.fromRGBO(236, 56, 56, 1),
//              child: Text(
//                '立即购买',
//                style: TextStyle(
//                  color: Colors.white,
//                  fontSize: ScreenUtil().setSp(36),
//                ),
//              ),
//            ),
//          ),
//        ],
//      ),
//    );
//  }
//
////  按钮生成
//  Widget ButtonContent(BuildContext context, Function tap, String buttontext) {
//    return Container(
//      width: ScreenUtil().setWidth(750),
//      height: ScreenUtil().setHeight(85),
//      decoration: BoxDecoration(
//        borderRadius: BorderRadius.circular(65.0),
//      ),
//      margin:
//      EdgeInsets.only(left: 20, top: 14, right: 20, bottom: 14),
//      child: RaisedButton(
//        onPressed: () {
//          tap();
//        },
//        elevation: 12,
//        shape: RoundedRectangleBorder(
//          borderRadius: BorderRadius.circular(25),
//        ),
//        color: Color.fromRGBO(236, 56, 56, 1),
//        child: Text(
//          buttontext,
//          style: TextStyle(
//            color: Colors.white,
//            fontSize: ScreenUtil().setSp(36),
//          ),
//        ),
//      ),
//    );
//  }
//}
