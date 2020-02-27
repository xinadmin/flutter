import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import 'package:flutter_app/config/common.dart';
import '../../provide/details_info.dart';
import '../../provide/currentIndex.dart';
import '../../service/service_method.dart';
import 'package:fluttertoast/fluttertoast.dart';
var index = 0;
class SureDialog extends StatefulWidget {
  @override
  int isSelectDiglog = 1;
  var goodsParam;
  int isSelectSpec = 0;
  var item;
  String isbuy= "";
  SureDialog({this.item, this.isSelectDiglog, this.goodsParam,this.isbuy});

  SureDialogState createState() => new SureDialogState(item:this.item, isSelectDiglog:this.isSelectDiglog, goodsParam:this.goodsParam,isbuy:this.isbuy);
}

class SureDialogState extends State<SureDialog> {
  @override
  var url = "https://panda36.com";
  Map series = {};
  int isSelectDiglog = 1;
  var goodsParam;
  String isbuy = 'buy';
  int isSelectSpec = 0;
  var item;
  var number = 1;
  var num=TextEditingController();
  SureDialogState({this.item, this.isSelectDiglog, this.goodsParam,this.isbuy});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DigContent(context);
  }
//  规格组件
  Widget attrWidget(BuildContext context) {
    var goods_attr_key = Provide
        .value<DetailsInfoProvide>(context)
        .goodsInfo["goodsInfo"]['goods_attr_key'];
    if (goods_attr_key == "") {
      return Container(
        height: 0,
      );
    }
    var series = Provide.value<DetailsInfoProvide>(context).goodsInfo["series"];
    List<Widget> list = [];
    List<Widget> listattr = []; //先建一个数组用于存放循环生成的widget
    Widget content;
    series.forEach((key, value) {
      listattr = AttrInner(context,key, value);
      list.add(
          Container(
              child: Container(
                width: ScreenUtil().setWidth(750),
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(top: 5),
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.fromLTRB(0, 3, 0, 3),
                      child: Text(
                        key,
                        style: TextStyle(
                            fontSize: ScreenUtil().setSp(36),
                            color: Colors.black),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: Wrap(
                          children: listattr
                      ),
                    ),
                  ],
                ),
              ),
          )
      );
    });
    content = new Column(children: list);
    return content;
    return null;
//      return Container(
//        child: Container(
//          width: ScreenUtil().setWidth(750),
//          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
//          alignment: Alignment.topLeft,
//          margin: EdgeInsets.only(top: 5),
//          child: Column(
//            children: <Widget>[
//              Container(
//                alignment: Alignment.topLeft,
//                padding: EdgeInsets.fromLTRB(0, 3, 0, 3),
//                child: Text(
//                  '123132',
//                  style: TextStyle(
//                      fontSize: ScreenUtil().setSp(36), color: Colors.black),
//                ),
//              ),
//              Container(
//                alignment: Alignment.topLeft,
//                child: Wrap(
//                  children: <Widget>[
//                    Container(
//                      width: 80.0,
//                      margin: EdgeInsets.fromLTRB(0, 0, 4, 4),
//                      child: OutlineButton(
//                        child: Text('L'),
//                        onPressed: () {},
//                      ),
//                    ),
//                    Container(
//                      width: 80.0,
//                      margin: EdgeInsets.fromLTRB(0, 0, 4, 4),
//                      child: OutlineButton(
//                        child: Text('L'),
//                        onPressed: () {},
//                      ),
//                    ),
//                    Container(
//                      width: 80.0,
//                      margin: EdgeInsets.fromLTRB(0, 0, 4, 4),
//                      child: OutlineButton(
//                        child: Text('L'),
//                        onPressed: () {},
//                      ),
//                    ),
//                  ],
//                ),
//              )
//            ],
//          ),
//        ),
//      );
  }
