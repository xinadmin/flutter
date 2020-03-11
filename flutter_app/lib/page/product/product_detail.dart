import 'package:flutter/material.dart';
import 'package:flutter_app/utils/user.dart';
import 'package:provide/provide.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/provide/details_info.dart';
import 'package:flutter_app/provide/currentIndex.dart';
import 'package:flutter_app/page/product/BaseDialog.dart';
import 'package:flutter_app/config/common.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_app/utils/global.dart';
import 'package:flutter_app/jsonserialize/user/data.dart';
//商品详情页的首屏区域，包括图片、商品名称，商品价格，商品编号的UI展示
var num = 1;

class ProductDeatail extends StatelessWidget {
  UserData userInfo = G.user.data;
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
                    fontSize: ScreenUtil().setSp(36),
                    color: Color.fromRGBO(48, 49, 51, 1),
                  ),
                ),
                color: Colors.white,
                padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(30), 0, ScreenUtil().setWidth(30), ScreenUtil().setHeight(10)),
              ),
              Container(
                color: Colors.white,
                padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(30), 0, ScreenUtil().setWidth(30), ScreenUtil().setHeight(10)),
                child: Row(
                  children: <Widget>[
                    Text(
                      'Цена товара:',
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(28),
                        color: Color.fromRGBO(236, 56, 56, 1),
                      ),
                    ),
                    Text(
                      tranFrom(attr[index]['goods_price']),
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(36),
                        color: Color.fromRGBO(236, 56, 56, 1),
                      ),
                    ),
                    Text(
                      '(БАЛЛОВ:',
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(34),
                        color: Color.fromRGBO(48, 49, 51, 1),
                      ),
                    ),
                    Text(
                      attr[index]['goods_price'] + '）',
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(32),
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
                          fontSize: ScreenUtil().setSp(32),
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
                          fontSize: ScreenUtil().setSp(32),
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
                height: ScreenUtil().setHeight(20),
              ),
              _goodsparms(context:context,goodsParam:goodsParam),
              SizedBox(
                height: ScreenUtil().setHeight(20),
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
                          fontSize:  ScreenUtil().setSp(40),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      padding: EdgeInsets.fromLTRB(0,  ScreenUtil().setHeight(20), 0, ScreenUtil().setHeight(20)),
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
              fontSize: ScreenUtil().setSp(36),
              color: Color.fromRGBO(96, 98, 102, 1),
            ),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            color: Color.fromRGBO(136, 136, 136, 1),
            size: ScreenUtil().setSp(34),
          ),),
      ),

    );
  }
  Widget _spec(var checkvalue) {
    if (checkvalue != "") {
      return Column(
        children: <Widget>[
          SizedBox(
            height: ScreenUtil().setWidth(20),
          ),
          Container(
            color: Colors.white,
            child: ListTile(
              title: Text(
                'Выбранные：' + checkvalue.toString(),
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(36),
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
//    var userInfo = Provide
//        .value<CurrentIndexProvide>(context)
//        .userinfo;
    var isLogin = Provide
        .value<CurrentIndexProvide>(context)
        .isLogin;
    if (!isLogin) {
      return Container(
        height: ScreenUtil().setHeight(4),
        color: Colors.white,
      );
    } else {
      return Column(
        children: <Widget>[
          _point(context,
            int.parse(userInfo.member_level),
            item,
            'system_award_integral',
            '可用奖励积分',
            0,
          ),
          _point(context,int.parse(userInfo.member_level), item, 'award_integral',
              '可返还奖励积分', 0),
          _point(context,
              int.parse(userInfo.member_level), item, 'money', '可返还现金积分:',
              '1'),
          _point(context,
              int.parse(userInfo.member_level), item, 'goods_pv', 'pv',
              '1')
        ],
      );
    }
  }
//遍历积分，返还积分，现金积分，pv
  Widget _point(BuildContext context,var level, var item, var title, var subtitle, var isshow) {
    var index = Provide.value<DetailsInfoProvide>(context).goodsInfo["specindex"];
    if (level == 0) {
      if (isshow == 0) {
        return Container(
          width: ScreenUtil().setWidth(750),
          child: Text(
            subtitle + ': ' + item[index][title].toString(),
            style: TextStyle(
              fontSize: ScreenUtil().setSp(32),
              color: Color.fromRGBO(144, 147, 153, 1),
            ),
          ),
          color: Colors.white,
          padding: EdgeInsets.fromLTRB( ScreenUtil().setWidth(30), 0, ScreenUtil().setWidth(30), ScreenUtil().setHeight(10)),
        );
      } else {
        return SizedBox(
          height: 0,
        );
      }
    } else {
      return Container(
        width: ScreenUtil().setWidth(750),
        child: Text(
          subtitle + ': ' + item[index][title].toString(),
          style: TextStyle(
            fontSize:  ScreenUtil().setSp(32),
            color: Color.fromRGBO(144, 147, 153, 1),
          ),
        ),
        color: Colors.white,
        padding: EdgeInsets.fromLTRB( ScreenUtil().setHeight(30), 0, ScreenUtil().setHeight(30), 10),
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