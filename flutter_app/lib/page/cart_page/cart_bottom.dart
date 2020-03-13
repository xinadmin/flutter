import 'package:flutter/material.dart';
import 'package:flutter_app/model/cartInfo.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import 'package:flutter_app/provide/cart.dart';
import 'package:flutter_app/config/common.dart';
import 'package:flutter_app/provide/currentIndex.dart';
import 'package:flutter_app/utils/global.dart';

class CartBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.fromLTRB(
            ScreenUtil().setWidth(25), 0, ScreenUtil().setWidth(25), 0),
        padding: EdgeInsets.fromLTRB(
            0, ScreenUtil().setWidth(15), 0, ScreenUtil().setWidth(15)),
        width: ScreenUtil().setWidth(700),
        decoration: BoxDecoration(
            color: Color.fromRGBO(255, 255, 255, 0.7),
            borderRadius: BorderRadius.circular(3),
            boxShadow: [
              BoxShadow(
                offset: Offset(0.0, 2.0), //阴影xy轴偏移量
                spreadRadius: 4.0,
                color: Color.fromRGBO(242, 242, 242, 1),
                blurRadius: 5.0,
              )
            ]),
        child: Provide<CartProvide>(
          builder: (context, child, childCategory) {
            return Row(
              children: <Widget>[
                selectAllBtn(context),
                allPriceArea(context),
                goButton(context)
              ],
            );
          },
        ));
  }

  //全选按钮
  Widget selectAllBtn(context) {
    bool isAllCheck = Provide.value<CartProvide>(context).isAllCheck;
    return Container(
      width: ScreenUtil().setWidth(100),
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(
              Icons.check_circle,
              size: ScreenUtil().setSp(56),
              color: isAllCheck
                  ? Color.fromRGBO(236, 56, 56, 1)
                  : Color.fromRGBO(192, 196, 204, 1),
            ),
            onPressed: () {
              var login = Provide.value<CurrentIndexProvide>(context).isLogin;
              if (login) {
                Provide.value<CartProvide>(context)
                    .changeAllCheckBtnState(isAllCheck, context);
              }
            },
          ),
        ],
      ),
    );
  }

  // 合计区域
  Widget allPriceArea(context) {
    double allPrice = Provide.value<CartProvide>(context).allPrice;
    return Container(
      width: ScreenUtil().setWidth(300),
      alignment: Alignment.centerLeft,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                alignment: Alignment.centerRight,
                width: ScreenUtil().setWidth(280),
                child: Text(
                  'Итоговая цена:',
                  style: TextStyle(
                    color: Color.fromRGBO(48, 49, 51, 1),
                    fontSize: ScreenUtil().setSp(36),
                  ),
                ),
              ),
            ],
          ),
          Container(
            width: ScreenUtil().setWidth(330),
            alignment: Alignment.centerRight,
            child: Text(
              tranFrom(allPrice.toString()) + '(' + allPrice.toString() + ")",
              style: TextStyle(
                color: Color.fromRGBO(236, 56, 56, 1),
                fontSize: ScreenUtil().setSp(38),
              ),
            ),
          ),
        ],
      ),
    );
  }

  //结算按钮
  Widget goButton(context) {
    int allGoodsCount = Provide.value<CartProvide>(context).allGoodsCount;
    List<CartInfoMode> cart = Provide.value<CartProvide>(context).cartList;

    return Container(
      width: ScreenUtil().setWidth(300),
      padding: EdgeInsets.fromLTRB(
          ScreenUtil().setWidth(4), 0, ScreenUtil().setWidth(4), 0),
      child: InkWell(
        onTap: () {
          var login = Provide.value<CurrentIndexProvide>(context).isLogin;
          if (!login) {
            Navigator.pushNamed(context, '/login');
            return;
          }
          var isbuy = false;
          for (var i = 0; i < cart.length; i++) {
            if (cart[i].isCheck) {
              isbuy = true;
            }
          }
          if (isbuy) {
            Navigator.pushNamed(context, '/createdOrderPage');
          }
        },
        child: Container(
          padding: EdgeInsets.fromLTRB(
              ScreenUtil().setWidth(10),
              ScreenUtil().setWidth(18),
              ScreenUtil().setWidth(10),
              ScreenUtil().setWidth(18)),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.red, borderRadius: BorderRadius.circular(25.0)),
          child: Text(
            'Оплатить сейчас',
            style: TextStyle(
              color: Colors.white,
              fontSize: ScreenUtil().setSp(31),
            ),
          ),
        ),
      ),
    );
  }
}