//  选择规格值
  void selectSpec(var childrenindex,var parentindex) {
    Provide.value<DetailsInfoProvide>(context).changeSpecValue(childrenindex,parentindex);
  }
  //遍历规格值
  List<Widget> AttrInner(BuildContext context,var key, List attr) {
      List<Widget> list = [];
      for(var i = 0;i<attr.length;i++){
        list.add(
          Container(
            width: 80.0,
            margin: EdgeInsets.fromLTRB(0, 0, 4, 4),
            child: RaisedButton(
              elevation: 0,
              color:  attr[i]['selected']?Color.fromRGBO(251, 235, 238,1):Color.fromRGBO(238, 238, 238,1),
              child: Text(attr[i]['value'],
                style: TextStyle(
                  color: attr[i]['selected']?Color.fromRGBO(236, 56, 56, 1):Colors.black,
                  fontSize: 15.0,
                ),
              ),
              onPressed: () {
                selectSpec(i,key);
              },
            ),
          ));
      }
    return list.toList();
  }

//  输入框组件
  Widget NumWidget(BuildContext context, var attr) {
    return Container(
      width: ScreenUtil().setWidth(750),
      padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
      height: 90.0,
      child: Stack(
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.fromLTRB(0, 3, 0, 3),
            child: Text(
              'Число',
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(36), color: Colors.black),
            ),
          ),
          Positioned(
            right: 0,
            child: Wrap(
              children: <Widget>[
                Container(
                  width: 40.0,
                  height: 40.0,
                  alignment: Alignment.center,
                  decoration:
                  BoxDecoration(color: Color.fromRGBO(245, 245, 245, 1)),
                  child: IconButton(
                    icon: Icon(Icons.remove),
                    padding: EdgeInsets.all(0),
                    color: Color.fromRGBO(85, 85, 85, 1),
                    onPressed: () {
                      setState(() {
                        if(number==1){
                          return;
                        }else {
                          --number;
                          this.num.text=number.toString();
                        }

                      });
                    },
                  ),
                ),
                Container(
                  width: 50.0,
                  height: 40.0,
                  decoration:
                  BoxDecoration(color: Color.fromRGBO(245, 245, 245, 1)),
                  child: TextField(
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 5.0),
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                    ),
                    controller: num,
                    textAlign: TextAlign.center,
                    onChanged: (value) {},
                  ),
                ),
                Container(
                  width: 40.0,
                  height: 40.0,
                  alignment: Alignment.center,
                  decoration:
                  BoxDecoration(color: Color.fromRGBO(245, 245, 245, 1)),
                  child: IconButton(
                    icon: Icon(Icons.add),
                    color: Color.fromRGBO(85, 85, 85, 1),
                    padding: EdgeInsets.all(0),
                    onPressed: () {
                      setState(() {
                        ++number;
                        this.num.text=number.toString();
                      });
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

// 商品参数
  Widget _getgoodsParam({BuildContext context, Map goodsParam}) {
    List<Widget> list = []; //先建一个数组用于存放循环生成的widget
    Widget content;
    goodsParam.forEach((key, value) {
      list.add(Container(
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    width: 1, color: Color.fromRGBO(242, 242, 242, 1)))),
        padding: EdgeInsets.fromLTRB(3, 7, 3, 7),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(
                key,
              ),
            ),
            Expanded(
              child: Text(
                value,
              ),
            )
          ],
        ),
      ));
    });
    content = new Column(children: list);
    return content;
  }

//  弹窗内部内容
  Widget DigContentInner(BuildContext context) {
//    判断显示商品参数弹窗内容
    if (isSelectDiglog == 0) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
          new BorderRadius.vertical(top: Radius.elliptical(10, 10)),
        ),
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
              child: Text(
                'Параметры продукта',
                style: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 1), fontSize: 22.0),
              ),
            ),
            Container(
              width: ScreenUtil().setWidth(750),
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: _getgoodsParam(context: context, goodsParam: goodsParam),
            ),
            DigButtonContent(context) //弹窗底部按钮
          ],
        ),
      );
    }
