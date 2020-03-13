import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import 'package:flutter_app/provide/cart.dart';
import 'package:color_dart/color_dart.dart';

class CartCount extends StatelessWidget {
  var item;
  CartCount(this.item);



  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(280),
      margin: EdgeInsets.only(top:ScreenUtil().setHeight(10)),
      child: NumWidget(context)
    );
  }
//  数量显示区域
  Widget NumWidget(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(480),
      height: 40.0,
            child: Wrap(
              children: <Widget>[
                Container(
                  width: ScreenUtil().setWidth(55),
                  height: ScreenUtil().setHeight(55),
                  alignment: Alignment.center,
                  decoration:
                  BoxDecoration(color: Color.fromRGBO(245, 245, 245, 1)),
                  child: IconButton(
                    icon: Icon(Icons.remove),
                    padding: EdgeInsets.all(0),
                    iconSize: ScreenUtil().setSp(38),
                    color: item.goods_number==1?hex('#d6d6d6'): Color.fromRGBO(85, 85, 85, 1),
                    onPressed: () {
                      if(item.goods_number>1){
                        Provide.value<CartProvide>(context).addOrReduceAction(item,'reduce',context);
                      }
                    },
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  width: ScreenUtil().setWidth(80),
                  height: ScreenUtil().setHeight(55),
                  decoration:BoxDecoration(
                    color: Color.fromRGBO(245, 245, 245, 1),
                  ),
                  child: Text('${item.goods_number}'),
                ),
                Container(
                  width: ScreenUtil().setWidth(55),
                  height: ScreenUtil().setHeight(55),
                  alignment: Alignment.center,
                  decoration:
                  BoxDecoration(color: Color.fromRGBO(245, 245, 245, 1)),
                  child: IconButton(
                    icon: Icon(Icons.add),
                    color: Color.fromRGBO(85, 85, 85, 1),
                    padding: EdgeInsets.all(0),
                    iconSize: ScreenUtil().setSp(38),
                    onPressed: () {
                      Provide.value<CartProvide>(context).addOrReduceAction(item,'add',context);
                    },
                  ),
                ),
              ],
            ),
    );
  }

}