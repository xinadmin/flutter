import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/provide/details_info.dart';
import 'package:flutter_app/provide/currentIndex.dart';
import 'package:flutter_app/page/product/BaseDialog.dart';
import 'package:flutter_app/config/common.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class DetailsBottom extends StatefulWidget {
  @override
  DetailsBottomState createState() => new DetailsBottomState();
}

class DetailsBottomState extends State<DetailsBottom> {
  @override
  Widget build(BuildContext context) {
    return Provide<DetailsInfoProvide>(builder: (context, child, val) {
      var attr = Provide
          .value<DetailsInfoProvide>(context)
          .goodsInfo["goodsInfo"]['attr'];
      var isLogin = Provide
          .value<CurrentIndexProvide>(context)
          .isLogin;
      return Container(
        decoration: BoxDecoration(
          color: Color.fromRGBO(255, 255, 255, 0.9),
          borderRadius: BorderRadius.circular(8.0),
        ),
        width: ScreenUtil().setWidth(670),
        margin: EdgeInsets.fromLTRB(25, 0, 25, 0),
        padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
        height: ScreenUtil().setHeight(110),
        child: Row(
          children: <Widget>[
            InkWell(
              onTap: () {
                Provide.value<CurrentIndexProvide>(context).changeIndex(0);
                Navigator.pushNamed(context, '/');
              },
              child: Container(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        CupertinoIcons.home,
                        size: 25,
                        color: Color.fromRGBO(144, 147, 153, 1),
                      ),
                      Text(
                        'Главная',
                        style: TextStyle(
                          color: Color.fromRGBO(144, 147, 153, 1),
                          fontSize: 15.0,
                        ),
                      ),
                    ],
                  )),
            ),
            InkWell(
              onTap: () {
                 Navigator.pushNamed(context, '/cart');
              },
              child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.fromLTRB(3, 0, 3, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.shopping_cart,
                        size: 25,
                        color: Color.fromRGBO(144, 147, 153, 1),
                      ),
                      Text(
                        'Корзина',
                        style: TextStyle(
                          color: Color.fromRGBO(144, 147, 153, 1),
                          fontSize: 15.0,
                        ),
                      ),
                    ],
                  )),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [
                  Color.fromRGBO(255, 172, 48, 1),
                  Color.fromRGBO(250, 67, 106, 1),
                  Color.fromRGBO(245, 108, 108, 1)
                ]),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Row(
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      _showDialog(attr: attr, index:1,isbuy:'buy');

//              await Provide.value<CartProvide>(context).save(goodsID,goodsName,count,price,images);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: ScreenUtil().setWidth(200),
                      height: ScreenUtil().setHeight(80),
                      padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                      child: Text(
                        'Купить сейчас',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: ScreenUtil().setSp(28),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      _showDialog(attr: attr, index: 1,isbuy:'cart');
//              await Provide.value<CartProvide>(context).remove();
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: ScreenUtil().setWidth(200),
                      height: ScreenUtil().setHeight(80),
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Text(
                        'Добавить в корзину',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: ScreenUtil().setSp(28)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  _showDialog({var attr, int index = 1,var isbuy}) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return SureDialog(
              item: attr, isSelectDiglog: index,isbuy:isbuy);
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void didUpdateWidget(DetailsBottom oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
}