//    判断显示商品规格和数量
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: new BorderRadius.vertical(
            top: Radius.elliptical(10, 10)),
      ),
      child: Column(
        children: <Widget>[
          Container(
            child: Row(
              children: <Widget>[
                Container(
                  child: Image.network(
                    url + item[index]['goods_image'],
                    height: ScreenUtil().setHeight(140),
                    width: ScreenUtil().setWidth(140),
                  ),
                  margin: EdgeInsets.fromLTRB(10, 0, 15, 10),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          tranFrom(item[0]['goods_price']),
                          style: TextStyle(
                            color: Color.fromRGBO(236, 56, 56, 1),
                            fontSize: 20.0,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 4, 0, 0),
                          child: Text(
                            'Запас:' + item[0]['inventory_quantity'],
                            style: TextStyle(
                              color: Color.fromRGBO(96, 98, 102, 1),
                              fontSize: 16.0,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 4, 0, 0),
                          child: Text(
                            'Выбранные:' + item[0]['goods_attr_value'],
                            style: TextStyle(
                              color: Color.fromRGBO(96, 98, 102, 1),
                              fontSize: 16.0,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ]),
                )
              ],
            ),
          ),
          attrWidget(context), //规格组件
          NumWidget(context, item), //输入框组件
          DigButtonContent(context) //弹窗底部按钮
        ],
      ),
    );
  }

