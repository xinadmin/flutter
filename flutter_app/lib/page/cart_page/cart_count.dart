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
      margin: EdgeInsets.only(top:5.0),
      child: NumWidget(context)
    );
  }
  // 减少按钮
  Widget _reduceBtn(context){
    return InkWell(
      onTap: (){
        Provide.value<CartProvide>(context).addOrReduceAction(item,'reduce');
      },
      child: Container(
        width: ScreenUtil().setWidth(45),
        height: ScreenUtil().setHeight(45),
        alignment: Alignment.center,
       
        decoration: BoxDecoration(
          color: item.count>1?Colors.white:Colors.black12,
          border:Border(
            right:BorderSide(width:1,color:Colors.black12)
          )
        ),
        child:item.count>1? Text('-'):Text(' '),
      ),
    );
  }

  //添加按钮
  Widget _addBtn(context){
    return InkWell(
      onTap: (){
        Provide.value<CartProvide>(context).addOrReduceAction(item,'add');
      },
      child: Container(
        width: ScreenUtil().setWidth(45),
        height: ScreenUtil().setHeight(45),
        alignment: Alignment.center,
       
         decoration: BoxDecoration(
          color: Colors.white,
          border:Border(
            left:BorderSide(width:1,color:Colors.black12)
          )
        ),
        child: Text('+'),
      ),
    );
  }

  //中间数量显示区域
  Widget _countArea(){
    return Container(
      width: ScreenUtil().setWidth(70),
      height: ScreenUtil().setHeight(45),
      alignment: Alignment.center,
      color: Colors.white,
       child: Text('${item.count}'),
    );
  }

//  数量显示区域
  Widget NumWidget(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(480),
//      padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
      height: 40.0,
            child: Wrap(
              children: <Widget>[
                Container(
                  width: ScreenUtil().setWidth(50),
                  height: ScreenUtil().setHeight(50),
                  alignment: Alignment.center,
                  decoration:
                  BoxDecoration(color: Color.fromRGBO(245, 245, 245, 1)),
                  child: IconButton(
                    icon: Icon(Icons.remove),
                    padding: EdgeInsets.all(0),
                    color: item.goods_number==1?hex('#d6d6d6'): Color.fromRGBO(85, 85, 85, 1),
                    onPressed: () {
                      if(item.goods_number>1){
                        Provide.value<CartProvide>(context).addOrReduceAction(item,'reduce');
                      }
                    },
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  width: ScreenUtil().setWidth(80),
                  height: ScreenUtil().setHeight(50),
                  decoration:BoxDecoration(
                    color: Color.fromRGBO(245, 245, 245, 1),
                  ),
                  child: Text('${item.goods_number}'),
                ),
                Container(
                  width: ScreenUtil().setWidth(50),
                  height: ScreenUtil().setHeight(50),
                  alignment: Alignment.center,
                  decoration:
                  BoxDecoration(color: Color.fromRGBO(245, 245, 245, 1)),
                  child: IconButton(
                    icon: Icon(Icons.add),
                    color: Color.fromRGBO(85, 85, 85, 1),
                    padding: EdgeInsets.all(0),
                    onPressed: () {
                      Provide.value<CartProvide>(context).addOrReduceAction(item,'add');
                    },
                  ),
                ),
              ],
            ),
    );
  }

}