//  弹窗内容
  Widget DigContent(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Material(
        type: MaterialType.transparency, //设置透明的效果
        child: Stack(
          children: <Widget>[
            Positioned(
              left: 0,
              bottom: 0,
              child: SizedBox(
                //比较常用的一个控件，设置具体尺寸
                  width: ScreenUtil().setWidth(750),
                  child: DigContentInner(context)),
            ),
          ], // 让子控件显示到中间
        ),
      ),
    );
  }

  //弹窗底部按钮
  Widget DigButtonContent(BuildContext context) {
    var attr = Provide.value<DetailsInfoProvide>(context).goodsInfo["goodsInfo"]['attr'];
    var index = Provide.value<DetailsInfoProvide>(context).goodsInfo["specindex"];
    var isLogin = Provide.value<CurrentIndexProvide>(context).isLogin;

    if (isbuy == "") {
      return Container(
        margin: EdgeInsets.only(bottom: 13),
        padding: EdgeInsets.only(left: 6, right: 6),
        child: ButtonContent(context, () {
          Navigator.pop(context);
        }, '确定'),
      );
    }else if (isbuy == "cart"){
        return Container(
          child: ButtonContent(context, () {
            var formData = {
              'goods_id': attr[index],
              'goods_number': num.text,
            };
            request('Shop-cart-join', formData: formData).then((val) {
              print(val);
              if (val['status'] == 0) {
                Fluttertoast.showToast(
                    msg: val['messages'],
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIos: 1,
                    backgroundColor: Colors.black45,
                    textColor: Colors.white,
                    fontSize: 16.0
                );
                Navigator.pop(context);
              }
            });
          }, '加入购物车'),
//
//          width: ScreenUtil().setWidth(750),
//          height: ScreenUtil().setHeight(85),
//          decoration: BoxDecoration(
//            borderRadius: BorderRadius.circular(65.0),
//          ),
//          margin: EdgeInsets.only(left: 20, top: 14, right: 20, bottom: 14),
//          child: RaisedButton(
//            onPressed: () {
//            },
//            elevation: 12,
//            shape: RoundedRectangleBorder(
//              borderRadius: BorderRadius.circular(25),
//            ),
//            color: Color.fromRGBO(236, 56, 56, 1),
//            child: Text(
//              '加入购物车',
//              style: TextStyle(
//                color: Colors.white,
//                fontSize: ScreenUtil().setSp(36),
//              ),
//            ),
//          ),
        );
    }else {
      return Container(
          child: ButtonContent(context, () {
            if(!isLogin){
              Navigator.pushNamed(context,'/login');
              return ;
            }
            var formData = {
              'goods_id': attr[index],
              'goods_number': num.text,
              'type': 'buyNow'
            };
            request('Shop-cart-join', formData: formData).then((val) {
              if (val['status'] == 0) {
                Fluttertoast.showToast(
                    msg: val['messages'],
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIos: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0
                );
                Navigator.pop(context);
              }
            });
          }, '立即购买'),
      );
    }
    return Container(
      margin: EdgeInsets.only(bottom: 13),
      padding: EdgeInsets.only(left: 6, right: 6),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            width: ScreenUtil().setWidth(750),
            height: ScreenUtil().setHeight(85),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(65.0),
            ),
            margin: EdgeInsets.only(left: 20, top: 14, right: 20, bottom: 14),
            child: RaisedButton(
              onPressed: () {
              },
              elevation: 12,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              color: Color.fromRGBO(236, 56, 56, 1),
              child: Text(
                '加入购物车',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: ScreenUtil().setSp(36),
                ),
              ),
            ),
          ),
          Container(
            width: ScreenUtil().setWidth(750),
            height: ScreenUtil().setHeight(85),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(65.0),
            ),
            margin: EdgeInsets.only(left: 20, top: 14, right: 20, bottom: 14),
            child: RaisedButton(
              onPressed: () {
              },
              elevation: 12,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              color: Color.fromRGBO(236, 56, 56, 1),
              child: Text(
                '立即购买',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: ScreenUtil().setSp(36),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

//  按钮生成
  Widget ButtonContent(BuildContext context, Function tap, String buttontext) {
    return Container(
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(85),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(65.0),
      ),
      margin: EdgeInsets.only(left: 20, top: 14, right: 20, bottom: 14),
      child: RaisedButton(
        onPressed: () {
          tap();
        },
        elevation: 12,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        color: Color.fromRGBO(236, 56, 56, 1),
        child: Text(
          buttontext,
          style: TextStyle(
            color: Colors.white,
            fontSize: ScreenUtil().setSp(36),
          ),
        ),
      ),
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.num.text='1';
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void didUpdateWidget(SureDialog oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
}
//class SureDialog extends  StatelessWidget {
//  String message;
//  Function onCloseEvent;
//  Function sureEvent;
//  int isSelectDiglog = 1;
//  var goodsParam;
//  int isSelectSpec = 0;
//  var item;
//  var url = "https://panda36.com";
//  Map series = {};
//  SureDialog({this.item, this.isSelectDiglog, this.goodsParam});
//  var num = TextEditingController;
//
//  @override
//  Widget build(BuildContext context) {
//    // TODO: implement build
//    return DigContent(context);
//  }
//
//
////  规格组件
//  Widget attrWidget(BuildContext context, var attr) {
//    var goods_attr_key = Provide
//        .value<DetailsInfoProvide>(context)
//        .goodsInfo["goodsInfo"]['goods_attr_key'];
//    if (goods_attr_key == "") {
//      return Container(
//        height: 0,
//      );
//    }
//    var isMore = goods_attr_key.contains("_");
//    if (!isMore) {
//      series[isMore] = [];
//      if (attr.length > 0) {
//        attr
//            .asMap()
//            .keys
//            .map((index) {
//          if (index == 0) {
//            series[isMore].push({
//              'value': attr[index]['goods_attr_value'],
//              'selected': true,
//            });
//          } else {
//            series[isMore].push({
//              'value': attr[index]['goods_attr_value'],
//              'selected': false,
//            });
//          }
//        });
//      }
//      else {
//        return Container(
//          height: 0,
//        );
//      }
//    }
//    else {
//      var series_key = goods_attr_key.split('_');
//      series_key.asMap().forEach((index1, value) {
//        series[series_key[index1]] = [];
//        attr.asMap().forEach((index, value) {
//          for (var i = 0; i < series[series_key[index1]].length; i++) {
//            if (series[series_key[index1]][i]['value'] ==
//                attr[index]['goods_attr_value'].split('_')[index1]) {
//              return;
//            }
//          }
//          if (index == 0) {
//            series[series_key[index1]].add({
//              'value': attr[index]['goods_attr_value'].split('_')[index1],
//              'selected': true,
//            });
//          }
//          else {
//            series[series_key[index1]].add({
//              'value': attr[index]['goods_attr_value'].split('_')[index1],
//              'selected': false,
//            });
//          }
//        });
//      });
//    }
//    List<Widget> list = [];
//    List<Widget> listattr = []; //先建一个数组用于存放循环生成的widget
//    Widget content;
//    series.forEach((key, value) {
//      listattr = AttrInner(context,key, value);
//      list.add(
//          Container(
//              child: Container(
//                width: ScreenUtil().setWidth(750),
//                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
//                alignment: Alignment.topLeft,
//                margin: EdgeInsets.only(top: 5),
//                child: Column(
//                  children: <Widget>[
//                    Container(
//                      alignment: Alignment.topLeft,
//                      padding: EdgeInsets.fromLTRB(0, 3, 0, 3),
//                      child: Text(
//                        key,
//                        style: TextStyle(
//                            fontSize: ScreenUtil().setSp(36),
//                            color: Colors.black),
//                      ),
//                    ),
//                    Container(
//                      alignment: Alignment.topLeft,
//                      child: Wrap(
//                          children: listattr
//                      ),
//                    ),
//                  ],
//                ),
//              ),
//          )
//      );
//    });
//    content = new Column(children: list);
//    return content;
//    return null;
////      return Container(
////        child: Container(
////          width: ScreenUtil().setWidth(750),
////          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
////          alignment: Alignment.topLeft,
////          margin: EdgeInsets.only(top: 5),
////          child: Column(
////            children: <Widget>[
////              Container(
////                alignment: Alignment.topLeft,
////                padding: EdgeInsets.fromLTRB(0, 3, 0, 3),
////                child: Text(
////                  '123132',
////                  style: TextStyle(
////                      fontSize: ScreenUtil().setSp(36), color: Colors.black),
////                ),
////              ),
////              Container(
////                alignment: Alignment.topLeft,
////                child: Wrap(
////                  children: <Widget>[
////                    Container(
////                      width: 80.0,
////                      margin: EdgeInsets.fromLTRB(0, 0, 4, 4),
////                      child: OutlineButton(
////                        child: Text('L'),
////                        onPressed: () {},
////                      ),
////                    ),
////                    Container(
////                      width: 80.0,
////                      margin: EdgeInsets.fromLTRB(0, 0, 4, 4),
////                      child: OutlineButton(
////                        child: Text('L'),
////                        onPressed: () {},
////                      ),
////                    ),
////                    Container(
////                      width: 80.0,
////                      margin: EdgeInsets.fromLTRB(0, 0, 4, 4),
////                      child: OutlineButton(
////                        child: Text('L'),
////                        onPressed: () {},
////                      ),
////                    ),
////                  ],
////                ),
////              )
////            ],
////          ),
////        ),
////      );
//  }
////  遍历规格值
//  void selectSpec(var childrenindex,var parentindex) {
//    var list = this.series;
//    print(list[parentindex]);
//    list[parentindex].forEach((key,value) {
//  print(value['selected']);
//      //      print(value['selected']);
////      value['selected']=false;
//    });
////    list[parentindex][childrenindex]['selected']=true;
////    print(list[parentindex]);
//    this.series=list;
//  }
//    List<Widget> AttrInner(BuildContext context,var key, List attr) {
//      List<Widget> list = [];
//      for(var i = 0;i<attr.length;i++){
//        list.add(
//          Container(
//            width: 80.0,
//            margin: EdgeInsets.fromLTRB(0, 0, 4, 4),
//            child: RaisedButton(
//              elevation: 0,
//              color:  attr[i]['selected']?Color.fromRGBO(251, 235, 238,1):Color.fromRGBO(238, 238, 238,1),
//              child: Text(attr[i]['value'],
//                style: TextStyle(
//                  color: attr[i]['selected']?Color.fromRGBO(236, 56, 56, 1):Colors.black,
//                  fontSize: 15.0,
//                ),
//              ),
//              onPressed: () {
//                selectSpec(attr[i],key);
//              },
//            ),
//          ));
//      }
//    return list.toList();
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
//                      contentPadding: const EdgeInsets.symmetric(
//                          vertical: 5.0),
//                      border: OutlineInputBorder(borderSide: BorderSide.none),
//                    ),
//                    controller: num,
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
//                    onPressed: () {
//
//                    },
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
//// 商品参数
//  Widget _getgoodsParam({BuildContext context, Map goodsParam}) {
//    List<Widget> list = []; //先建一个数组用于存放循环生成的widget
//    Widget content;
//    goodsParam.forEach((key, value) {
//      list.add(Container(
//        decoration: BoxDecoration(
//            border: Border(
//                bottom: BorderSide(
//                    width: 1, color: Color.fromRGBO(242, 242, 242, 1)))),
//        padding: EdgeInsets.fromLTRB(3, 7, 3, 7),
//        child: Row(
//          children: <Widget>[
//            Expanded(
//              child: Text(
//                key,
//              ),
//            ),
//            Expanded(
//              child: Text(
//                value,
//              ),
//            )
//          ],
//        ),
//      ));
//    });
//    content = new Column(children: list);
//    return content;
//  }
//
////  弹窗内部内容
//  Widget DigContentInner(BuildContext context) {
//    if (isSelectDiglog == 0) {
//      return Container(
//        decoration: BoxDecoration(
//          color: Colors.white,
//          borderRadius:
//          new BorderRadius.vertical(top: Radius.elliptical(10, 10)),
//        ),
//        child: Column(
//          children: <Widget>[
//            Container(
//              padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
//              child: Text(
//                'Параметры продукта',
//                style: TextStyle(
//                    color: Color.fromRGBO(0, 0, 0, 1), fontSize: 22.0),
//              ),
//            ),
//            Container(
//              width: ScreenUtil().setWidth(750),
//              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
//              child: _getgoodsParam(context: context, goodsParam: goodsParam),
//            ),
//            DigButtonContent(context) //弹窗底部按钮
//          ],
//        ),
//      );
//    }
//    return Container(
//      decoration: BoxDecoration(
//        color: Colors.white,
//        borderRadius: new BorderRadius.vertical(
//            top: Radius.elliptical(10, 10)),
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
//                          tranFrom(item[0]['goods_price']),
//                          style: TextStyle(
//                            color: Color.fromRGBO(236, 56, 56, 1),
//                            fontSize: 20.0,
//                          ),
//                          textAlign: TextAlign.left,
//                        ),
//                        Padding(
//                          padding: EdgeInsets.fromLTRB(0, 4, 0, 0),
//                          child: Text(
//                            'Запас:' + item[0]['inventory_quantity'],
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
//                            'Выбранные:' + item[0]['goods_attr_value'],
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
//            margin: EdgeInsets.only(left: 20, top: 14, right: 20, bottom: 14),
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
//            margin: EdgeInsets.only(left: 20, top: 14, right: 20, bottom: 14),
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
//  Widget ButtonContent(BuildContext context, Function tap,
//      String buttontext) {
//    return Container(
//      width: ScreenUtil().setWidth(750),
//      height: ScreenUtil().setHeight(85),
//      decoration: BoxDecoration(
//        borderRadius: BorderRadius.circular(65.0),
//      ),
//      margin: EdgeInsets.only(left: 20, top: 14, right: 20, bottom: 14),
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
